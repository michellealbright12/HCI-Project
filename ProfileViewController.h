//
//  ProfileViewController.h
//  HCI Project
//
//  Created by Ian Dieli on 4/1/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "BuckViewController.h"

extern NSArray * created_At;
extern NSArray * parse_Spot3;
extern NSArray * had_Session;
extern NSInteger dateNums;
extern NSString * dailyActivities;
extern NSString * popup_Label;
extern NSString * monthName;

@interface ProfileViewController : UIViewController {
    UserInfo *user;
}

- (IBAction)nextAction:(id)sender;

- (IBAction)prevAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *prevBtn;
@property (strong, nonatomic) IBOutlet UILabel *sunLabel;

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthlyView;

@end
