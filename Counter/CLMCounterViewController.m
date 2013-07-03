//
//  CLMCounterViewController.m
//  Counter
//
//  Created by Andrew Hulsizer on 7/1/13.
//  Copyright (c) 2013 Classy Monsters. All rights reserved.
//

#import "CLMCounterViewController.h"
#import "CLMCounterCell.h"

#define CLMCounterCellIdentifer @"CLMCounterCellIdentifer"

@interface CLMCounterViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@end

@implementation CLMCounterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CLMCounterCell *cell = (CLMCounterCell *)[tableView dequeueReusableCellWithIdentifier:CLMCounterCellIdentifer];
    
    if (!cell)
    {
        cell = [[CLMCounterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CLMCounterCellIdentifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

@end
