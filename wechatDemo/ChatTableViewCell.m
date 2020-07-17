//
//  ChatTableViewCell.m
//  wechatDemo
//
//  Created by Bytedance on 2020/7/16.
//  Copyright © 2020 Bytedance. All rights reserved.
//

#import "ChatTableViewCell.h"
#import "chatCellDataModel.h"
#import "Masonry.h"

@interface ChatTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailedLabel;
@property (nonatomic, strong) UIImageView *profilePicView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, assign) BOOL hasUnread;
@property (nonatomic, strong) UILabel *messageNumberLabel;

@end

@implementation ChatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailedLabel];
        [self.contentView addSubview:self.profilePicView];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.messageNumberLabel];
    }
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.profilePicView).offset(65);
        make.trailing.equalTo(self.contentView).offset(-20);
        make.top.equalTo(self.contentView).offset(9);
        make.height.mas_equalTo(24);
    }];
    
    [self.detailedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(17);
    }];
    
    [self.profilePicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(9);
        make.size.mas_equalTo(CGSizeMake(52, 52));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(9);
        make.trailing.equalTo(self.contentView).offset(-5);
    }];
    
    [self.messageNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.profilePicView).offset(7);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(18);
    }];
    

    return self;
}

- (void)bindModel:(chatCellDataModel *)model {
    // title
    self.titleLabel.text = model.name;
    // message
    if (model.unreadNum <= 1) {
        self.detailedLabel.text = [NSString stringWithFormat:@"%@", model.message];
    } else {
        self.detailedLabel.text = [NSString stringWithFormat:@"[%ld条] %@",model.unreadNum, model.message];
    }
    // time
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    comp.day = -7;
    NSDate *weekFromNow = [[NSCalendar currentCalendar] dateByAddingComponents:comp toDate:[NSDate date] options:0];
    
    if ([[NSCalendar currentCalendar] isDateInToday:model.time]) {
        [dateFormatter setDateFormat:@"HH:mm"];
        self.timeLabel.text = [dateFormatter stringFromDate:model.time];
    } else if ([[NSCalendar currentCalendar] isDateInYesterday:model.time]) {
        self.timeLabel.text = @"昨天";
    } else if ([model.time compare:weekFromNow] == NSOrderedDescending) {
        NSInteger week = [[NSCalendar currentCalendar] component:NSCalendarUnitWeekday fromDate:model.time];
        self.timeLabel.text = [self weekToString:week];
    } else {
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        self.timeLabel.text = [dateFormatter stringFromDate:model.time];
    }
    NSData *data = [[NSData alloc] initWithContentsOfURL: model.profilePicPath];
    UIImage *profilePic = [UIImage imageWithData:data];
    self.profilePicView.image = profilePic;
    self.messageNumberLabel.text = (model.unreadNum > 99)? @"99+" : [NSString stringWithFormat:@"%ld", model.unreadNum];
    self.hasUnread = model.unreadNum > 0;
    if (self.hasUnread) {
        self.messageNumberLabel.hidden = NO;
    } else {
        self.messageNumberLabel.hidden = YES;
    }
}

#pragma mark -- Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}

- (UILabel *)detailedLabel {
    if (!_detailedLabel) {
        _detailedLabel = [UILabel new];
        _detailedLabel.font = [UIFont systemFontOfSize:14];
        _detailedLabel.textColor = [UIColor grayColor];
    }
    return _detailedLabel;
}

- (UIImageView *)profilePicView {
    if (!_profilePicView) {
        _profilePicView = [UIImageView new];
        _profilePicView.layer.cornerRadius = 10;
        _profilePicView.clipsToBounds = YES;
    }
    return _profilePicView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor grayColor];
    }
    return _timeLabel;
}

- (UILabel *)messageNumberLabel {
    if (!_messageNumberLabel) {
        _messageNumberLabel = [UILabel new];
        _messageNumberLabel.font = [UIFont systemFontOfSize:14];
        _messageNumberLabel.textColor = [UIColor whiteColor];
        _messageNumberLabel.backgroundColor = [UIColor redColor];
        _messageNumberLabel.clipsToBounds = YES;
        _messageNumberLabel.layer.cornerRadius = 9;
        _messageNumberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageNumberLabel;
}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

#pragma mark -- helper

- (NSString *)weekToString:(NSInteger) week {
    switch (week) {
        case 1:
            return @"星期一";
            break;
        case 2:
            return @"星期二";
            break;
        case 3:
            return @"星期三";
            break;
        case 4:
            return @"星期四";
            break;
        case 5:
            return @"星期五";
            break;
        case 6:
            return @"星期六";
            break;
        case 7:
            return @"星期日";
            break;
        default:
            return @"";
            break;
    }
}

@end
