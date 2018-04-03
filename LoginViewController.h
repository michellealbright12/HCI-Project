//
//  LoginViewController.h
//  HCI Project
//
//  Created by Ian Dieli on 4/1/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController {
    NSDictionary *infodictionary;
}

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


- (IBAction)buttontapped:(id)sender;

@end
