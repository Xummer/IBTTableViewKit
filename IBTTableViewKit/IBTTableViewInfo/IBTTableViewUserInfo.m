//
//  IBTTableViewUserInfo.m
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/5.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import "IBTTableViewUserInfo.h"

@interface IBTTableViewUserInfo () {
    NSMutableDictionary *_dicInfo;
}
@end

@implementation IBTTableViewUserInfo

- (id)getUserInfoValueForKey:(id <NSCopying>)key {
    NSParameterAssert(key);
    if (key && _dicInfo) {
        return _dicInfo[ key ];
    }
    
    return nil;
}

- (void)addUserInfoValue:(id)value forKey:(id <NSCopying>)key {
    NSParameterAssert(key);
    if (value && key) {
        if (!_dicInfo) {
            _dicInfo = [NSMutableDictionary dictionary];
        }
        
        [_dicInfo setObject:value forKey:key];
    }
    else if (key) {
        if (_dicInfo) {
            [_dicInfo removeObjectForKey:key];
        }
    }
}

@end
