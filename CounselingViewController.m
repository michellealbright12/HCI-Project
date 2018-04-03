//
//  CounselingViewController.m
//  HCI Project
//
//  Created by Michelle Albright on 4/2/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "CounselingViewController.h"

@interface CounselingViewController ()

@end

@implementation CounselingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _resourcesBtn.layer.cornerRadius = 10;
    _resourcesBtn.clipsToBounds = true;
    _emergencyContactBtn.layer.cornerRadius = 10;
    _emergencyContactBtn.clipsToBounds = true;
    _requestAppointment.layer.cornerRadius = 10;
    _requestAppointment.clipsToBounds = true;
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
