//
//  MJDetailViewController.m
//  CalendarSystem
//
//  Created by Matt Memmo on 8/19/15.
//  Copyright (c) 2015 RWS. All rights reserved.
//  Edited by Chad Carrera on 4/3/2018
//

#import "MJDetailViewController.h"
#import "BuckViewController.h"

@interface MJDetailViewController ()

@end

@implementation MJDetailViewController
@synthesize popDate, number, event;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *integerAsString = [@(dateNum) stringValue];
    event.text = dailyActivity;
    number.text = integerAsString;
    popDate.text=parseSpot3[1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
