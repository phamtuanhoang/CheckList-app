//
//  AddItemCheckListViewController.h
//  CheckList
//
//  Created by hoangpham on 9/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Checklistitem.h"
#import "DatePickerViewController.h"

@class ItemDetailViewController;
@class Checklistitem;
@class DatePickerViewController;

/*protocol*/
@protocol ItemDetailViewControllerDelegate <NSObject>

- (void)addItemViewControllerDidCancel:(ItemDetailViewController *)controller;

- (void)addItemViewController:(ItemDetailViewController *)controller didFinishAddingItem:(Checklistitem *)item;

- (void)addItemViewController:(ItemDetailViewController *)controller didFinishEdittingItem:(Checklistitem *)item;

@end


@interface ItemDetailViewController : UITableViewController<UITextFieldDelegate,DatePickerViewControllerDelegate >

@property (strong, nonatomic) IBOutlet UITextField *txtAddItem;


@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnAddItemCancel;
/*add property so can refer to delegate*/
@property(nonatomic,weak) id <ItemDetailViewControllerDelegate> delegate;
/*item to edit*/
@property(nonatomic, strong) Checklistitem  *itemToEdit;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

@property (strong, nonatomic) IBOutlet UISwitch *switchControl;
@property (strong, nonatomic) IBOutlet UILabel *dueDateLabel;

-(IBAction)cancel;
-(IBAction)done;
- (IBAction)switchChanged:(UISwitch *)sender;




@end
