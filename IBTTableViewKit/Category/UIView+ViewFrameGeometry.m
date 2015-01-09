//
//  UIView+ViewFrameGeometry.m
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/9.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import "UIView+ViewFrameGeometry.h"

@implementation UIView (ViewFrameGeometry)

- (CGFloat) x {
    return self.frame.origin.x;
}

- (void) setX:(CGFloat)x {
    CGRect nframe = self.frame;
    
    nframe.origin.x = x;
    
    self.frame = nframe;
}

- (CGFloat) y {
    return self.frame.origin.y;
}

- (void) setY:(CGFloat)y {
    CGRect nframe = self.frame;
    
    nframe.origin.y = y;
    
    self.frame = nframe;
}

// Retrieve and set height, width
- (CGFloat) width {
    return self.frame.size.width;
}

- (void) setWidth:(CGFloat)width {
    CGRect nframe = self.frame;
    
    nframe.size.width = width;
    
    self.frame = nframe;
}

- (CGFloat) height {
    return self.frame.size.height;
}

- (void) setHeight:(CGFloat)height {
    CGRect nframe = self.frame;
    
    nframe.size.height = height;
    
    self.frame = nframe;
}

// Retrieve and set the origin, size
- (CGPoint) origin {
    return self.frame.origin;
}

- (void) setOrigin:(CGPoint)aPoint {
    CGRect nframe = self.frame;
    
    nframe.origin = aPoint;
    
    self.frame = nframe;
}

- (CGSize) size {
    return self.frame.size;
}

- (void) setSize:(CGSize)aSize {
    CGRect nframe = self.frame;
    
    nframe.size = aSize;
    
    self.frame = nframe;
}

// Retrieve and set top, bottom, left, right
- (CGFloat) left {
    return self.x;
}

- (void) setLeft:(CGFloat)left {
    self.x = left;
}

- (CGFloat) right {
    return CGRectGetMaxX(self.frame);
}

- (void) setRight:(CGFloat)right {
    self.x = right - self.width;
}

- (CGFloat) top {
    return self.y;
}

- (void) setTop:(CGFloat)top {
    self.y = top;
}

- (CGFloat) bottom {
    return CGRectGetMaxY(self.frame);
}

- (void) setBottom:(CGFloat)bottom {
    self.y = bottom - self.height;
}

// Query other frame locations
- (CGPoint) topRight {
    return CGPointMake(self.right, self.top);
}

- (CGPoint) bottomRight {
    return CGPointMake(self.right, self.bottom);
}

- (CGPoint) bottomLeft {
    return CGPointMake(self.left, self.bottom);
}

// Move via offset

- (void) moveBy:(CGPoint)delta
{
    CGPoint nCenter = self.center;
    
    nCenter.x += delta.x;
    
    nCenter.y += delta.y;
    
    self.center = nCenter;
}

// Scaling
- (void) scaleBy:(CGFloat)scaleFactor {
    CGRect nframe = self.frame;
    
    nframe.size.width *= scaleFactor;
    
    nframe.size.height *= scaleFactor;
    
    self.frame = nframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize:(CGSize)aSize {
    CGFloat scale;
    
    CGRect nframe = self.frame;
    
    if (nframe.size.height && (nframe.size.height > aSize.height)) {
        
        scale = aSize.height / nframe.size.height;
        
        nframe.size.width *= scale;
        
        nframe.size.height *= scale;
    }
    
    if (nframe.size.width && (nframe.size.width >= aSize.width)) {
        
        scale = aSize.width / nframe.size.width;
        
        nframe.size.width *= scale;
        
        nframe.size.height *= scale;
    }
    
    self.frame = nframe;
}

@end
