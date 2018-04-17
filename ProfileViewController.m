//
//  ProfileViewController.m
//  HCI Project
//
//  Created by Ian Dieli on 4/1/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "ProfileViewController.h"

#import "UIViewController+MJPopupViewController.h"
#import "MJDetailViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (IBAction)buttontapped:(id)sender; {
    [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"LOGGEDIN"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    [self grabData];
//    [self myCalView];//don't need if you're using parse. You will call from grabData method
    
    self.navigationItem.hidesBackButton = YES;
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"LOGGEDIN"];
    user = [[UserInfo alloc] initWithFirstName:@"John" withLastName:@"Smith" withIdNum:@"B1111"];
    
    self.firstNameLabel.text = [@"First Name: " stringByAppendingString:user.getFirstName];
    self.lastNameLabel.text = [@"Last Name: " stringByAppendingString:user.getLastName];
    self.idNumLabel.text = [@"ID Number: " stringByAppendingString:user.getIdNum];
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
