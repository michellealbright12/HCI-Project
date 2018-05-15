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
NSMutableArray *buttons;
int calendarY;
int yValue;
int x, y;
int numEvents;
int calendarX;

@implementation ProfileViewController;
@synthesize monthlyView;
@synthesize sunLabel;
@synthesize titleLabel;
@synthesize prevBtn;


- (IBAction)buttontapped:(id)sender; {
    [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"LOGGEDIN"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    y = prevBtn.frame.origin.y;
    calendarY = y - 11;
    x = sunLabel.frame.origin.x;
    //x = 75;
    calendarX = x - 3;
    NSLog(@"x origin: %d",x);
    yValue = calendarY + prevBtn.frame.size.height;
    
    int screenHeight = (int) [[UIScreen mainScreen] nativeBounds].size.width;
    //fixes bug with calendar positioning on diff sized phones
    switch (screenHeight) {
        case 1242:
            calendarX = calendarX + 19;
            break;
        case 1125:
            yValue = yValue + 25;
            break;
        default:
            break;
    }

    //[self grabData];
    [self myCalendarView];
    dict = [NSMutableDictionary dictionary];
    int numEvents = 0;
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

- (IBAction)deleteSubviews:(id)sender {
    /*for (UIView *subview in [self.view subviews]) {
            [subview removeFromSuperview];
        }*/
    [self removeTags];
}

-(void) viewWillAppear:(BOOL)animated {
    [self removeTags];
    [self updateCalendarNow];
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"PREVENTUNWIND"];
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
    
    buttons = [NSMutableArray new];
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
   // int calendarOriginX = sunLabel.frame.origin.x - 3;
    //int calendarOriginY = prevBtn.frame.origin.y - 10;
     calendarY = y - 11;
    
    //int yVal= calendarOriginY + prevBtn.frame.size.height;
    //int yVal=385;
    int yCount=1;
    
    
    //Display name of month++++++++++++++++++++++++++++++++++++++++++++
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLog(@"%@",[[formatter monthSymbols] objectAtIndex:(this_Month - 1)]);
    monthlyView.text=[[formatter monthSymbols] objectAtIndex:(this_Month - 1)];
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    NSLog(@"dict: \n%@", dict);
    //use for loop to display each day
    for(int startD=1; startD<=num_Days;startD++){
        UIButton *addProject = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        
        int xCoord=(newWeekDay*40)+calendarX; //50;
        int yCoord=(yCount*30)+yValue;
        
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
        addProject.backgroundColor = [UIColor grayColor];
        
        for (id key in dict) {
            NSLog(@"key: %@", key);
            NSDate *eventDate = [dict objectForKey:key];
            NSLog(@"eventDate: %@", eventDate);
            NSDateComponents *dictComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:eventDate];
            NSInteger day = [dictComponents day];
            NSInteger month = [dictComponents month];
            NSInteger year = [dictComponents year];
            if (day == startD && month == this_Month && year == this_Year) {
                addProject.backgroundColor = [UIColor colorWithRed:0.04 green:0.85 blue:0.36 alpha:1.0];
            }
        }

       
        [self.view addSubview:addProject];
    }
    
    
    
}


/*
 Method that is called from the day button
 the ID of the button is recorded and its current value can
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
    NSLog(@"The date:%@", newDate);
    
    //gets the time format
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];

    NSString *selectedDate = [dateFormat stringFromDate:newDate];
    
    //go through dictinoary and and get the event name and time for the relevant date
    NSDate *addEventOnDate = [NSDate date];
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    [nowDateFormatter setDateFormat:@"e"];
   
    //key is the event name
    //objectForKey:key is the date
    BOOL isEvent = false;
    for (id key in dict) {
        addEventOnDate = [dict objectForKey:key];
        NSString *addEventDate = [dateFormat stringFromDate:addEventOnDate];
        if ([addEventDate isEqual:selectedDate]) {
            NSString *timeString = [NSString stringWithFormat:@"Time: %@", [timeFormatter stringFromDate:addEventOnDate]];
            
            dailyActivity = [NSString stringWithFormat:@"%@\n%@", key, timeString];;
            isEvent = true;
        }
    }
    if (!isEvent) {
        dailyActivity = @"No events";
    }
    parse_Spot3=@[@"p",[dateFormat stringFromDate:newDate]];
    //compare above date to parse database. See if current user has an entry
    
    
    //   ----- Launch a  POPUP SCREEN -----------
    MJDetailViewController *detailViewController = [[MJDetailViewController alloc] initWithNibName:@"MJDetailViewController" bundle:nil];
   
    [self presentPopupViewController:detailViewController animationType:MJPopupViewAnimationFade];
    
    
}


-(void)grabData{//get data from your database system

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
