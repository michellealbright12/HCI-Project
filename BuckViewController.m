//
//  CalendarView.m
//  Lean Minded
//
//  Created by Matt Memmo on 12/30/14.
//  Copyright (c) 2014 RWS. All rights reserved.
//  Edited by Michelle Albright on 3/28/18.
//  Edited by Chad Carrera on 4/2/18

#import "BuckViewController.h"

#import "UIViewController+MJPopupViewController.h"
#import "MJDetailViewController.h"


@interface ViewController ()


@end

NSUInteger numDays;//1-31
int thisYear;//2015
int weekday;//1-7
int thisMonth;//1-12

NSArray * createdAt;
NSArray * parseSpot3;
NSArray * hadSession;
NSInteger dateNum;
NSString * dailyActivity;
NSString * popupLabel;
NSInteger popupDefinition;
NSMutableDictionary * eventDict;
int yVal;
int calendarOriginY;
int calendarOriginX;

//NSDate * parseSpot;

@implementation ViewController
@synthesize monthly;
@synthesize calendarSun;
@synthesize viewLabel;
@synthesize prevLabel;


- (void)viewDidLoad {
    
    calendarOriginY = monthly.frame.origin.y;
    calendarOriginX = calendarSun.frame.origin.x + 14;
    yVal= calendarOriginY - 5;
    [super viewDidLoad];
    eventDict = [NSMutableDictionary dictionary];
    NSLog(@"%@", eventDict);
    
    [self grabData];
    [self myCalView];//don't need if you're using parse. You will call from grabData method
}

//Next and previous buttons
//they each call the removeTags method which removes the buttons from the view
//the buttons are added again in the updateCallNow method

- (IBAction)nextAct:(id)sender {
    thisMonth++;
    [self removeTags];
    [self updateCalNow];
}

- (IBAction)prevAct:(id)sender {
    thisMonth--;
    [self removeTags];
    [self updateCalNow];
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

-(void)myCalView{
    
    ///numDays=[self getCurrDateInfo:[NSDate date]];
    
    thisYear = [[[NSCalendar currentCalendar]
                 components:NSCalendarUnitYear fromDate:[NSDate date]]
                year];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps2 = [cal components:NSCalendarUnitMonth fromDate:[NSDate date]];
    thisMonth=[comps2 month];
    
    
    [self moreDateInfo];
    
}



-(void)updateCalNow{// try to condense this so only one method is used instead of two
    if(thisMonth>12){
        thisMonth=1;
        thisYear++;
    }
    
    if(thisMonth<1){
        thisMonth=12;
        thisYear--;
    }
    
    [self moreDateInfo];
    
}

-(void)moreDateInfo{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //get first day of month's weekday
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    [components setMonth:thisMonth];
    [components setYear:thisYear];
    NSDate * newDate = [calendar dateFromComponents:components];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:newDate];
    weekday=[comps weekday];
    
    
    //Get number of days in the month
    numDays=[self getCurrDateInfo:newDate];
    
    
    int newWeekDay=weekday-1;//make weekday zero based
    
    //coordinates for displaying the buttons
    //int calendarOriginX = calendarSun.frame.origin.x -5;
    int yCount=1;
    
    
    //Display name of month++++++++++++++++++++++++++++++++++++++++++++
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLog(@"%@",[[formatter monthSymbols] objectAtIndex:(thisMonth - 1)]);
    monthly.text=[[formatter monthSymbols] objectAtIndex:(thisMonth - 1)];
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    
    //use for loop to display each day
    for(int startD=1; startD<=numDays;startD++){
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
        [addProject addTarget:self action:@selector(popupInfo:) forControlEvents:UIControlEventTouchUpInside];
        [addProject setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addProject.tag = popInt;
        
        NSNumber *date = [NSNumber numberWithInteger:newWeekDay + 1];
        NSString *activity = [eventDict objectForKey:date];
        
        if (activity == nil || activity.length == 0 || [activity isEqualToString:@"There are no events scheduled for this day."]) {
            addProject.backgroundColor = [UIColor grayColor];
        } else {
            addProject.backgroundColor = [UIColor colorWithRed:0.04 green:0.85 blue:0.36 alpha:1.0];;
        }
        
        //get items in eventDict that make newWeekDay+1
        //if there are items for that num, make the backgroundcolor green
        
        //if you are using a database this section checks to see if
        //a certain criteria is met. If so, you can give the button a different background color.
        
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


-(void) popupInfo: (id) sender {
    popupDefinition = 1;
    popupLabel = @"Events at Buck today:";
    
    UIButton* btn = (UIButton *) sender;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[btn.currentTitle integerValue]];
    [components setMonth:thisMonth];
    [components setYear:thisYear];
    NSDate * newDate = [calendar dateFromComponents:components];
    //Formats date to MMM d, yyyy
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE, MMM d, yyyy"];
    
    //Calculate the day number from the subset of NSCalendarUnitWeekday so that we know what events
    //should be displayed for the specific day of the week that the user clicked, in the range 1-7.
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    dateNum = dateComponents.weekday;
    
    NSNumber *currDateNumber = [NSNumber numberWithInteger:dateNum];
    //go through dictinoary and and get the event name and time for the relevant date
   // NSDate *addEventOnDate = [NSDate date];
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    [nowDateFormatter setDateFormat:@"e"];
    
    //gets the time format
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    
    
    //start add stuff to automate event popup
   // NSString *selectedDate = [dateFormat stringFromDate:newDate];
    //key is the event name
    //objectForKey:key is the date
    BOOL isEvent = false;
    for (id key in eventDict) {
        NSNumber *addEventOnDate = [eventDict objectForKey:key];
        //NSString *addEventDate = [nowDateFormatter stringFromDate:addEventOnDate];
        //NSString *nextEvent = [[NSString alloc] init];
        if ([addEventOnDate isEqual:currDateNumber]) {
            //NSString *timeString = [NSString stringWithFormat:@"Time: %@", [timeFormatter stringFromDate:addEventOnDate]];
            //nextEvent = [NSString stringWithFormat:@"%@\n%@\n", key, timeString];
            dailyActivity = key; //[dailyActivity stringByAppendingString:nextEvent];
            isEvent = true;
        }
    }
    if (!isEvent) {
        dailyActivity = @"No events";
    }
    NSLog(@"Event: %@", dailyActivity);
    
    //end stuff to automate event popup
    
    NSString * str1 = @"";
    NSString * str2 = @"";
    NSString * str3 = @"";
    NSString * str4 = @"";
    
    if (dateNum == 1) {
        dailyActivity = @"There are no events scheduled for this day.";
    } else if (dateNum == 2) {
        str1 = @"Bowdoin Team Lift - Football";
        str2 = @"6:30a-8:00a in Lower Level Weightroom";
        
        str3 = @"Buti Yoga - Tanya Grigsby";
        str4 = @"6:30p-7:30p in Buck Room 213";
        dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
    } else if (dateNum == 3) {
        str1 = @"Tai Chi - Ken Ryan";
        str2 = @"12:00p-1:00p in Buck Room 301";
        
        str3 = @"Meditation - Bernie Hershberger";
        str4 = @"4:30p-5:15p in Buck Room 302";
        
        dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
    } else if (dateNum == 4) {
        str1 = @"Cardio Kickboxing - Justine Chabot";
        str2 = @"6:45a-7:30a in Buck Room 213";
        
        str3 = @"Yin Yoga - Lucretia Woodruf";
        str4 = @"6:00p-7:00p in Buck Room 301";
        
        dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
    } else if (dateNum == 5) {
        str1 = @"Speed Training - Neil Willey";
        str2 = @"6:00a-7:00a in Morrell Gym";
        
        str3 = @"ZUMBA® Fitness - Bea Blakemore";
        str4 = @"5:15p-6:00p in Buck Room 213";
        
        dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
    } else if (dateNum == 6) {
        str1 = @"Mat Pilates - Cindy Carraway-Wilson";
        str2 = @"12:00p-12:45p in Buck Room 301";
        
        str3 = @"Bowdoin Team Lift - Men's Soccer";
        str4 = @"3:00p-4:30p in Lower Level Weightroom";
        
        dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
    } else if (dateNum == 7) {
        dailyActivity = @"There are no events scheduled for this day.";
    }
    
    
    parseSpot3=@[@"p",[dateFormat stringFromDate:newDate]];
    //compare above date to parse database. See if current user has an entry
   
    //   ----- Launch a  POPUP SCREEN -----------
  
    MJDetailViewController *detailViewController = [[MJDetailViewController alloc] initWithNibName:@"MJDetailViewController" bundle:nil];
    
    [self presentPopupViewController:detailViewController animationType:MJPopupViewAnimationFade];

}

-(void)grabData{
    NSString * str1 = @"";
    NSString * str2 = @"";
    NSString * str3 = @"";
    NSString * str4 = @"";
    
    for (int i = 1; i < 8; i++) {
        if (i == 1) {
            dailyActivity = @"There are no events scheduled for this day.";
        } else if (i == 2) {
            str1 = @"Bowdoin Team Lift - Football";
            str2 = @"6:30a-8:00a in Lower Level Weightroom";
            
            str3 = @"Buti Yoga - Tanya Grigsby";
            str4 = @"6:30p-7:30p in Buck Room 213";
            dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
        } else if (i == 3) {
            str1 = @"Tai Chi - Ken Ryan";
            str2 = @"12:00p-1:00p in Buck Room 301";
            
            str3 = @"Meditation - Bernie Hershberger";
            str4 = @"4:30p-5:15p in Buck Room 302";
            
            dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
        } else if (i == 4) {
            str1 = @"Cardio Kickboxing - Justine Chabot";
            str2 = @"6:45a-7:30a in Buck Room 213";
            
            str3 = @"Yin Yoga - Lucretia Woodruf";
            str4 = @"6:00p-7:00p in Buck Room 301";
            
            dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
        } else if (i == 5) {
            str1 = @"Speed Training - Neil Willey";
            str2 = @"6:00a-7:00a in Morrell Gym";
            
            str3 = @"ZUMBA® Fitness - Bea Blakemore";
            str4 = @"5:15p-6:00p in Buck Room 213";
            
            dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
        } else if (i == 6) {
            str1 = @"Mat Pilates - Cindy Carraway-Wilson";
            str2 = @"12:00p-12:45p in Buck Room 301";
            
            str3 = @"Bowdoin Team Lift - Men's Soccer";
            str4 = @"3:00p-4:30p in Lower Level Weightroom";
            
            dailyActivity = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@", str1, str2, str3, str4];
        } else if (i == 7) {
            dailyActivity = @"There are no events scheduled for this day.";
        }
        NSNumber *date = [NSNumber numberWithInteger:i + 1];
        [eventDict setObject:dailyActivity forKey:date];//get data from your database system
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender; {
    [super prepareForSegue:segue sender:sender];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}



@end

