//
//  RequestAppointment.m
//  HCI Project
//
//  Created by Michelle Albright on 3/26/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "RequestAppointmentHealth.h"

@interface RequestAppointment () {
    NSArray *devices;
    NSString *appointmentType;
    //NSArray *days;
    //NSArray *times;
}

@end

@implementation RequestAppointment
@synthesize messageText;
@synthesize noteText;

MFMailComposeViewController *mailComposer;
- (void)viewDidLoad {
    [super viewDidLoad];
    _requestAppointment.layer.cornerRadius = 10;
    _requestAppointment.clipsToBounds = true;
    devices = @[@"Vaccinations",@"Illness",@"Injury",@"OBGYN",@"Other"];
    //days = @[@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday"];
    //times = @[@"Morning",@"Mid-Day",@"Afternoon"];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
   // self.timesTable.delegate = self;
   // self.timesTable.dataSource = self;
   // self.timesTable.allowsMultipleSelection = true;
   // self.daysTable.allowsMultipleSelection = true;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return days.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.dayLabel.text = days[indexPath.row];
    
    if([[tableView indexPathsForSelectedRows] containsObject:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}*/

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return devices.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return devices[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //self.labelText.text = devices[row];
    appointmentType = devices[row];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [messageText resignFirstResponder];
    [noteText resignFirstResponder];
}

- (IBAction)requestAppointmentTapped:(id)sender {
    NSString *msgText = messageText.text;
    NSString *msgNote = noteText.text;
    
    NSString *msgBody = [NSString stringWithFormat: @"I would like to request an appointment regarding: %@.\nI am available: %@\n\n Notes: %@", appointmentType, msgText, msgNote];
    if ([MFMailComposeViewController canSendMail]) {
        
        mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setSubject:@"Appointment Request"];
        [mailComposer setToRecipients:@[@"healthservices@bowdoin.edu"]];
        [mailComposer setMessageBody: msgBody isHTML:NO];
        [self presentViewController:mailComposer animated:YES completion:nil];
    } else {
        NSLog(@"%@", msgBody);
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

