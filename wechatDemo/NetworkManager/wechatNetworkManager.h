//
//  wechatNetworkManager.h
//  wechatDemo
//
//  Created by Bytedance on 2020/7/20.
//  Copyright © 2020 Bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface wechatNetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)dataTaskRequest:(void (^)(NSArray * obj))successBlock;

@end

NS_ASSUME_NONNULL_END
