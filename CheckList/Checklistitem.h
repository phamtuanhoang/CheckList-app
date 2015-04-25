//
//  Checklistitem.h
//  CheckList
//
//  Created by hoangpham on 6/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklistitem : NSObject <NSCoding>
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;

//used for alarm
@property (nonatomic, copy) NSDate *dueDate;
@property (nonatomic, assign) int itemId;
@property (nonatomic, assign) BOOL shouldRemind;

- (void)toggleChecked;
+ (int)nextCheckListItemId;
- (void)schedueNotification;

@end
