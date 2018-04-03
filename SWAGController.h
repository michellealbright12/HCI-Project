//
//  SWAGController.h
//  HCI Project
//
//  Created by Michelle Albright on 4/3/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SWAGController : UIViewController<MFMailComposeViewControllerDelegate, UIPopoverControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *staffButton;
@property (strong, nonatomic) IBOutlet UIButton *title9Button;
@property (strong, nonatomic) IBOutlet UIButton *contactButton;
@property (strong, nonatomic) IBOutlet UIButton *transGuideButton;
- (IBAction)staffPopup:(id)sender;

@end
