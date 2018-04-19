//
//  AddEvent.h
//  HCI Project
//
//  Created by Michelle Albright on 4/19/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"

@interface AddEvent : UIViewController<UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *eventName;
@property (strong, nonatomic) IBOutlet UIButton *submitEvent;

@end
