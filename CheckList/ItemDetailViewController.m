//
//  AddItemCheckListViewController.m
//  CheckList
//
//  Created by hoangpham on 9/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Checklistitem.h"
#import "DatePickerViewController.h"


@interface ItemDetailViewController()

@end

@implementation ItemDetailViewController
{
    NSString *text;
    BOOL shouldRemind;
    NSDate *dueDate;
}

@synthesize txtAddItem;
@synthesize delegate;
@synthesize itemToEdit;
@synthesize switchControl;
@synthesize dueDateLabel;
@synthesize doneBarButton;


/*add item view appear*/
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.txtAddItem becomeFirstResponder];
}


//update due date label
- (void) updateDueDateLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSLog(@"Due Date Label: %@",[formatter stringFromDate:dueDate]);
    self.dueDateLabel.text = [formatter stringFromDate:dueDate];
    
}

/*handle update done bar button*/
- (void)updateDoneBarButton
{
    self.doneBarButton.enabled =([text length]>0);
    NSLog(@"in update Bar button");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.itemToEdit != nil) {
        self.title = @"Edit Item";
    }
    
    self.doneBarButton.enabled = NO;
    self.txtAddItem.text = text = self.itemToEdit.text;
    self.switchControl.on = shouldRemind;
    
    [self updateDoneBarButton];
    [self updateDueDateLabel];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(IBAction)cancel
{
   
    /*[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];*/
    [self.delegate addItemViewControllerDidCancel:self];
    
}

-(IBAction)done
{
    if (self.itemToEdit == nil)
    {
        Checklistitem *item = [[Checklistitem alloc]init];
        item.text = self.txtAddItem.text;
        item.checked = FALSE;
        
        //update reminder
        item.shouldRemind = self.switchControl.on;
        item.dueDate = dueDate;
        [item schedueNotification];
        /*[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];*/
        [self.delegate addItemViewController:self didFinishAddingItem:item];
    }else
    {
        self.itemToEdit.text = self.txtAddItem.text;
        //update reminder
        self.itemToEdit.shouldRemind = self.switchControl.on;
        self.itemToEdit.dueDate = dueDate;
        [self.itemToEdit schedueNotification];
        [self.delegate addItemViewController:self didFinishEdittingItem:self.itemToEdit];
        
    }
}


/*prepare for segue*/

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickDate"])
    {
        DatePickerViewController *controller = segue.destinationViewController;
        controller.delegate= self;
        controller.date = dueDate;
        
    }
    
}

/*implement protocol methods of date picker view controller*/
- (void)datePickerDidCancel:(DatePickerViewController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)datePicker:(DatePickerViewController *)picker didPickDate:(NSDate *)date
{
    dueDate = date;

    [self updateDueDateLabel];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*end implementation for protocol methods of date picker view controller*/

/*handle tap due date row */
/*dismiss when click*/
-(NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1)
    {
        return indexPath;
    }else
    {
        return nil;
    }

}

/*handle text editting*/
- (void) textFieldDidEndEditing:(UITextField *)textField
{
    text = textField.text;
    [self updateDoneBarButton];
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"Text Change");
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    text = newText;
    [self updateDoneBarButton];
    return YES;
}

/*handle switch on*/
-(IBAction)switchChanged:(UISwitch *)sender
{
    shouldRemind = sender.on;
}

/*init with coder*/
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        text = @"";
        shouldRemind = NO;
        dueDate = [NSDate date];
    }
    return self;
}


@end
