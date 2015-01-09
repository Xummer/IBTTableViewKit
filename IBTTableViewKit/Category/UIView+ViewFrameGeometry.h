//
//  UIView+ViewFrameGeometry.h
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/9.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewFrameGeometry)
@property (assign) CGFloat x;
@property (assign) CGFloat y;
@property (assign) CGFloat width;
@property (assign) CGFloat height;

@property (assign) CGSize size;
@property (assign) CGPoint origin;

@property (assign) CGFloat left;
@property (assign) CGFloat right;
@property (assign) CGFloat top;
@property (assign) CGFloat bottom;

@property (readonly, assign) CGPoint topRight;
@property (readonly, assign) CGPoint bottomRight;
@property (readonly, assign) CGPoint bottomLeft;

//- (void)frameIntegral;
//- (void)ceilAllSubviews;
//- (void)fitTheSubviews;
- (void)fitInSize:(CGSize)aSize;
- (void)scaleBy:(CGFloat)fScaleFactor;
- (void)moveBy:(CGPoint)pDelta;

@end
