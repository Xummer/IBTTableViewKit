//
//  UIImage+Tint.h
//  IBTTableViewKit
//
//  Created by Xummer on 1/9/15.
//  Copyright (c) 2015 Xummer. All rights reserved.
//

// http://onevcat.com/2013/04/using-blending-in-ios/

#import <UIKit/UIKit.h>

@interface UIImage (Tint)

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

@end
