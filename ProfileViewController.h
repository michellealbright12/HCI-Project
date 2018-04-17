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

extern NSArray * createdAt;
extern NSArray * parseSpot3;
extern NSArray * hadSession;
extern NSInteger dateNum;
extern NSString * dailyActivity;

@interface ProfileViewController : UIViewController {
    UserInfo *user;
}

- (IBAction)nextAct:(id)sender;

- (IBAction)prevAct:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthly;

@end
