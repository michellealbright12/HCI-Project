//
//  ViewController.h
//  CalendarSystem
//
//  Created by Matt Memmo on 8/19/15.
//  Copyright (c) 2015 RWS. All rights reserved.
//  Edited by Chad Carrera on 4/3/2018

#import <UIKit/UIKit.h>


extern NSArray * createdAt;
extern NSArray * parseSpot3;
extern NSArray * hadSession;
extern NSInteger dateNum;
extern NSString * dailyActivity;
extern NSString * popupLabel;
extern NSInteger popupDefinition;
extern NSMutableDictionary * dict;


@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *calendarSun;
@property (strong, nonatomic) IBOutlet UILabel *viewLabel;
@property (strong, nonatomic) IBOutlet UIButton *prevLabel;


- (IBAction)nextAct:(id)sender;

- (IBAction)prevAct:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *monthly;


@end

