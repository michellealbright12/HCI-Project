//
//  SWAGController.m
//  HCI Project
//
//  Created by Michelle Albright on 4/3/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "SWAGController.h"

@interface SWAGController ()

@end

@implementation SWAGController

- (void)viewDidLoad {
    [super viewDidLoad];
    _title9Button.layer.cornerRadius = 10;
    _title9Button.clipsToBounds = true;
    _contactButton.layer.cornerRadius = 10;
    _contactButton.clipsToBounds = true;
    _transGuideButton.layer.cornerRadius = 10;
    _transGuideButton.clipsToBounds = true;
    _staffButton.layer.cornerRadius = 10;
    _staffButton.clipsToBounds = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)title9BtnTap:(id)sender {
    NSURL *title9url = [NSURL URLWithString:@"http://www.bowdoin.edu/title-ix/index.shtml"];
    [[UIApplication sharedApplication] openURL:title9url options:@{} completionHandler:^(BOOL success) {
        if(success) {
            NSLog(@"opened url");
        }
    }];
}
- (IBAction)contactSWAG:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setToRecipients:@[@"swag@bowdoin.edu"]];
        [self presentViewController:mailComposer animated:YES completion:nil];
    } else {
        printf("No mail account configured\n");
    }
}
- (IBAction)transGuideBtnTap:(id)sender {
    NSURL *transGuideurl = [NSURL URLWithString:@"http://www.bowdoin.edu/sexuality-women-gender/pdf/trans-student-guide.pdf"];
    [[UIApplication sharedApplication] openURL:transGuideurl options:@{} completionHandler:^(BOOL success) {
        if(success) {
            NSLog(@"opened url");
        }
    }];
}



- (IBAction)staffPopup:(id)sender {
    NSString *leanaAmaezTitle = @"Leana Amaez: Associate Dean of Students for Diversity and Inclusion and Co-director of the Sexuality, Women and Gender Center";
    NSString *kateSternTitle = @"Kate Stern: Associate Dean of Students for Diversity and Inclusion and SWAG Co-director";
    NSString *popupMessage = [NSString stringWithFormat:@"%@\r%s\r\r%@\r%s", kateSternTitle,"kstern@bowdoin.edu", leanaAmaezTitle, "lamaez@bowdoin.edu"];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Staff" message:popupMessage  preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:^{
        [alert.view.superview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertControllerBackgroundTapped)]];
    }];
}
- (void)alertControllerBackgroundTapped
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}
@end
