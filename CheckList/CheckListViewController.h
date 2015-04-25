//
//  CheckListViewController.h
//  CheckList
//
//  Created by hoangpham on 5/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class CheckList;


@interface CheckListViewController : UITableViewController <ItemDetailViewControllerDelegate>
/*declare checklist*/
@property (nonatomic, strong) CheckList *checkList;


-(IBAction)addItem;


@end
