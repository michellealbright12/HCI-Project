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


NSUInteger num_Days;//1-31
int this_Year;//2015
int weekdayNumber;//1-7
int this_Month;//1-12

NSArray * created_At;
NSArray * parse_Spot3;
NSArray * had_Session;
NSInteger dateNums;
NSString * dailyActivities;
NSString * popup_Label;
NSString * monthName;
NSMutableDictionary * dict;

@implementation ProfileViewController;
@synthesize monthlyView;
@synthesize sunLabel;
@synthesize titleLabel;
@synthesize prevBtn;
//@synthesize date;

- (IBAction)buttontapped:(id)sender; {
    [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"LOGGEDIN"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self grabData];
    [self myCalendarView];
    dict = [NSMutableDictionary dictionary];
    NSLog(@"%@", dict);
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

- (IBAction)nextAction:(id)sender {
    this_Month++;
    [self removeTags];
    [self updateCalendarNow];
}

- (IBAction)prevAction:(id)sender {
    this_Month--;
    [self removeTags];
    [self updateCalendarNow];
}

-(void) removeTags{
    int x=1;
    while (x<=31){
        [[self.view viewWithTag:x] removeFromSuperview];
        x++;
    }
    
}

/*
 this method returns the number of days in the month in the date it is sent
 */

-(NSUInteger)getCurrDateInfo:(NSDate *)myDate{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:myDate];
    NSUInteger numberOfDaysInMonth = rng.length;
    
    return numberOfDaysInMonth;
}


/*
 This is the method called to create the calendar
 */

-(void)myCalendarView{
    
    ///num_Days=[self getCurrDateInfo:[NSDate date]];
    
    this_Year = [[[NSCalendar currentCalendar]
                 components:NSCalendarUnitYear fromDate:[NSDate date]]
                year];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps2 = [cal components:NSCalendarUnitMonth fromDate:[NSDate date]];
    this_Month=[comps2 month];
    
    
    [self moreDateInfo];
    
}



-(void)updateCalendarNow{// try to condense this so only one method is used instead of two
    if(this_Month>12){
        this_Month=1;
        this_Year++;
    }
    
    if(this_Month<1){
        this_Month=12;
        this_Year--;
    }
    
    [self moreDateInfo];
    
}

-(void)moreDateInfo{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //get first day of month's weekday
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    [components setMonth:this_Month];
    [components setYear:this_Year];
    NSDate * newDate = [calendar dateFromComponents:components];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:newDate];
    weekdayNumber=[comps weekday];
    
    
    //Get number of days in the month
    num_Days=[self getCurrDateInfo:newDate];
    
    
    int newWeekDay=weekdayNumber-1;//make weekday zero based
    
    NSLog(@"Day week %d",newWeekDay);
    
    //coordinates for displaying the buttons
    int calendarOriginX = sunLabel.frame.origin.x + 15;
    int calendarOriginY = prevBtn.frame.origin.y - 10;
    
    int yVal= calendarOriginY + prevBtn.frame.size.height;
    //int yVal=385;
    int yCount=1;
    
    
    //Display name of month++++++++++++++++++++++++++++++++++++++++++++
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLog(@"%@",[[formatter monthSymbols] objectAtIndex:(this_Month - 1)]);
    monthlyView.text=[[formatter monthSymbols] objectAtIndex:(this_Month - 1)];
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    
    //use for loop to display each day
    for(int startD=1; startD<=num_Days;startD++){
        UIButton *addProject = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        
        int xCoord=(newWeekDay*40)+calendarOriginX; //50;
        int yCoord=(yCount*30)+yVal;
        
        newWeekDay++;
        if(newWeekDay>6){//drops buttons on y axis every 7 days
            newWeekDay=0;
            yCount++;
        }
        //Creates the buttons and gives them each a tag (id)
        int popInt = startD;
        addProject.frame = CGRectMake(xCoord, yCoord, 35, 25);
        [addProject setTitle:[NSString stringWithFormat:@"%d", popInt] forState:UIControlStateNormal];
        [addProject addTarget:self action:@selector(popupInformation:) forControlEvents:UIControlEventTouchUpInside];
        [addProject setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addProject.tag = popInt;
        
        
        //if you are using a database this section checks to see if
        //a certain criteria is met. If so, you can give the button a different background color.
        BOOL match=NO;
        
        for(int parseNum=0; parseNum<created_At.count; parseNum++){
            //Break Down date from Parse
            NSDate * parseDate = created_At[parseNum];
            NSDateComponents * parseComp = [gregorian components:NSCalendarUnitMonth fromDate:parseDate];
            int parseMonth=(int)[parseComp month];
            int parseYear=(int)[[[NSCalendar currentCalendar]components:NSCalendarUnitYear fromDate:parseDate] year];
            
            int parseDay= (int)[[[NSCalendar currentCalendar]components:NSCalendarUnitDay fromDate:parseDate] day];
            
            
            if((parseYear==this_Year) && (parseMonth==this_Month) && (parseDay==startD)){
                match=YES;
                if([had_Session[parseNum] isEqual:@"YES"])
                    addProject.backgroundColor = [UIColor redColor];
                else
                    addProject.backgroundColor = [UIColor greenColor];
                
                NSLog(@"Match %d", startD);
            }
        }
        if(match==NO)
            addProject.backgroundColor = [UIColor grayColor];
        
        
        [self.view addSubview:addProject];
    }
    
    
    
}


/*
 Method that is called from the day button
 the ID of the button is recorded and it's current value can
 be used with thisMonth and thisYear to get the date cooresponding to the button clicked
 This date is saved to the parseSpot3 variable which can be accessed from the popup View
 This way we can use the date to grab further information if we need to
 */


-(void) popupInformation: (id) sender {
    popupDefinition = 2;
    popup_Label = @"Your schedule for today:";
    
    UIButton* btn = (UIButton *) sender;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[btn.currentTitle integerValue]];
    [components setMonth:this_Month];
    [components setYear:this_Year];
    NSDate * newDate = [calendar dateFromComponents:components];
    //Formats date to MMM d, yyyy
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE, MMM d, yyyy"];
    NSLog(@"%@", newDate);
    
    //Calculate the day number from the subset of NSCalendarUnitWeekday so that we know what events
    //should be displayed for the specific day of the week that the user clicked, in the range 1-7.
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    dateNums = dateComponents.weekday;
    NSString *selectedDate = [dateFormat stringFromDate:newDate];
    //go through dictinoary and and get the event name and time for the relevant date
    NSDate *addEventOnDate = [NSDate date];
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    [nowDateFormatter setDateFormat:@"e"];
    //NSInteger weekdayNumber = (NSInteger)[[nowDateFormatter stringFromDate:newDate] integerValue];
    NSLog(@"%@ day num: %ld", newDate, dateNums);
    //key is the event name
    //objectForKey:key is the date
    for (id key in dict) {
        NSLog(@"key=%@ value=%@", key, [dict objectForKey:key]);
        
        addEventOnDate = [dict objectForKey:key];
        NSString *addEventDate = [dateFormat stringFromDate:addEventOnDate];
        if ([addEventDate isEqual:selectedDate]) {
            dailyActivity = key;
        }
        NSInteger addWeekdayNumber = (NSInteger)[[nowDateFormatter stringFromDate:addEventOnDate] integerValue];
        
        
    }
    parse_Spot3=@[@"p",[dateFormat stringFromDate:newDate]];
    //compare above date to parse database. See if current user has an entry
    
    
    //   ----- Launch a  POPUP SCREEN -----------
    
    
    MJDetailViewController *detailViewController = [[MJDetailViewController alloc] initWithNibName:@"MJDetailViewController" bundle:nil];
    
    [self presentPopupViewController:detailViewController animationType:MJPopupViewAnimationFade];
    
    
    
//    NSString * str1 = @"";
//    NSString * str2 = @"";
//    NSString * str3 = @"";
//    NSString * str4 = @"";
//    NSString * str5 = @"";
//    NSString * str6 = @"";
//    NSString * str7 = @"";
//    NSString * str8 = @"";
//    NSString * str9 = @"";
//    NSString * str10 = @"";
//
//    if (dateNums == 1) {
//        dailyActivity = @"There are no events scheduled for this Sunday.";
//    } else if (dateNums == 2) {
//        str1 = @"Bowdoin Team Lift - Football";
//        str2 = @"6:30a-8:00a in Lower Level Weightroom";
//
//        str3 = @"Buti Yoga - Tanya Grigsby";
//        str4 = @"6:30p-7:30p in Buck Room 213";
//        dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
//    } else if (dateNums == 3) {
//        str1 = @"Tai Chi - Ken Ryan";
//        str2 = @"12:00p-1:00p in Buck Room 301";
//
//        str3 = @"Meditation - Bernie Hershberger";
//        str4 = @"4:30p-5:15p in Buck Room 302";
//
//        dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
//    } else if (dateNums == 4) {
//        str1 = @"Cardio Kickboxing - Justine Chabot";
//        str2 = @"6:45a-7:30a in Buck Room 213";
//
//        str3 = @"Yin Yoga - Lucretia Woodruf";
//        str4 = @"6:00p-7:00p in Buck Room 301";
//
//        dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
//    } else if (dateNums == 5) {
//        str1 = @"Speed Training - Neil Willey";
//        str2 = @"6:00a-7:00a in Morrell Gym";
//
//        str3 = @"ZUMBA® Fitness - Bea Blakemore";
//        str4 = @"5:15p-6:00p in Buck Room 213";
//
//        dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
//    } else if (dateNums == 6) {
//        str1 = @"Mat Pilates - Cindy Carraway-Wilson";
//        str2 = @"12:00p-12:45p in Buck Room 301";
//
//        str3 = @"Bowdoin Team Lift - Men's Soccer";
//        str4 = @"3:00p-4:30p in Lower Level Weightroom";
//
//        dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
//    } else if (dateNums == 7) {
//        dailyActivity = @"There are no events scheduled for this Saturday.";
//    }

    
    
    
}


-(void)grabData{//get data from your database system
    
    
    /*
     PFUser *currentUser = [PFUser currentUser];
     if (currentUser) {
     // do stuff with the user
     NSLog(@"I AM LOGGED IN NOW!");
     //see if you have a score saved yet
     NSString * un;
     un=[NSString stringWithFormat:@"%@",[[PFUser currentUser]valueForKey:@"username"]];
     //search for user
     PFQuery *query = [PFQuery queryWithClassName:@"checkins"];
     [query whereKey:@"username" equalTo:un];
     //query desc by created at
     [query findObjectsInBackgroundWithBlock:^(NSArray *  checkins, NSError *error) {
     
     
     if (!error) {//You do have data in the databse - let's see if it's current
     
     
     created_At = [checkins valueForKey:@"created_At"];
     
     [self myCalView];//call to show the calendar
     
     }else{//You don't have any data saved in the database yet-----------------------
     NSLog(@"NO Good");//no data
     [self myCalView];//still show calendar
     }
     }];
     
     
     } else {
     // show the signup or login screen
     NSLog(@"I AM not LOGGED IN!!!");//*********************************************
     
     
     
     }
     
     */
}

/*
 NSDate *now = [NSDate date];
 NSCalendar *calendar = [[NSCalendar alloc]
 initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
 NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
 NSDateComponents *components = [calendar components:units fromDate:now];
 
 NSLog(@"Day: %ld", [components day]);
 NSLog(@"Month: %ld", [components month]);
 NSLog(@"Year: %ld", [components year]);
 
 
 
 */

/*
 NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:[NSDate date]];
 weekday = [comps weekday];
 */



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
