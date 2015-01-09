//
//  UILabel+SizeCalculate.h
//  
//
//  Created by Xummer on 14-2-19.
//  Copyright (c) 2014年 Xummer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SizeCalculate)
+ (CGFloat)getLabelWidth:(UILabel *)label;
+ (CGFloat)getLabelHeight:(UILabel *)label;
+ (CGSize)getLabelSize:(UILabel *)label;

+ (CGSize)getSizeWithText:(NSString *)text font:(UIFont *)font andSize:(CGSize)size;
+ (CGSize)getSizeWithText:(NSString *)text font:(UIFont *)font andWidth:(CGFloat)width;
+ (CGFloat)getHeightWithText:(NSString *)text font:(UIFont *)font andWidth:(CGFloat)width;
+ (CGFloat)getWidthWithText:(NSString *)text font:(UIFont *)font andHeight:(CGFloat)height;

- (CGFloat)calculateWidth;
- (CGFloat)calculateHeight;
- (CGSize)calculateSize;
@end
