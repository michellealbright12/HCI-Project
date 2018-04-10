//
//  UIViewController+RequestAppointment.h
//  HCI Project
//
//  Created by Michelle Albright on 3/28/18.
//  Copyright © 2018 Michelle Albright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface RequestAppointment : UIViewController<MFMailComposeViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *requestAppointment;
@property (strong, nonatomic) IBOutlet UILabel *pageLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UILabel *labelText;
@property (strong, nonatomic) IBOutlet UILabel *daysLabel;
//@property (strong, nonatomic) IBOutlet UITableView *daysTable;
//@property (strong, nonatomic) IBOutlet UILabel *timesLabel;
//@property (strong, nonatomic) IBOutlet UITableView *timesTable;
@property (strong, nonatomic) IBOutlet UITextField *messageText;
@property (strong, nonatomic) IBOutlet UILabel *notesLabel;
@property (strong, nonatomic) IBOutlet UITextField *noteText;

@end
