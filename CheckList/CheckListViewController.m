//
//  CheckListViewController.m
//  CheckList
//
//  Created by hoangpham on 5/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import "CheckListViewController.h"
#import "Checklistitem.h"
#import "CheckList.h"
#import "DatePickerViewController.h"

@interface CheckListViewController ()

@end

@implementation CheckListViewController

/*synthesize*/
@synthesize checkList;


/* add data source for table view*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //count based on items of each check list
    return [self.checkList.items count];
}

/*confiure checkmark*/
- (void)configureCheckMark:(UITableViewCell *)cell withChecklistItem:(Checklistitem *)item
{
    /*
    if(item.checked)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
     */
}

/*configure text for cell*/
- (void) configureTextForCell:(UITableViewCell *)cell withChecklistItem:(Checklistitem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    //label.text = item.text;
    //test object id
    label.text = [NSString stringWithFormat:@"%@",item.text];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckListItem"];
    
    Checklistitem *item = [self.checkList.items objectAtIndex:indexPath.row];
    
    /*configure text for cell*/
    [self configureTextForCell:cell withChecklistItem:item];
    /*configue checkmark*/
    [self configureCheckMark:cell withChecklistItem:item];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*make check mark toggle*/
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    Checklistitem *item = [self.checkList.items objectAtIndex:indexPath.row];
   
    [item toggleChecked];
    [self configureCheckMark:cell withChecklistItem:item];
    
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}

/*add new item to the list*/
- (IBAction)addItem
{
    int newRowIndex = [self.checkList.items count];
    
    Checklistitem *item = [[Checklistitem alloc]init];
    item.text = @"New index";
    item.checked = NO;
    [self.checkList.items addObject:item];
    
    /*add new item to the list*/
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

/*remove item in the list*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.checkList.items removeObjectAtIndex:indexPath.row];
    
    /*delete and save data*/
   
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

/***********/
/*data file*/
/***********/
/*find document directory*/
- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return documentDirectory;
}

/*data file path*/
- (NSString *)dataFilePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
}


/*load checklist items*/


/*init with coder*/


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.checkList.name;
       
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*prepare segue*/
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddItem"])
    {
       
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        NSLog(@"Click Add");
    }else if ([segue.identifier isEqualToString:@"EditItem"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.itemToEdit = sender;
        NSLog(@"Click Edit");

    }    

}


/*delete items*/
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Click edit button");
    Checklistitem *itemToEdit = [self.checkList.items objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"EditItem" sender:itemToEdit];
}





/*implementation of delegate method*/

- (void)addItemViewControllerDidCancel:(ItemDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*adding protocol*/
- (void)addItemViewController:(ItemDetailViewController *)controller didFinishAddingItem:(Checklistitem *)item
{
    int newRowIndex = [self.checkList.items count];
    [self.checkList.items addObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
   
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*editting protocol*/
- (void)addItemViewController:(ItemDetailViewController *)controller didFinishEdittingItem:(Checklistitem *)item
{
    int newRowIndex = [self.checkList.items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self configureTextForCell:cell withChecklistItem:item];
    
  
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
