//
//  AddEvent.m
//  HCI Project
//
//  Created by Michelle Albright on 4/19/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "AddEvent.h"
#import "ProfileViewController.h"

@interface AddEvent ()

@end
NSDate *date;

@implementation AddEvent
@synthesize eventName;
@synthesize datePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitEvent:(id)sender {
    NSString *event = self.eventName.text;
    date = [self.datePicker date];
    UIAlertView *alert;
    if ([event isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Please specify event name"           message:nil
            delegate:self
            cancelButtonTitle:@"OK"
            otherButtonTitles:nil];
        
    }
    else {
        
        [dict setObject:date forKey:event];
        NSLog(@"%@", dict);
        alert = [[UIAlertView alloc] initWithTitle:@"Event Added"
        message:nil
        delegate:self
        cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
    }
    [alert show];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [datePicker resignFirstResponder];
    [eventName resignFirstResponder];
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
