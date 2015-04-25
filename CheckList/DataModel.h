//
//  DataModel.h
//  CheckList
//
//  Created by hoangpham on 24/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property(nonatomic, strong) NSMutableArray *lists;

- (void) saveCheckLists;
- (void)setIndexOfSelectedChecklist:(int)index;
- (void)sortCheckLists;
+ (int)nextCheckListItemId;

@end
