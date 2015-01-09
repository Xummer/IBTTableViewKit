//
//  IBTTableViewSectionInfo.h
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/5.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import "IBTTableViewUserInfo.h"

@class IBTTableViewCellInfo;
@interface IBTTableViewSectionInfo : IBTTableViewUserInfo

@property (assign, nonatomic) BOOL bUseDynamicSize; 
@property (assign, nonatomic) CGFloat fFooterHeight;
@property (assign, nonatomic) CGFloat fHeaderHeight;
@property (weak,   nonatomic) id makeFooterTarget;
@property (assign, nonatomic) SEL makeFooterSel;
@property (weak,   nonatomic) id makeHeaderTarget;
@property (assign, nonatomic) SEL makeHeaderSel;

+ (IBTTableViewSectionInfo *)sectionInfoDefaut;
+ (IBTTableViewSectionInfo *)sectionInfoHeader:(NSString *)header;
+ (IBTTableViewSectionInfo *)sectionInfoFooter:(NSString *)footer;
+ (IBTTableViewSectionInfo *)sectionInfoHeader:(NSString *)header Footer:(NSString *)footer;
+ (IBTTableViewSectionInfo *)sectionInfoHeaderMakeSel:(SEL)sel makeTarget:(id)target;
+ (IBTTableViewSectionInfo *)sectionInfoHeaderWithView:(UIView *)view;
+ (IBTTableViewSectionInfo *)sectionInfoFooterWithView:(UIView *)view;


- (NSUInteger)getCellCount;
// return |IBTTableViewCellInfo|
- (IBTTableViewCellInfo *)getCellAt:(NSUInteger)index;
// cell |IBTTableViewCellInfo|
- (void)addCell:(IBTTableViewCellInfo *)cell;
- (void)removeCellAt:(NSUInteger)index;

- (void)setHeaderTitle:(NSString *)title;
- (void)setFooterTitle:(NSString *)title;
- (UIView *)getHeaderView;
- (void)setHeaderView:(UIView *)view;
- (void)setFooterView:(UIView *)view;


@end

#define IBT_GROUP_SECTION_HEADER_HEIGHT         (26.0f)
#define IBT_SECTION_HEADER_DEFAULT_COLOR        [UIColor colorWithRed:122/255.0f green:122/255.0f blue:123/255.0f alpha:1]
#define IBT_SECTION_HEADER_TOP_MARGIN           (0.0f)
#define IBT_SECTION_HEADER_DEFAULT_FONT_SIZE    (16.0f)
#define IBT_SECTION_HEADER_BOTTOM_MARGIN        (6.0f)

#define IBT_SECTION_FOOTER_DEFAULT_COLOR        IBT_SECTION_HEADER_DEFAULT_COLOR
#define IBT_SECTION_FOOTER_TOP_MARGIN           (6.0f)
#define IBT_SECTION_FOOTER_DEFAULT_FONT_SIZE    (14.0f)
#define IBT_SECTION_FOOTER_BOTTOM_MARGIN        (9.0f)

FOUNDATION_EXPORT NSString * const SInfoHeaderKey;
FOUNDATION_EXPORT NSString * const SInfoFooterKey;
FOUNDATION_EXPORT NSString * const SInfoHeaderTitleKey;
FOUNDATION_EXPORT NSString * const SInfoFooterTitleKey;
