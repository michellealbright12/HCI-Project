//
//  LoginViewController.m
//  HCI Project
//
//  Created by Ian Dieli on 4/1/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)buttontapped:(id)sender; {
    if ([[infodictionary objectForKey:usernamefield.text]isEqualToString:passwordfield.text]) {
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"LOGGEDIN"];
        [self performSegueWithIdentifier:@"Login" sender:self];
    } else {
        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Invalid username or password." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert2 show];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear];
    //infodictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"password", nil] forKeys:[NSArray arrayWithObjects:@"username", nil]];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"LOGGEDIN"] == true) {
        [self performSegueWithIdentifier:@"Login" sender:self];
    }
    // Do any additional setup after loading the view.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    infodictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"password", nil] forKeys:[NSArray arrayWithObjects:@"username", nil]];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"LOGGEDIN"] == true) {
        [self performSegueWithIdentifier:@"Login" sender:self];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
