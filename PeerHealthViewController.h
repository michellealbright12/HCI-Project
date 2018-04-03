//
//  PeerHealthViewController.h
//  HCI Project
//
//  Created by Michelle Albright on 4/3/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface PeerHealthViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *contactBtn;

@end
