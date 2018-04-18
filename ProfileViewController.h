//
//  ProfileViewController.h
//  HCI Project
//
//  Created by Ian Dieli on 4/1/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
<<<<<<< HEAD
#import "BuckViewController.h"

extern NSArray * created_At;
extern NSArray * parse_Spot3;
extern NSArray * had_Session;
extern NSInteger dateNums;
extern NSString * dailyActivities;
extern NSString * popup_Label;
=======
>>>>>>> 4d6f9d4a32336e7b16cf70510b2dd547a63a9634

@interface ProfileViewController : UIViewController {
    UserInfo *user;
}

<<<<<<< HEAD
- (IBAction)nextAction:(id)sender;

- (IBAction)prevAction:(id)sender;

=======
>>>>>>> 4d6f9d4a32336e7b16cf70510b2dd547a63a9634
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthlyView;

@end
