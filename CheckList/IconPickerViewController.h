//
//  IconPickerViewController.h
//  CheckList
//
//  Created by hoangpham on 25/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IconPickerViewController;


@protocol IconPickerViewControllerDelegate <NSObject>
- (void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)theIconName;
@end


@interface IconPickerViewController : UITableViewController

@property (nonatomic, weak) id <IconPickerViewControllerDelegate> delegate;

@end
