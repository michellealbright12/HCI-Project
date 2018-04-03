//
//  LoginSegue.m
//  HCI Project
//
//  Created by Ian Dieli on 4/2/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "LoginSegue.h"

@implementation LoginSegue

- (void)perform {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"LOGGEDIN"] == true) {
        [self.sourceViewController.navigationController pushViewController:self.destinationViewController animated:NO];
    } else {
        [self.sourceViewController.navigationController pushViewController:self.destinationViewController animated:YES];
    }
}

@end
