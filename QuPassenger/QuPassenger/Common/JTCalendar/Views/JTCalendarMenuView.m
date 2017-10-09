//
//  JTCalendarMenuView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarMenuView.h"

#import "JTCalendarManager.h"

typedef NS_ENUM(NSInteger, JTCalendarPageMode) {
    JTCalendarPageModeFull,
    JTCalendarPageModeCenter,
    JTCalendarPageModeCenterLeft,
    JTCalendarPageModeCenterRight
};

@interface JTCalendarMenuView (){
    CGSize _lastSize;
    
    UIButton *_leftBtn;
    UIView *_centerView;
    UIButton *_rightBtn;
    
    JTCalendarPageMode _pageMode;
}

@end

@implementation JTCalendarMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{
    
    if (!_leftBtn) {
        
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_leftBtn setImage:[UIImage imageNamed:@"ticket_calendar_left"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(calendarLeftAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBtn];
        
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        
        
    }
 
    if (!_rightBtn) {
        
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_rightBtn setImage:[UIImage imageNamed:@"ticket_calendar_right"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(calendarRightAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_rightBtn];
        
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        
        
    }
    
}

- (void)calendarLeftAction:(UIButton *)sender
{
    [_manager.delegateManager calendarLeftClick];
}

- (void)calendarRightAction:(UIButton *)sender
{
    [_manager.delegateManager calendarRightClick];
}

- (void)setPreviousDate:(NSDate *)previousDate
            currentDate:(NSDate *)currentDate
               nextDate:(NSDate *)nextDate
{
    NSAssert(currentDate != nil, @"currentDate cannot be nil");
    NSAssert(_manager != nil, @"manager cannot be nil");
    
    if(!_centerView){
     
        _centerView = [_manager.delegateManager buildMenuItemView];
        [self addSubview:_centerView];

        [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftBtn.mas_right);
            make.right.equalTo(_rightBtn.mas_left);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(40);
        }];
        
        
    }
    
    if (_manager.settings.showLeftBtn) {
        [_leftBtn setHidden:NO];
    }
    else{
        [_leftBtn setHidden:YES];
    }
    
    if (_manager.settings.showRightBtn) {
        [_rightBtn setHidden:NO];
    }
    else{
        [_rightBtn setHidden:YES];
    }
    
    [_manager.delegateManager prepareMenuItemView:_centerView date:currentDate];

   
}

- (void)updatePageMode:(NSUInteger)pageMode
{
    if(_pageMode == pageMode){
        return;
    }
    
    _pageMode = pageMode;
//    [self repositionViews];
}

@end
