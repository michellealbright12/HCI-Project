//
//  SecondViewController.m
//  HCI Project
//
//  Created by Michelle Albright on 3/26/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "HealthCenterViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    _requestBtn.layer.cornerRadius = 10;
_resourcesBtn.layer.cornerRadius = 10;
    _requestBtn.clipsToBounds = true;
    _resourcesBtn.clipsToBounds = true;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
    [super prepareForSegue:segue sender:sender];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)requestAppointmentTapped:(id)sender {
}

- (IBAction)sendEmail:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setSubject:@"Appointment Request"];
    [mailComposer setToRecipients:@[@"malbrigh@bowdoin.edu"]];
        [mailComposer setMessageBody: @"I would like to request an appointment as soon as possible because I have flu symptoms. I am available Wednesdays and Thursdays after 2:30p" isHTML:NO];
    [self presentViewController:mailComposer animated:YES completion:nil];
    } else {
        printf("No mail account configured\n");
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
