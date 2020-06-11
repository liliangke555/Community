//
//  HomeHeaderTimeView.m
//  Community
//
//  Created by MAC on 2020/6/10.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "HomeHeaderTimeView.h"
#import "UIButton+CustomIcon.h"
#import "NSString+Lunar.h"

@interface HomeHeaderTimeView ()<UIScrollViewDelegate>
{
    BOOL _noChange;
}

@property (strong, nonatomic) UIButton * location;
@property (strong, nonatomic) UIButton * nameButton;
@property (strong, nonatomic) UIImageView * headerImage;
@property (strong, nonatomic) UIScrollView * scrollView;

@property (strong, nonatomic) UIPageControl * page;

@property (strong, nonatomic) TimeView * timeViewTop;
@property (strong, nonatomic) TimeView * timeViewMid;
@property (strong, nonatomic) TimeView * timeViewBottom;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) UIView * lineView;

@property (nonatomic, copy) void(^didClickLocation)(void);
@property (nonatomic, copy) void(^didClickAddress)(BOOL);

@end

@implementation HomeHeaderTimeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.backgroundColor = RGBACOLOR(80, 95, 110, 1);
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    self.headerImage = imageView;
    
    UIButton *location = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:location];
    self.location = location;
    [location.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [location setTitle:@"贵阳" forState:UIControlStateNormal];
    [location addTarget:self action:@selector(locationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *name = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:name];
    self.nameButton = name;
    [name.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [name setTitle:@"张力的家" forState:UIControlStateNormal];
    [name addTarget:self action:@selector(nameButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    self.lineView = lineView;
    
    if (@available(iOS 13.0, *)) {
        [imageView setImage:[UIImage systemImageNamed:@"tv.circle.fill"]];
        [location setTitleColor:[UIColor systemBackgroundColor] forState:UIControlStateNormal];
        [name setTitleColor:[UIColor systemBackgroundColor] forState:UIControlStateNormal];
        [lineView setBackgroundColor:[UIColor systemBackgroundColor]];
        [name setImage:[UIImage systemImageNamed:@"arrowtriangle.down.fill"] forState:UIControlStateNormal];
        [name setImage:[UIImage systemImageNamed:@"arrowtriangle.up.fill"] forState:UIControlStateSelected];
        [name setTintColor:[UIColor systemBackgroundColor]];
    } else {
        // Fallback on earlier versions
        [location setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [name setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lineView setBackgroundColor:[UIColor whiteColor]];
    }
    
}

#pragma mark - Helper Handle

- (void)nameButtonAction:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (self.didClickAddress) {
        self.didClickAddress(sender.isSelected);
    }
}

- (void)locationButtonAction:(UIButton *)sender
{
    if (self.didClickLocation) {
        self.didClickLocation();
    }
}

- (void)didClickLoaction:(void (^)(void))location clickAddiress:(void (^)(BOOL))address
{
    _didClickLocation = location;
    _didClickAddress = address;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_noChange) {
        _noChange = NO;
        return;
    }
    CGFloat offX = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    if (offX > 1) {
        self.timeViewTop.alpha = 1 - (0.5*(offX - 1));
        self.timeViewTop.frame = CGRectMake(CGRectGetMinX(self.scrollView.frame) - ((offX - 1) * (CGRectGetWidth(self.scrollView.frame) - 20)), CGRectGetMinY(self.scrollView.frame), CGRectGetWidth(self.scrollView.frame) - 20, CGRectGetHeight(self.scrollView.frame));
        self.timeViewMid.alpha = 0.2 * (offX - 1) + 0.8;
        self.timeViewBottom.alpha = 0.3 * (offX - 1) + 0.5;
    }
    if (offX < 1) {
        self.timeViewTop.alpha = 1 - (0.2 * (1 - offX));
        self.timeViewMid.alpha = 0.8 - (0.3 * (1 - offX));
        self.timeViewBottom.alpha = 0.5 + (0.5 * (1 - offX));
        self.timeViewBottom.frame = CGRectMake(CGRectGetMinX(self.scrollView.frame) + 20 + (1 - offX) * CGRectGetWidth(self.scrollView.frame),
                                               CGRectGetMinY(self.scrollView.frame) + 10,
                                               CGRectGetWidth(self.scrollView.frame) - 20,
                                               CGRectGetHeight(self.scrollView.frame) - 20);
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //ScrollView中根据滚动距离来判断当前页数
    int offX = (int)scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame);
    if (offX > 1) {
        [self leftRoll];
        self.currentPage += 1;
        if (self.currentPage == 3) {
            self.currentPage = 0;
        }
    }
    if (offX < 1) {
        [self rightRoll];
        self.currentPage -= 1;
        if (self.currentPage == -1) {
            self.currentPage = 2;
        }
    }
    if (offX == 2 || offX == 0) {
        // 设置scrollView的滚动位置 会触发scrollViewDidScroll: 代理
        // 为了当手动修改scrollView 的滚动位置时。不相应事件
        _noChange = YES;
        [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:NO];
    }
}
// 向左滑动屏幕 翻看下一页
- (void)leftRoll
{
    [self insertSubview:self.timeViewTop belowSubview:self.timeViewBottom];

    TimeView *temp = nil;
    temp = self.timeViewTop;
    self.timeViewTop = self.timeViewMid;
    self.timeViewMid = self.timeViewBottom;
    self.timeViewBottom = temp;
    temp = nil;
}
// 向右滑动屏幕 翻看上一页
- (void)rightRoll
{
    [self insertSubview:self.timeViewBottom aboveSubview:self.timeViewTop];

    TimeView *temp = nil;
    temp = self.timeViewBottom;
    self.timeViewBottom = self.timeViewMid;
    self.timeViewMid = self.timeViewTop;
    self.timeViewTop = temp;
    temp = nil;
}
- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    self.page.currentPage = currentPage;
}
#pragma mark - Getter

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        [self insertSubview:_scrollView atIndex:0];
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)page
{
    if (!_page) {
        _page = [[UIPageControl alloc] init];
        [self insertSubview:_page atIndex:1];
        [_page setNumberOfPages:3];
        [_page setCurrentPage:0];
        if (@available(iOS 13.0, *)) {
            _page.currentPageIndicatorTintColor = [UIColor systemBackgroundColor];
            _page.pageIndicatorTintColor = [UIColor systemGray2Color];
        } else {
            // Fallback on earlier versions
            _page.currentPageIndicatorTintColor = [UIColor whiteColor];
            _page.pageIndicatorTintColor = [UIColor grayColor];
        }
    }
    return _page;
}
- (TimeView *)timeViewTop
{
    if (!_timeViewTop) {
        _timeViewTop = [[TimeView alloc] init];
        [self insertSubview:_timeViewTop belowSubview:self.scrollView];
        _timeViewTop.date = [NSDate date];
    }
    return _timeViewTop;
}
- (TimeView *)timeViewMid
{
    if (!_timeViewMid) {
        _timeViewMid = [[TimeView alloc] init];
        _timeViewMid.alpha = 0.8f;
        [self insertSubview:_timeViewMid belowSubview:self.timeViewTop];
        NSDate * date = [NSDate date];//当前时间
        _timeViewMid.date = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
        
    }
    return _timeViewMid;
}
- (TimeView *)timeViewBottom
{
    if (!_timeViewBottom) {
        _timeViewBottom = [[TimeView alloc] init];
        _timeViewBottom.alpha = 0.5f;
        [self insertSubview:_timeViewBottom belowSubview:self.timeViewMid];
        NSDate * date = [NSDate date];//当前时间
        _timeViewBottom.date = [NSDate dateWithTimeInterval:-24*60*60*2 sinceDate:date];//前一天
    }
    return _timeViewBottom;
}
#pragma mark - Setter
- (void)setHeaderImageString:(NSString *)headerImageString
{
    _headerImageString = headerImageString;
    self.headerImage.image = [UIImage imageNamed:headerImageString];
}
- (void)setLocationString:(NSString *)locationString
{
    _locationString = locationString;
    [self.location setTitle:locationString forState:UIControlStateNormal];
}
- (void)setNameString:(NSString *)nameString
{
    _nameString = nameString;
    [self.nameButton setTitle:nameString forState:UIControlStateNormal];
}
- (void)setDate:(NSDate *)date
{
    _date = date;
    
}
#pragma mark - Layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = CGRectMake(16, CGRectGetMaxY(self.frame) - 108, CGRectGetWidth(self.frame) - 32, 100);
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.bounds) * 3, 100);
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.frame), 0) animated:NO];
    
    self.headerImage.frame = CGRectMake(CGRectGetMaxX(self.frame) - 61, CGRectGetMinY(self.frame) + 34, 45, 45);
    self.location.frame = CGRectMake(16, CGRectGetMidY(self.headerImage.frame) - 12, 50, 24);
    self.lineView.frame = CGRectMake(CGRectGetMaxX(self.location.frame), CGRectGetMinY(self.location.frame) + 6, 0.5, 12);
    self.nameButton.frame = CGRectMake(CGRectGetMaxX(self.location.frame) + 8, CGRectGetMinY(self.location.frame), 80, 24);
    [self.nameButton setIconInRightWithSpacing:8];
    
    self.page.frame = CGRectMake(CGRectGetMaxX(self.scrollView.frame) - 50 - 20, CGRectGetMaxY(self.scrollView.frame) - 15, 50, 15);
    
    [UIView animateWithDuration:0.25f animations:^{
        self.timeViewTop.frame = CGRectMake(CGRectGetMinX(self.scrollView.frame), CGRectGetMinY(self.scrollView.frame), CGRectGetWidth(self.scrollView.frame) - 20, CGRectGetHeight(self.scrollView.frame));
        
        self.timeViewMid.frame = CGRectMake(CGRectGetMinX(self.scrollView.frame) + 10, CGRectGetMinY(self.scrollView.frame) + 5, CGRectGetWidth(self.scrollView.frame) - 20, CGRectGetHeight(self.scrollView.frame) - 10);

        self.timeViewBottom.frame = CGRectMake(CGRectGetMinX(self.scrollView.frame) + 20, CGRectGetMinY(self.scrollView.frame) + 10, CGRectGetWidth(self.scrollView.frame) - 20, CGRectGetHeight(self.scrollView.frame) - 20);
    }];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

#pragma mark - SubView TimeView

@interface TimeView ()
@property (strong, nonatomic) UILabel * label;
@property (strong, nonatomic) UILabel * detail;

@property (strong, nonatomic) UIView * weekBackView;
@property (strong, nonatomic) UIView * weekView;
@property (strong, nonatomic) UILabel * dayLabel;
@property (strong, nonatomic) UILabel * weekLabel;
@end

@implementation TimeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 5.0f;
        [self setBackgroundColor:RGBACOLOR(119, 134, 151, 1)];
        if (@available(iOS 13.0, *)) {
//            self.backgroundColor  = [UIColor systemGrayColor];
        } else {
            // Fallback on earlier versions
        }
        [self setupView];
        
    }
    return self;
}

- (void)setupView
{
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont boldSystemFontOfSize:20]];
    [self addSubview:label];
    self.label = label;
    
    UILabel *detail = [[UILabel alloc] init];
    [self addSubview:detail];
    self.detail = detail;
    [detail setFont:[UIFont systemFontOfSize:14]];
    
    UIView *back = [[UIView alloc] init];
    [self addSubview:back];
    self.weekBackView = back;
    [back setBackgroundColor:MainGreenColor];
    
    UIView *week = [[UIView alloc] init];
    [back addSubview:week];
    self.weekView = week;
    [week setBackgroundColor:MainGreenColor];
    [week.layer setBorderWidth:1.0f];
    [week.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    UILabel *day = [[UILabel alloc] init];
    [week addSubview:day];
    self.dayLabel = day;
    [day setFont:[UIFont boldSystemFontOfSize:24]];
    [day setTextAlignment:NSTextAlignmentCenter];
    
    UILabel *weekLabel = [[UILabel alloc] init];
    [week addSubview:weekLabel];
    self.weekLabel = weekLabel;
    [weekLabel setFont:[UIFont systemFontOfSize:12]];
    [weekLabel setTextAlignment:NSTextAlignmentCenter];
    
    if (@available(iOS 13.0, *)) {
        [label setTextColor:[UIColor systemBackgroundColor]];
        [detail setTextColor:[UIColor systemBackgroundColor]];
        [day setTextColor:[UIColor systemBackgroundColor]];
        [weekLabel setTextColor:[UIColor systemBackgroundColor]];
    } else {
        // Fallback on earlier versions
        [label setTextColor:[UIColor whiteColor]];
        [detail setTextColor:[UIColor whiteColor]];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = CGRectMake(12, 16, CGRectGetWidth(self.frame) - 76, 24);
    
    self.detail.frame = CGRectMake(CGRectGetMinX(self.label.frame), CGRectGetMaxY(self.label.frame) + 16, CGRectGetWidth(self.label.frame), 12);
    
    self.weekBackView.frame = CGRectMake(CGRectGetWidth(self.frame) - 80, 16, 64, 64);
    self.weekView.frame = CGRectMake(4, 4, 56, 56);
    self.dayLabel.frame = CGRectMake(2, 8, CGRectGetWidth(self.weekView.frame) - 4, 30);
    self.weekLabel.frame = CGRectMake(2, CGRectGetMaxY(self.dayLabel.frame), CGRectGetWidth(self.weekView.frame) - 4, 12);
}
- (void)setString:(NSString *)string
{
    _string = string;
    [self.label setText:string];
}
- (void)setDate:(NSDate *)date
{
    _date = date;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger week = [dateComponent weekday];
    
    if (hour > 5 && hour < 12) {
        self.label.text = @"Hi  早上好！";
    } else if (hour >= 12 && hour < 14) {
        self.label.text = @"Hi  中午好！";
    } else if (hour >= 14 && hour < 18) {
        self.label.text = @"Hi  下午好！";
    } else {
        self.label.text = @"Hi  晚上好！";
    }
    
    NSString *string = [NSString LunarForSolarYear:year Month:month Day:day];
    
    self.detail.text = [NSString stringWithFormat:@"今天是%ld月%ld日，%@",month,day,string];
    self.dayLabel.text = [NSString stringWithFormat:@"%ld",day];
    self.weekLabel.text = [arrWeek objectAtIndex:week-1];
}
@end
