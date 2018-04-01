//
//  LoginViewController.h
//  HCI Project
//
//  Created by Ian Dieli on 4/1/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController {
    IBOutlet UITextField *usernamefield;
    IBOutlet UITextField *passwordfield;
    
    NSDictionary *infodictionary;
}

- (IBAction)buttontapped:(id)sender;

@end
