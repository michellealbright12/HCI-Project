//
//  RequestAppointmentCounseling.m
//  HCI Project
//
//  Created by Michelle Albright on 3/29/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "RequestAppointmentCounseling.h"

@interface RequestAppointmentCounseling () {
    NSArray *appointmentList;
    NSString *appointmentType;
}
@end

@implementation RequestAppointmentCounseling
@synthesize availabilityText;
@synthesize notesText;
MFMailComposeViewController *createEmail;

- (void)viewDidLoad {
    [super viewDidLoad];
    _sendBtn.layer.cornerRadius = 10;
    _sendBtn.clipsToBounds = true;
    appointmentList = @[@"Individual Therapy",@"Group Consultation",@"Biofeedback",@"Mindbody Work",@"Other"];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return appointmentList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return appointmentList[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //self.labelText.text = devices[row];
    appointmentType = appointmentList[row];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [availabilityText resignFirstResponder];
    [notesText resignFirstResponder];
}

- (IBAction)requestAppointmentTapped:(id)sender {
    NSString *msgText = availabilityText.text;
    NSString *msgNote = notesText.text;
    
    NSString *msgBody = [NSString stringWithFormat: @"I would like to request an appointment regarding: %@.\nI am available: %@\n\n Notes: %@", appointmentType, msgText, msgNote];
    if ([MFMailComposeViewController canSendMail]) {
        
        createEmail = [[MFMailComposeViewController alloc] init];
        createEmail.mailComposeDelegate = self;
        [createEmail setSubject:@"Appointment Request"];
        [createEmail setToRecipients:@[@"malbrigh@bowdoin.edu"]];
        [createEmail setMessageBody: msgBody isHTML:NO];
        [self presentViewController:createEmail animated:YES completion:nil];
    } else {
        NSLog(@"%@", msgBody);
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
