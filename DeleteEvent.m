//
//  ViewController+DeleteEvent.m
//  HCI Project
//
//  Created by Chad Carrera on 4/30/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "DeleteEvent.h"
#import "ProfileViewController.h"

@interface DeleteEvent ()

@end

float buttonWidth = 175.0;
float buttonHeight = 50.0;
NSString *buttonKey;

@implementation DeleteEvent

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self displayEvents];
}

- (void)keep{
    // write your implementation for cancel button here.
    NSLog(@"You decided to keep it, eh?");
}

- (void)delete{
    //write your implementation for ok button here
    //[dict removeObjectForKey:buttonKey];
    //NSMutableDictionary *newDict = dict;
    for (id key in dict) {
        //id anObject = [newDict objectForKey:key];
        if(key == buttonKey){
            [dict removeObjectForKey:key];
        }
    }
    [self displayEvents];
}

- (void)buttonPressed:(UIButton *)button {
    buttonKey = button.titleLabel.text;
    NSLog(@"Button Pressed. Key = %@", buttonKey);
    
    UIAlertController * del_alert = [UIAlertController
                               
                               alertControllerWithTitle:@"Delete Event" message:@"Are you sure you wish to delete this event?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* deleteEvent = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [self delete];
                                    
                                }];
    UIAlertAction* keepEvent = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [self keep];
                                   
                               }];
    
    [del_alert addAction:deleteEvent];
    [del_alert addAction:keepEvent];
    
    [self presentViewController:del_alert animated:YES completion:nil];
    
}
        
    /*
    else {
        numEvents++;
        event = [NSString stringWithFormat:@"%@", event];
        [dict setObject:date forKey:event];
        
        alert = [[UIAlertView alloc] initWithTitle:@"Event Added"
                                           message:nil
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
    }
    [alert show];*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayEvents {
    float x_coord = (self.view.frame.size.width - buttonWidth)/2;
    float start_Y = 145;
    int curr_count = 0;
    
    //Creates the buttons and gives them each a tag (id)
    for (id key in dict) {
        UIButton *showEvent = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        int y_coord = (curr_count * 70) + start_Y;
        
        curr_count++;
        
        // Store the event name and the date
        NSString *eventName = key;
        NSDate *eventDate = [dict objectForKey:key];;
        
        // Format the date and time of the event
        NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEEE, MMM d"];
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"HH:mm"];
        
        [showEvent addTarget:self action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];;
        
        NSString *timeString = [NSString stringWithFormat:@"%@, %@", [dateFormat stringFromDate: eventDate], [timeFormatter stringFromDate:eventDate]];
        //int pop = curr_count;
        showEvent.frame = CGRectMake(x_coord, y_coord, buttonWidth, buttonHeight);
        showEvent.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        // Center the button label!!!!
        showEvent.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to
        [showEvent setTitle:[NSString stringWithFormat: @"%@\n%@", eventName, timeString] forState:UIControlStateNormal];
        [showEvent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        showEvent.backgroundColor = [UIColor grayColor];
        
        [self.view addSubview:showEvent];
    }
    


    /*
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
        numEvents++;
        event = [NSString stringWithFormat:@"%@", event];
        [dict setObject:date forKey:event];
        
        alert = [[UIAlertView alloc] initWithTitle:@"Event Added"
                                           message:nil
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
    }
    [alert show];
    */
    

}


/*
NSDate *addEventOnDate = [NSDate date];
NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
[nowDateFormatter setDateFormat:@"e"];

//key is the event name
//objectForKey:key is the date
BOOL isEvent = false;
for (id key in dict) {
    addEventOnDate = [dict objectForKey:key];
    NSString *addEventDate = [dateFormat stringFromDate:addEventOnDate];
    if ([addEventDate isEqual:selectedDate]) {
        NSString *timeString = [NSString stringWithFormat:@"Time: %@", [timeFormatter stringFromDate:addEventOnDate]];
        
        dailyActivity = [NSString stringWithFormat:@"%@\n%@", key, timeString];;
        isEvent = true;
    }
}
if (!isEvent) {
    dailyActivity = @"No events";
}*/

@end
