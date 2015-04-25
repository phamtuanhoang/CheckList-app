//
//  Checklistitem.m
//  CheckList
//
//  Created by hoangpham on 6/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import "Checklistitem.h"
#import "DataModel.h"

@implementation Checklistitem
@synthesize text,checked;
@synthesize itemId,dueDate,shouldRemind;



- (void)toggleChecked
{
    self.checked = !self.checked;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Name"];
        self.checked = [aDecoder decodeBoolForKey:@"Check"];
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.itemId = [aDecoder decodeIntegerForKey:@"ItemID"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"Name"];
    [aCoder encodeBool: self.checked forKey:@"Check"];
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeInt:self.itemId forKey:@"ItemId"];
}

/*check existing notification*/
- (UILocalNotification *)notificationForThisItem
{
    NSArray *allNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in allNotifications)
    {
        NSNumber *number = [notification.userInfo objectForKey:@"ItemID"];
        if (number != nil && [number intValue] == self.itemId)
        {
            return notification;
        }
    }
    return nil;
}

/*schedule new notification*/
- (void) schedueNotification
{
    //handle existing notification
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if(existingNotification != nil)
    {
        NSLog(@"Found an existing notification %@", existingNotification);
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
    
    if (self.shouldRemind && [self.dueDate compare:[NSDate date]] != NSOrderedAscending)
    {
        NSLog(@"Schedule new notification!!");
        UILocalNotification *localNoti = [[UILocalNotification alloc]init];
        localNoti.fireDate = self.dueDate;
        localNoti.timeZone = [NSTimeZone defaultTimeZone];
        localNoti.alertBody = self.text;
        localNoti.soundName = UILocalNotificationDefaultSoundName;
        localNoti.userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:self.itemId] forKey:@"ItemID"];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
    
        NSLog(@"Schedule Notification %@ for itemID %d", localNoti, self.itemId);
    }
}

/*handle delete check list item or entire list */

- (void) dealloc
{
    UILocalNotification *existingNotifications = [self notificationForThisItem];
    if(existingNotifications != nil)
    {
        //cancel existing notification
        NSLog(@"Remove existing notification %@", existingNotifications);
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotifications];
        
    }
}


//assign new ID to object
- (id)init
{
    if (self = [super init])
    {
             self.itemId = [DataModel nextCheckListItemId];
    }
    return self;
}


@end
