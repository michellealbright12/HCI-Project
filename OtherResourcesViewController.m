//
//  OtherResourcesViewController.m
//  HCI Project
//
//  Created by Michelle Albright on 4/3/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import "OtherResourcesViewController.h"

@interface OtherResourcesViewController ()

@end

@implementation OtherResourcesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _swagBtn.layer.cornerRadius = 10;
    _swagBtn.clipsToBounds = true;
    _religionBtn.layer.cornerRadius = 10;
    _religionBtn.clipsToBounds = true;
    _peerBtn.layer.cornerRadius = 10;
    _peerBtn.clipsToBounds = true;
    _outingBtn.layer.cornerRadius = 10;
    _outingBtn.clipsToBounds = true;
    _reslifeBtn.layer.cornerRadius = 10;
    _reslifeBtn.clipsToBounds = true;
    _multiBtn.layer.cornerRadius = 10;
    _multiBtn.clipsToBounds = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
    [super prepareForSegue:segue sender:sender];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
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
