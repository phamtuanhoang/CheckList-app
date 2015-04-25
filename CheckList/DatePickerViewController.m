//
//  DatePickerViewController.m
//  CheckList
//
//  Created by hoangpham on 27/3/14.
//  Copyright (c) 2014 hoangpham. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController
{
    UILabel *dateLabel;
}

@synthesize tableView;
@synthesize datePicker;
@synthesize delegate;
@synthesize date;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//done button
- (IBAction)done
{
    NSLog(@"Click Done button in datepicker view");
    [self.delegate datePicker:self didPickDate:self.date];
    
}

//cancel button
- (IBAction)cancel
{
    NSLog(@"Click Cancel button in datepicker view");
   [self.delegate datePickerDidCancel:self];
}

//handle view will appear and date changed
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.datePicker setDate:self.date animated:YES];
}

//handle update date label
- (void)updateDateLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    dateLabel.text = [formatter stringFromDate:date];
     NSLog(@"%@",[formatter stringFromDate:date]);
}



//handle date changed
- (IBAction)dateChanged
{
    self.date = [self.datePicker date];
   
    [self updateDateLabel];
}


/* Handle table view display*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:@"DateCell"];
    dateLabel = (UILabel *)[cell viewWithTag:1000];
    
    [self updateDateLabel];
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

/*posititon the table view*/
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 77;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
