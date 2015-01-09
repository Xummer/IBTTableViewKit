//
//  IBTBadgeView.h
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/8.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFUALT_BADGE_HEIGHT            (30.0f)

@class IBTUILabel;
@interface IBTBadgeView : UIImageView

@property (assign, nonatomic) CGFloat fAddedWidth;
@property (assign, nonatomic) CGPoint pOriginPoint;

- (instancetype)initWithFrame:(CGRect)frame range:(CGFloat)range;

- (IBTUILabel *)labelView;

- (void)setUpView;

- (void)setBadgeColor:(UIColor *)color;
- (void)SetImage:(UIImage *)image;
- (void)setString:(NSString *)string;
- (void)setValue:(NSUInteger)value;

@end
