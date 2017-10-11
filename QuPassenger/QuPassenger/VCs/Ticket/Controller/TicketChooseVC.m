//
//  TicketChooseVC.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/30.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "TicketChooseVC.h"
#import "TicketChooseCell.h"
#import "JTCalendar.h"
#import "PayTheTicketVC.h"
@interface TicketChooseVC ()<JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet UIView *calendarView;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *ticketBtn;
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (strong, nonatomic) UIButton *bgBlackBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UITableView *buyTableView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

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
    
    [self.calendarView showShadowColor];
    [self.calendarView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self.calendarMenuView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
    [self.calendarContentView setCornerRadius:4.0f AndBorder:0 borderColor:nil];
   
    _calendarManager.settings.weekDayFormat = JTCalendarWeekDayFormatSingle;
    _calendarManager.settings.zeroPaddedDayFormat = NO;
//    _calendarManager.settings.showLeftBtn = NO;
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    
    NSMutableAttributedString *carAttributeString = [[NSMutableAttributedString alloc] initWithString:@"30"];
    NSAttributedString *carTempAttributeString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"元"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [carAttributeString appendAttributedString:carTempAttributeString];
    
    NSAttributedString *tempAttributeString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" 共6张"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:HEXCOLOR(@"777777")}];
    [carAttributeString appendAttributedString:tempAttributeString];
    
    [self.priceLabel setAttributedText:carAttributeString];
    
    [self.ticketBtn showBadgeWithStyle:WBadgeStyleNumber value:6 animationType:WBadgeAnimTypeNone];
    [self.ticketBtn setBadgeBgColor:HEXCOLOR(@"ff5c41")];
    [self.ticketBtn setBadgeCenterOffset:CGPointMake(-8, 8)];
    
    [self.buyTableView registerNib:[UINib nibWithNibName:@"TicketChooseCell" bundle:nil] forCellReuseIdentifier:@"TicketChooseCell"];
    
    UIButton *blackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [blackBtn setFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    blackBtn.alpha = 0.0f;
    [blackBtn addTarget:self action:@selector(ticketBackAction:) forControlEvents:UIControlEventTouchUpInside];
    blackBtn.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:blackBtn belowSubview:self.buyTableView];
    [self.view insertSubview:self.quNavBar belowSubview:blackBtn];
    self.bgBlackBtn = blackBtn;
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
        dayView.bottomColor = HEXCOLOR(@"777777");
    }
    // Selected date
    else if([self isInDatesSelected:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = HEXCOLOR(@"ff5c41");
        dayView.bottomColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.bottomColor = HEXCOLOR(@"777777");
        dayView.textLabel.textColor = HEXCOLOR(@"404040");
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

- (void)calendarLeftClick
{
    
    [_calendarContentView loadPreviousPageWithAnimation];
}

- (void)calendarRightClick
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

- (void)createRandomEvents
{
    _dateSelected = [NSMutableArray new];
    
//    for(int i = 0; i < 30; ++i){
//        // Generate 30 random dates between now and 60 days later
//        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
//        
//        [_dateSelected addObject:randomDate];
//    }
}

#pragma mark BtnClickAction
- (IBAction)ticketClickAction:(id)sender
{
    [UIView animateWithDuration:0.2f
                          delay:0.f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         self.bgBlackBtn.alpha = 0.3f;
                         self.bottomConstraint.constant = 0;
                         [self.view layoutIfNeeded];
                     }
     
                     completion:^(BOOL finished) {
                         
                     }];
}

- (void)ticketBackAction:(UIButton *)sender
{
    [UIView animateWithDuration:0.2f
                          delay:0.f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         self.bgBlackBtn.alpha = 0.0f;
                         self.bottomConstraint.constant = -180;
                         [self.view layoutIfNeeded];
                     }
     
                     completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 60.0f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TicketChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TicketChooseCell"];
    
    cell.ticketSubBlock = ^{
        
    };
    
    cell.ticketSubBlock = ^{
        
    };
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//MARK:----------确认购票
- (IBAction)ibSureBtnClick:(id)sender {
    
    PayTheTicketVC *vc =[[PayTheTicketVC alloc]initWithNibName:@"PayTheTicketVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
