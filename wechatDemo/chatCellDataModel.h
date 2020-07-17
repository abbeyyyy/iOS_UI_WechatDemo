//
//  chatCellDataModel.h
//  wechatDemo
//
//  Created by Bytedance on 2020/7/16.
//  Copyright © 2020 Bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface chatCellDataModel : NSObject <NSSecureCoding>

@property (class, readonly) BOOL supportsSecureCoding;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSURL *profilePicPath;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, assign) NSInteger unreadNum;
@property (nonatomic, strong) NSString *ID;

- (instancetype)initWithDictionary: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
