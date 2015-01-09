//
//  IBTTableViewSectionInfo.m
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/5.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import "IBTTableViewSectionInfo.h"

NSString * const SInfoHeaderKey             = @"header";
NSString * const SInfoFooterKey             = @"footer";
NSString * const SInfoHeaderTitleKey        = @"headerTitle";
NSString * const SInfoFooterTitleKey        = @"footerTitle";

#import "IBTTableViewCellInfo.h"

@interface IBTTableViewSectionInfo ()
{
    NSMutableArray *_arrCells;
}

@end

@implementation IBTTableViewSectionInfo
#pragma mark - Life Cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    _arrCells = nil;
}

#pragma mark - Class Method
+ (id)sectionInfoDefaut {
    return [[IBTTableViewSectionInfo alloc] init];
}

+ (id)sectionInfoHeader:(NSString *)header {
    IBTTableViewSectionInfo *sInfo =  [[self class] sectionInfoDefaut];
    [sInfo setHeaderTitle:header];
    return sInfo;
}

+ (id)sectionInfoFooter:(NSString *)footer {
    IBTTableViewSectionInfo *sInfo =  [[self class] sectionInfoDefaut];
    [sInfo setFooterTitle:footer];
    return sInfo;
}

+ (id)sectionInfoHeader:(NSString *)header Footer:(NSString *)footer {
    IBTTableViewSectionInfo *sInfo =  [[self class] sectionInfoDefaut];
    [sInfo setHeaderTitle:header];
    [sInfo setFooterTitle:footer];
    return sInfo;
}

+ (id)sectionInfoHeaderMakeSel:(SEL)sel makeTarget:(id)target {
    IBTTableViewSectionInfo *sInfo =  [[self class] sectionInfoDefaut];
    sInfo.makeHeaderTarget = target;
    sInfo.makeHeaderSel = sel;
    return sInfo;
}
+ (id)sectionInfoHeaderWithView:(UIView *)view {
    IBTTableViewSectionInfo *sInfo =  [[self class] sectionInfoDefaut];
    [sInfo setHeaderView:view];
    return sInfo;
}

+ (id)sectionInfoFooterWithView:(UIView *)view {
    IBTTableViewSectionInfo *sInfo =  [[self class] sectionInfoDefaut];
    [sInfo setFooterView:view];
    return sInfo;
}

#pragma mark - Public Method

- (NSUInteger)getCellCount {
    return [_arrCells count];
}

- (IBTTableViewCellInfo *)getCellAt:(NSUInteger)index {
    if (index < [self getCellCount]) {
        return _arrCells[ index ];
    }
    
    return nil;
}

- (void)addCell:(IBTTableViewCellInfo *)cell {
    if (![cell isKindOfClass:[IBTTableViewCellInfo class]]) {
        return;
    }
    
    if (!_arrCells) {
        _arrCells = [NSMutableArray array];
    }
    
    [_arrCells addObject:cell];
}

- (void)removeCellAt:(NSUInteger)index {
    if (index < [self getCellCount]) {
        [_arrCells removeObjectAtIndex:index];
    }
}

- (void)setHeaderTitle:(NSString *)title {
    if (title) {
        [self addUserInfoValue:title forKey:SInfoHeaderTitleKey];
        self.fHeaderHeight = -1;
    }
}

- (void)setFooterTitle:(NSString *)title {
    if (title) {
        [self addUserInfoValue:title forKey:SInfoFooterTitleKey];
        self.fFooterHeight = -1;
    }
}

- (UIView *)getHeaderView {
    return [self getUserInfoValueForKey:SInfoHeaderKey];
}

- (void)setHeaderView:(UIView *)view {
    if (view) {
        [self addUserInfoValue:view forKey:SInfoHeaderKey];
        self.fHeaderHeight = CGRectGetHeight(view.frame);
    }
}

- (void)setFooterView:(UIView *)view {
    if (view) {
        [self addUserInfoValue:view forKey:SInfoFooterKey];
        self.fFooterHeight = CGRectGetHeight(view.frame);
    }
}

@end
