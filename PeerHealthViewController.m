//
//  PeerHealthViewController.m
//  HCI Project
//
//  Created by Michelle Albright on 4/3/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "PeerHealthViewController.h"

@interface PeerHealthViewController ()

@end

@implementation PeerHealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _contactBtn.layer.cornerRadius = 10;
    _contactBtn.clipsToBounds = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)contactBtn:(id)sender {

    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setToRecipients:@[@"cvanloen@bowdoin.edu"]];
        [self presentViewController:mailComposer animated:YES completion:nil];
    } else {
        printf("No mail account configured\n");
    }
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
