//
//  MulticulturalViewController.h
//  HCI Project
//
//  Created by Michelle Albright on 4/2/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MulticulturalViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *directorEmail;
@property (strong, nonatomic) IBOutlet UIButton *deanEmail;

@end
