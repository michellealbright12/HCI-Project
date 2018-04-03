//
//  MulticulturalViewController.m
//  HCI Project
//
//  Created by Michelle Albright on 4/2/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "MulticulturalViewController.h"

@interface MulticulturalViewController ()

@end

@implementation MulticulturalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _directorEmail.layer.cornerRadius = 10;
    _deanEmail.layer.cornerRadius = 10;
    _directorEmail.clipsToBounds = true;
    _deanEmail.clipsToBounds = true;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)directorEmail:(id)sender {
    MFMailComposeViewController *mailComposer;
    if ([MFMailComposeViewController canSendMail]) {
        
        mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setToRecipients:@[@"bharris@bowdoin.edu"]];
        [self presentViewController:mailComposer animated:YES completion:nil];
    } else {
        NSLog(@"message uploading");
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)deanEmail:(id)sender {
    MFMailComposeViewController *mailComposer;
    if ([MFMailComposeViewController canSendMail]) {
        
        mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setToRecipients:@[@"lamaez@bowdoin.edu"]];
        [self presentViewController:mailComposer animated:YES completion:nil];
    } else {
        NSLog(@"message uploading");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
