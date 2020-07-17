//
//  ChatTableViewCell.h
//  wechatDemo
//
//  Created by Bytedance on 2020/7/16.
//  Copyright © 2020 Bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class chatCellDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface ChatTableViewCell : UITableViewCell

- (void)bindModel:(chatCellDataModel *)model;

@end

NS_ASSUME_NONNULL_END
