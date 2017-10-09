//
//  TicketChooseVC.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/30.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "TicketChooseVC.h"
#import "JTCalendar.h"

@interface TicketChooseVC ()<JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet UIView *calendarView;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (strong, nonatomic) NSMutableDictionary *eventsByDate;
    
@property (strong, nonatomic) NSMutableArray *dateSelected;

@end

@implementation TicketChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //使用自定义导航栏
    QuNavigationBar *bar = [QuNavigationBar showQuNavigationBarWithController:self];
    self.quNavBar = bar;
    self.quNavBar.title = @"购票";
    
    [self.view setBackgroundColor:HEXCOLOR(@"f6f6f6")];
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    // Generate random events sort by date using a dateformatter for the demonstration
    [self createRandomEvents];
    
    _calendarMenuView.contentRatio = .75;
    [self.calendarView showShadowColor];
    [self.calendarView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self.calendarMenuView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self.calendarContentView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
   
    _calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
    _calendarManager.settings.zeroPaddedDayFormat = NO;
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    
    _dateSelected = [NSMutableArray new];
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    dayView.hidden = NO;
    
    // Other month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    // Selected date
    else if([self isInDatesSelected:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = HEXCOLOR(@"ff5c41");
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = HEXCOLOR(@"ff5c41");
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{

    
    if([self isInDatesSelected:dayView.date]){
        [_dateSelected removeObject:dayView.date];
        
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                            [_calendarManager reload];
                            dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
                        } completion:nil];
    }
    else{
        [_dateSelected addObject:dayView.date];
        
        dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        [UIView transitionWithView:dayView
                          duration:.3
                           options:0
                        animations:^{
                            [_calendarManager reload];
                            dayView.circleView.transform = CGAffineTransformIdentity;
                        } completion:nil];
    }

    // Don't change page in week mode because block the selection of days in first and last weeks of the month
    if(_calendarManager.settings.weekModeEnabled){
        return;
    }
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }

}

#pragma mark - Views customization

- (UIView *)calendarBuildMenuItemView:(JTCalendarManager *)calendar
{
    UILabel *label = [UILabel new];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = HEXCOLOR(@"404040");
    
    return label;
}

- (UIView *)calendarRightMenuItemView:(JTCalendarManager *)calendar
{
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setImage:[UIImage imageNamed:@"ticket_calendar_right"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(calendarRightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return rightBtn;
}

- (void)calendarRightAction:(UIButton *)sender
{
    [_calendarContentView loadNextPageWithAnimation];
}

- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy年MM月";
        
        dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
        dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
    }
    
    menuItemView.text = [dateFormatter stringFromDate:date];
}

- (UIView<JTCalendarWeekDay> *)calendarBuildWeekDayView:(JTCalendarManager *)calendar
{
    JTCalendarWeekDayView *view = [JTCalendarWeekDayView new];
    
    for(UILabel *label in view.dayViews){
        label.textColor = HEXCOLOR(@"777777");
        label.font = [UIFont systemFontOfSize:13];
    }
    
    return view;
}

- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar
{
    JTCalendarDayView *view = [JTCalendarDayView new];
    
    view.textLabel.font = [UIFont systemFontOfSize:15];
    
    view.circleRatio = 0.9;
    view.dotRatio = 1. / .9;
    
    return view;
}

#pragma mark - Fake data
- (BOOL)isInDatesSelected:(NSDate *)date
{
    for(NSDate *dateSelected in _dateSelected){
        if([_calendarManager.dateHelper date:dateSelected isTheSameDayThan:date]){
            return YES;
        }
    }
    
    return NO;
}

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}

- (void)createRandomEvents
{
    _eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:randomDate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
