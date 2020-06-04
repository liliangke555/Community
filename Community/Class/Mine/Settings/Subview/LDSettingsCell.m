//
//  LDSettingsCell.m
//  Community
//
//  Created by MAC on 2020/6/1.
//  Copyright © 2020 Yue Zhang. All rights reserved.
//

#import "LDSettingsCell.h"

@interface LDSettingsCell ()

@property (strong, nonatomic) UIView * lineView;

@end

@implementation LDSettingsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self.textLabel setFont:[UIFont systemFontOfSize:14]];
    [self.detailTextLabel setFont:[UIFont systemFontOfSize:12]];
}

- (void)setHideLine:(BOOL)hideLine
{
    _hideLine = hideLine;
    if (!hideLine) {
        if (!_lineView) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(16, 63, SCREEN_WIDTH, 0.5f)];
            [lineView setBackgroundColor:RGBACOLOR(235, 235, 235, 1)];
            [self addSubview:lineView];
            _lineView = lineView;
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
