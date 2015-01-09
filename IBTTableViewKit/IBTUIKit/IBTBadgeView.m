//
//  IBTBadgeView.m
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/8.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import "IBTBadgeView.h"
#import "IBTUILabel.h"
#import "UIImage+Tint.h"

@interface IBTBadgeView ()
{
    CGFloat fOriginWidth;
    CGFloat m_fRange;
}
@property (weak, nonatomic) IBTUILabel *m_labelView;
@end

@implementation IBTBadgeView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.fAddedWidth = 0;
    // tabbar_badge 30 x 30
    self.image = [UIImage imageNamed:@"tabbar_badge"];
    self.pOriginPoint = CGPointMake(DEFUALT_BADGE_HEIGHT / 3.0f, DEFUALT_BADGE_HEIGHT / 4.0f);
    [self setUpView];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame range:(CGFloat)range {
    self = [self initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    m_fRange = range;
    
    return self;
}

#pragma mark - Private Method

#pragma mark - Public Method
- (IBTUILabel *)labelView {
    return _m_labelView;
}

- (void)setUpView {
    
    if (_m_labelView && _m_labelView.superview) {
        [_m_labelView removeFromSuperview];
    }
    
    IBTUILabel *label = [[IBTUILabel alloc] initWithFrame:CGRectInset(self.bounds, _pOriginPoint.x + _fAddedWidth, _pOriginPoint.y)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize: floorf(CGRectGetHeight(label.frame)) - 1];
    [self addSubview:label];
    
    self.m_labelView = label;
}

- (void)setBadgeColor:(UIColor *)color {
    if ([color isKindOfClass:[UIColor class]]) {
        self.image = [self.image imageWithGradientTintColor:color];
    }
}

- (void)setImage:(UIImage *)image {
    
    if (image) {
        CGFloat fV = ceilf(image.size.height * .5f) - 1;
        CGFloat fH = ceilf(image.size.width * .5f) - 1;
        
        // - (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(fV, fH, fV, fH)];
    }
    
    [super setImage:image];
}

- (void)SetImage:(UIImage *)image {
    [self setImage:image];
}

- (void)setString:(NSString *)string {
    _m_labelView.text = string;
    
    CGFloat fMaxW = (m_fRange > 0) ? m_fRange : CGFLOAT_MAX;
    
    CGSize size = [_m_labelView sizeThatFits:CGSizeMake(fMaxW, CGRectGetHeight(_m_labelView.frame))];
    fOriginWidth= size.width;
    
    CGRect rect = self.frame;
    rect.size.width = (_pOriginPoint.x + _fAddedWidth) * 2 + fOriginWidth;
    if (_bRightAlignment) {
        rect.origin.x = CGRectGetMaxX(self.frame) - CGRectGetWidth(rect);
    }
    self.frame = rect;
}

- (void)setValue:(NSUInteger)value {
    [self setString:[NSString stringWithFormat:@"%@", @(value)]];
}

@end
