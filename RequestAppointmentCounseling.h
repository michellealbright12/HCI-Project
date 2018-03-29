//
//  RequestAppointmentCounseling.h
//  HCI Project
//
//  Created by Michelle Albright on 3/29/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface RequestAppointmentCounseling : UIViewController<MFMailComposeViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UITextField *availabilityText;
@property (strong, nonatomic) IBOutlet UITextField *notesText;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;

@end
