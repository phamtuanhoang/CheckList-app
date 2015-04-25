//
//  CheckList.h
//  CheckList
//
//  Created by hoangpham on 18/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckList : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *iconName;

//notification
@property (nonatomic, copy) NSDate *dueDate;
@property (nonatomic, assign) BOOL shouldRemind;
@property (nonatomic, assign) int itemId;

- (int)countUncheckedItems;
@end
