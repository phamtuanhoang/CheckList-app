//
//  AllListsViewController.h
//  CheckList
//
//  Created by hoangpham on 16/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"
#import "DataModel.h"

@interface AllListsViewController : UITableViewController<ListDetailViewControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) DataModel *dataModel;

@end
