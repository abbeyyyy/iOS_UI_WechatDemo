//
//  chatCellDataModel.m
//  wechatDemo
//
//  Created by Bytedance on 2020/7/16.
//  Copyright © 2020 Bytedance. All rights reserved.
//

#import "chatCellDataModel.h"

@implementation chatCellDataModel

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithDictionary: (NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.name = dict[@"name"];
        self.profilePicPath = [NSURL URLWithString: dict[@"picture"]];
        self.message = dict[@"message"];
        self.unreadNum = [dict[@"unreadCount"] intValue];
        self.ID = dict[@"_id"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.time = [dateFormatter dateFromString:dict[@"time"]];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.profilePicPath forKey:@"picture"];
    [coder encodeObject:self.message forKey:@"message"];
    [coder encodeInteger:self.unreadNum forKey:@"unreadCount"];
    [coder encodeObject:self.ID forKey:@"id"];
    [coder encodeObject:self.time forKey:@"date"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.profilePicPath = [coder decodeObjectForKey:@"picture"];
        self.message = [coder decodeObjectForKey:@"message"];
        self.unreadNum = [coder decodeIntegerForKey:@"unreadCount"];
        self.ID = [coder decodeObjectForKey:@"id"];
        self.time = [coder decodeObjectForKey:@"date"];
    }
    return self;
}


@end
