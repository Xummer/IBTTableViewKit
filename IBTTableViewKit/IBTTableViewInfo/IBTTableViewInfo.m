//
//  IBTTableViewInfo.m
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/5.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#define IBT_GROUPED_TABLEVIEW_TOP_MARGIN    (10.0f)

#import "IBTTableViewInfo.h"
/*
 @{ "showIndex" : NO }
*/

NSString * const TInfoShowRightIndexKey          = @"showIndex";

#import "IBTTableView.h"
#import "IBTTableViewCell.h"
#import "IBTTableViewInfoDelegate.h"
#import "UILabel+SizeCalculate.h"

static NSString *IBTTableViewCellIdentifier = @"IBTTableViewCell";

@interface IBTTableViewInfo ()
<
UITableViewDelegate,
UITableViewDataSource
>
{
    IBTTableView *_tableView;
    NSMutableArray *_arrSections;
}
@end

@implementation IBTTableViewInfo
#pragma mark - Life Cycle
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _tableView = [[IBTTableView alloc] initWithFrame:frame style:style];
    [_tableView registerClass:[IBTTableViewCell class]
       forCellReuseIdentifier:IBTTableViewCellIdentifier];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    return self;
}

- (void)dealloc {
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    _tableView = nil;
}

#pragma mark - Public Method
- (IBTTableView *)getTableView {
    return _tableView;
}

- (IBTTableViewSectionInfo *)getSectionAt:(NSUInteger)secIndex {
    if (secIndex < [_arrSections count]) {
        return _arrSections[ secIndex ];
    }
    return nil;
}

- (void)addSection:(IBTTableViewSectionInfo *)section {
    if (![section isKindOfClass:[IBTTableViewSectionInfo class]]) {
        return;
    }
    
    if (!_arrSections) {
        _arrSections = [NSMutableArray array];
    }
    [_arrSections addObject:section];
}

- (void)removeSectionAt:(NSUInteger)secIndex {
    if (secIndex < [_arrSections count]) {
        [_arrSections removeObjectAtIndex:secIndex];
        //        [_tableView reloadDataAnimated];
    }
}

- (NSUInteger)getSectionCount {
    return [_arrSections count];
}

- (void)clearAllSection {
    _arrSections = nil;
}

- (IBTTableViewCellInfo *)getCellAtSection:(NSUInteger)section row:(NSUInteger)row {
    IBTTableViewSectionInfo *secInfo = [self getSectionAt:section];
    return [secInfo getCellAt:row];
}

- (void)removeCellAt:(NSIndexPath *)indexPath {
    IBTTableViewSectionInfo *secInfo = [self getSectionAt:indexPath.section];
    [secInfo removeCellAt:indexPath.row];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    IBTTableViewSectionInfo *secInfo = [self getSectionAt:section];
    return [secInfo getCellCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:IBTTableViewCellIdentifier
                                    forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    IBTTableViewCellInfo *cellInfo =
    [self getCellAtSection:indexPath.section row:indexPath.row];
    
    cellInfo.cell = (IBTTableViewCell *)cell;
    
    if (cellInfo.makeTarget &&
        [cellInfo.makeTarget respondsToSelector:cellInfo.makeSel])
    {
        IMP imp = [cellInfo.makeTarget methodForSelector:cellInfo.makeSel];
        void (*func)(id, SEL, id) = (void *)imp;
        func(cellInfo.makeTarget, cellInfo.makeSel, cellInfo);
    }
}

// Section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self getSectionCount];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    IBTTableViewSectionInfo *secInfo = [self getSectionAt:section];
    switch (tableView.style) {
        case UITableViewStyleGrouped:
        {
            return nil;
        }
            break;
            
        default:
        {
            return [secInfo getUserInfoValueForKey:SInfoHeaderTitleKey];
        }
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    IBTTableViewSectionInfo *secInfo = [self getSectionAt:section];
    return [secInfo getUserInfoValueForKey:SInfoFooterTitleKey];
}

// Editing
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    IBTTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
    return [[cellInfo getUserInfoValueForKey:CInfoSwipeAbleKey] boolValue];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IBTTableViewCellInfo *cellInfo =
    [self getCellAtSection:indexPath.section row:indexPath.row];
    return cellInfo.fCellHeight;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IBTTableViewCellInfo *cellInfo =
    [self getCellAtSection:indexPath.section row:indexPath.row];
    if (![cellInfo getUserInfoValueForKey:CInfoEditorKey] &&
        cellInfo.actionTarget &&
        [cellInfo.actionTarget respondsToSelector:cellInfo.actionSel])
    {
        IMP imp = [cellInfo.actionTarget methodForSelector:cellInfo.actionSel];
        void (*func)(id, SEL, id) = (void *)imp;
        func(cellInfo.actionTarget, cellInfo.actionSel, cellInfo);
    }
}

// Section header & footer information. Views are preferred over title should you decide to provide both

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    IBTTableViewSectionInfo *secInfo = [self getSectionAt:section];
    CGFloat fH = secInfo.fHeaderHeight;
    switch (tableView.style) {
        case UITableViewStyleGrouped:
        {
            if (fH < 0) {
                NSString *nsHTitle = [secInfo getUserInfoValueForKey:SInfoHeaderTitleKey];
                fH = IBT_SECTION_HEADER_BOTTOM_MARGIN + IBT_SECTION_HEADER_TOP_MARGIN +
                [UILabel getHeightWithText:nsHTitle
                                      font:[UIFont systemFontOfSize:IBT_SECTION_HEADER_DEFAULT_FONT_SIZE]
                                  andWidth:CGRectGetWidth(tableView.frame) - 2 * IBT_CELL_MARGIN];
            }
        }
            break;
            
        default:
            break;
    }
    
    return fH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    IBTTableViewSectionInfo *secInfo = [self getSectionAt:section];
    CGFloat fH = secInfo.fFooterHeight;
    switch (tableView.style) {
        case UITableViewStyleGrouped:
        {
            if (fH < 0) {
                NSString *nsFTitle = [secInfo getUserInfoValueForKey:SInfoFooterTitleKey];
                fH = IBT_SECTION_FOOTER_BOTTOM_MARGIN + IBT_SECTION_FOOTER_TOP_MARGIN +
                [UILabel getHeightWithText:nsFTitle
                                      font:[UIFont systemFontOfSize:IBT_SECTION_FOOTER_DEFAULT_FONT_SIZE]
                                  andWidth:CGRectGetWidth(tableView.frame) - 2 * IBT_CELL_MARGIN];
            }
        }
            break;
            
        default:
            break;
    }
    
    return fH;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    IBTTableViewSectionInfo *secInfo = [self getSectionAt:section];
    UIView *view = nil;

    switch (tableView.style) {
        case UITableViewStyleGrouped:
        {
            if (!view) {
                NSString *nsHTitle = [secInfo getUserInfoValueForKey:SInfoHeaderTitleKey];
                
                if (nsHTitle.length > 0) {
                    CGRect frame = (CGRect){
                        .origin = CGPointZero,
                        .size.width = CGRectGetWidth(tableView.frame),
                        .size.height = IBT_GROUP_SECTION_HEADER_HEIGHT
                    };
                    view = [[UIView alloc] initWithFrame:frame];
                    view.backgroundColor = [UIColor clearColor];
                    
                    frame = (CGRect){
                        .origin.x = IBT_CELL_MARGIN,
                        .origin.y = IBT_SECTION_HEADER_TOP_MARGIN,
                        .size.width = CGRectGetWidth(view.frame) - 2 * IBT_CELL_MARGIN,
                        .size.height = CGRectGetHeight(view.frame) - IBT_SECTION_HEADER_BOTTOM_MARGIN
                    };
                    UILabel *tLabel = [[UILabel alloc] initWithFrame:frame];
                    tLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                    tLabel.numberOfLines = 0;
                    tLabel.textAlignment = NSTextAlignmentLeft;
                    tLabel.backgroundColor = [UIColor clearColor];
                    tLabel.font = [UIFont systemFontOfSize:IBT_SECTION_HEADER_DEFAULT_FONT_SIZE];
                    tLabel.textColor = IBT_SECTION_HEADER_DEFAULT_COLOR;
                    tLabel.text = nsHTitle;
                    [view addSubview:tLabel];
                    
                    CGSize labelSize = [tLabel sizeThatFits:tLabel.frame.size];
                    frame = view.frame;
                    frame.size.height = labelSize.height;
                    view.frame = frame;
                    
                }
            }
        }
            break;
            
        default:
        {
            view = [secInfo getUserInfoValueForKey:SInfoHeaderKey];
        }
            break;
    }
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    IBTTableViewSectionInfo *secInfo = [self getSectionAt:section];
    UIView *view = nil;
    
    switch (tableView.style) {
        case UITableViewStyleGrouped:
        {
            if (!view) {
                NSString *nsFTitle = [secInfo getUserInfoValueForKey:SInfoFooterTitleKey];
                
                if (nsFTitle.length > 0) {
                    
                    if (0 == section && !_tableView.tableHeaderView) {
                        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:(CGRect){
                            .origin = CGPointZero,
                            .size.width = 0,
                            .size.height = IBT_GROUPED_TABLEVIEW_TOP_MARGIN
                        }];
                    }
                    
                    CGRect frame = (CGRect){
                        .origin = CGPointZero,
                        .size.width = CGRectGetWidth(tableView.frame),
                        .size.height = 40
                    };
                    view = [[UIView alloc] initWithFrame:frame];
                    view.backgroundColor = [UIColor clearColor];
                    
                    frame = (CGRect){
                        .origin.x = IBT_CELL_MARGIN,
                        .origin.y = IBT_SECTION_FOOTER_TOP_MARGIN,
                        .size.width = CGRectGetWidth(view.frame) - 2 * IBT_CELL_MARGIN,
                        .size.height = CGRectGetHeight(view.frame) - IBT_SECTION_FOOTER_BOTTOM_MARGIN
                    };
                    UILabel *tLabel = [[UILabel alloc] initWithFrame:frame];
                    tLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                    tLabel.numberOfLines = 0;
                    tLabel.textAlignment = NSTextAlignmentCenter;
                    tLabel.backgroundColor = [UIColor clearColor];
                    tLabel.font = [UIFont systemFontOfSize:IBT_SECTION_FOOTER_DEFAULT_FONT_SIZE];
                    tLabel.textColor = IBT_SECTION_FOOTER_DEFAULT_COLOR;
                    tLabel.text = nsFTitle;
                    [view addSubview:tLabel];
                    
                    CGSize labelSize = [tLabel sizeThatFits:tLabel.frame.size];
                    frame = view.frame;
                    frame.size.height = labelSize.height;
                    view.frame = frame;
                    
                }
            }
        }
            break;
            
        default:
        {
            view = [secInfo getUserInfoValueForKey:SInfoFooterKey];
        }
            break;
    }
    
    return view;
}

// Edit
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(commitEditingForRowAtIndexPath:Cell:)]) {
        [_delegate commitEditingForRowAtIndexPath:indexPath
                                             Cell:[self getCellAtSection:indexPath.section row:indexPath.row]];
    }
}


//

- (void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(accessoryButtonTappedForRowWithIndexPath:Cell:)])
    {
        [_delegate accessoryButtonTappedForRowWithIndexPath:indexPath
                                                       Cell:[self getCellAtSection:indexPath.section row:indexPath.row]];
    }
    
}


@end
