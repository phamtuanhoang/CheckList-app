//
//  CheckList.m
//  CheckList
//
//  Created by hoangpham on 18/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import "CheckList.h"
#import "Checklistitem.h"
#import "DataModel.h"
@implementation CheckList

@synthesize name;
@synthesize items;
@synthesize iconName;
@synthesize dueDate,shouldRemind,itemId;

-(id)init
{
    if((self = [super init]))
    {
        self.items = [[NSMutableArray alloc] initWithCapacity:20];
        self.iconName = @"No Icon";
      
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])) {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
        self.iconName = [aDecoder decodeObjectForKey:@"IconName"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.items forKey:@"Items"];
    [aCoder encodeObject:self.iconName forKey:@"IconName"];
    
}

//compare method
- (NSComparisonResult)compare:(CheckList *)otherChecklist
{
    return [self.name localizedCaseInsensitiveCompare:otherChecklist.name];
}

/*implemnt count check list*/
-(int)countUncheckedItems
{
    int count = 0;
    for(Checklistitem *item in self.items)
    {
        if(item.checked == FALSE)
        {
            count+=1;
        }
    }
    return count;
}
@end
