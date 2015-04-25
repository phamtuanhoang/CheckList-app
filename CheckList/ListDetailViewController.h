//
//  ListDetailViewController.h
//  CheckList
//
//  Created by hoangpham on 18/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconPickerViewController.h"
@class CheckList;
@class ListDetailViewController;


@protocol ListDetailViewControllerDelegate <NSObject>
- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(CheckList *)checklist;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(CheckList *)checklist;
@end


@interface ListDetailViewController : UITableViewController <UITextFieldDelegate, IconPickerViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) CheckList *checklistToEdit;
//for switch and set notification date
@property (nonatomic, strong) IBOutlet UISwitch *switchControl;
@property (nonatomic, strong) IBOutlet UILabel *dueDateLabel;

- (IBAction)cancel;
- (IBAction)done;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;


@end
