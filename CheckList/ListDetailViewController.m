//
//  ListDetailViewController.m
//  CheckList
//
//  Created by hoangpham on 18/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import "ListDetailViewController.h"
#import "CheckList.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController
{
    NSString *iconName;
}
@synthesize  textField;
@synthesize doneBarButton;
@synthesize delegate;
@synthesize checklistToEdit;
@synthesize iconImageView;


//init coder for image
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        iconName = @"Folder";
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    /*check if item exists*/
    if (self.checklistToEdit != nil)
    {
        self.title = @"Edit Checklist";
        self.textField.text= self.checklistToEdit.name;
        self.doneBarButton.enabled = YES;
        iconName = self.checklistToEdit.iconName;
    }
    //if icon name is nil
    self.iconImageView.image = [UIImage imageNamed:iconName];
    
    
}
/*view will appear*/
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel
{
    [self.delegate listDetailViewControllerDidCancel:self];
}

- (IBAction)done
{
    if (self.checklistToEdit == nil)
    {
        CheckList *checkList = [[CheckList alloc] init];
        checkList.name = self.textField.text;
        checkList.iconName = iconName;
        
        [self.delegate listDetailViewController:self didFinishAddingChecklist:checkList];
    }else
    {
        self.checklistToEdit.name = self.textField.text;
        self.checklistToEdit.iconName = iconName;
        
        [self.delegate listDetailViewController:self didFinishEditingChecklist:checklistToEdit];
    }
}
/*select row at index path*/
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.row == 1)
    {
        return indexPath;
    }else
    {
        return nil;
    }
    
}
-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

//prepare for segue to add image
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PickIcon"])
    {
        IconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}
//did pick icon method
-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)theIconName
{
    iconName = theIconName;
    self.iconImageView.image = [UIImage imageNamed:iconName];
    [self.navigationController popViewControllerAnimated:YES];
}




@end
