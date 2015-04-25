//
//  DataModel.m
//  CheckList
//
//  Created by hoangpham on 24/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import "DataModel.h"
#import "CheckList.h"

@implementation DataModel

@synthesize lists;



//get document directory
- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

//get data file path
- (NSString *)dataFilePath
{
     return [[self documentsDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
    
}



//save check list
- (void) saveCheckLists
{
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:lists forKey:@"Checklists"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}


//load check list
- (void) loadCheckLists
{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        lists =[unarchiver decodeObjectForKey:@"Checklists"];
        [unarchiver finishDecoding];
    }else
    {
        lists = [[NSMutableArray alloc] initWithCapacity:20];
    }
}

-(void)registerDefaults
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInt:-1], @"ChecklistIndex",
                                [NSNumber numberWithBool:YES], @"FirstTime",
                                [NSNumber numberWithInt:0], @"ChecklistItemId",
                                nil];
    
    [[NSUserDefaults standardUserDefaults]registerDefaults:dictionary];
   
}

//handle first time
- (void)handleFirstTime
{
    
    
    BOOL firstTime = [[NSUserDefaults standardUserDefaults]boolForKey:@"FirstTime"];
    if (firstTime || [self.lists count] == 0 )
    {
       
        CheckList *checkList = [[CheckList alloc] init];
        checkList.name = @"List";
        [lists addObject:checkList];
        [self setIndexOfSelectedChecklist:0];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"FirstTime"];
        
        
    }
}
-(void)sortCheckLists
{
    [self.lists sortUsingSelector:@selector(compare:)];
}

//index of selected check list
-(int)indexOfSelectedCheckList
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"] ;
}
- (void)setIndexOfSelectedChecklist:(int)index
{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"ChecklistIndex"];
}

//method to get next checklist item ID
+ (int)nextCheckListItemId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int itemId = [userDefaults integerForKey:@"ChecklistItemId"];
    [userDefaults setInteger:itemId + 1 forKey:@"ChecklistItemId"];
    [userDefaults synchronize];
    NSLog(@" =>>  %d", itemId + 1);
    return itemId;
    
    
}


- (id)init
{
    if ((self = [super init]))
    {
        [self loadCheckLists];
        [self registerDefaults];
        //if 1st time running
        [self handleFirstTime];
    }
    return  self;
}


@end
