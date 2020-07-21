//
//  wechatNetworkManager.m
//  wechatDemo
//
//  Created by Bytedance on 2020/7/20.
//  Copyright © 2020 Bytedance. All rights reserved.
//

#import "wechatNetworkManager.h"

@implementation wechatNetworkManager

+ (instancetype)sharedManager {
    static wechatNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [wechatNetworkManager new];
    });
    return manager;
}

- (void)dataTaskRequest: (void (^)(NSArray * obj))successBlock{
    NSURL *url = [NSURL URLWithString:@"http://wechatDemo.com/data"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error && data) {
            id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            dispatch_async(dispatch_get_main_queue(), ^{
                successBlock(obj);
            });
        }
    }];
    [task resume];
}

@end
