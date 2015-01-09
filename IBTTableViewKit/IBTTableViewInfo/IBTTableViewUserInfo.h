//
//  IBTTableViewUserInfo.h
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/5.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBTTableViewUserInfo : NSObject
@property (strong, nonatomic) id userInfo;
- (id)getUserInfoValueForKey:(id <NSCopying>)key;
- (void)addUserInfoValue:(id)value forKey:(id <NSCopying>)key;
@end
