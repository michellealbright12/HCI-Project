//
//  TabBarViewController.m
//  HCI Project
//
//  Created by Ian Dieli on 4/30/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "TabBarViewController.h"
#import "ProfileNavigationController.h"

@interface TabBarViewController () <UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[ProfileNavigationController class]] && [[NSUserDefaults standardUserDefaults] boolForKey:@"PREVENTUNWIND"]) {
        return NO;
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"PREVENTUNWIND"];
    }
    
    return YES;
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
