//
//  AllListsViewController.m
//  CheckList
//
//  Created by hoangpham on 16/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import "AllListsViewController.h"
#import "CheckListViewController.h"
#import "ListDetailViewController.h"
#import "CheckList.h"

@interface AllListsViewController ()
@end

/*global array*/

@implementation AllListsViewController
{
   
}

@synthesize dataModel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*reload data*/
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

//set view to user selection
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    //get user defaults and switch to it
    int index = [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"];
    if (index >= 0 && index < [self.dataModel.lists count]) 
    {
            CheckList *checkList = [self.dataModel.lists objectAtIndex:index];
            [self performSegueWithIdentifier:@"ShowChecklist" sender:checkList];
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel setIndexOfSelectedChecklist:indexPath.row];
    //set user selection
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"ChecklistIndex"];
    
    
    //CheckList *checkList = [lists objectAtIndex:indexPath.row];
    CheckList *checkList = [self.dataModel.lists objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShowChecklist" sender:checkList];
}

/*preapre for segue*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowChecklist"])
    {
        CheckListViewController *controller = segue.destinationViewController;
        controller.checkList = sender;
    }else if ([segue.identifier isEqualToString:@"AddCheckList"])
    {
        UINavigationController *navigation = segue.destinationViewController;
        ListDetailViewController *controller = (ListDetailViewController *)navigation.topViewController;
        controller.delegate = self;
        controller.checklistToEdit = nil;
    }
}

//decoded method
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        self.dataModel = [[DataModel alloc]init];
    }
    return self;
}

/*adding checklist delegate method*/
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(CheckList *)checklist
{
    
    
    [self.dataModel.lists addObject:checklist];
    [self.dataModel sortCheckLists];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*editting check list delegate method*/
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(CheckList *)checklist
{
    //int index = [lists indexOfObject:checklist];
    
    [self.dataModel sortCheckLists];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    //return [lists count];
    return [self.dataModel.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(cell == nil)
    {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //CheckList *checkList = [lists objectAtIndex:indexPath.row];
    CheckList *checkList = [self.dataModel.lists objectAtIndex:indexPath.row];
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    
    label.text = checkList.name;

    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    cell.textLabel.text =checkList.name;
    cell.imageView.image = [UIImage imageNamed:checkList.iconName];
    //check if any pending task
    int count = [checkList countUncheckedItems];
    
    
    if ([checkList.items count] == 0)
    {
        cell.detailTextLabel.text = @"(No Items)";
    }else if (count == 0)
    {
        cell.detailTextLabel.text =  @"All Done!";
    }else
    {
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%d Remainning",[checkList countUncheckedItems]];
    }
    
    return cell;
}
/*implement protocol*/
/*cancel button in add new check list*/

- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller
{
    NSLog(@"Click Cancel add item");
    [self dismissViewControllerAnimated:YES completion:nil];
}



/*delete check list*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[lists removeObjectAtIndex:indexPath.row];
    [self.dataModel.lists removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
/* control accessory button tap*/
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
    
    //CheckList *checklist = [lists objectAtIndex:indexPath.row];
    CheckList *checklist = [self.dataModel.lists objectAtIndex:indexPath.row];
    
    controller.checklistToEdit = checklist;
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

//navigation controller method to detect user press back button
- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(viewController == self)
    {
         [self.dataModel setIndexOfSelectedChecklist:-1];
        [[NSUserDefaults standardUserDefaults]setInteger:-1 forKey:@"ChecklistIndex"];
    }
}



@end
