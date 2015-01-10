//
//  IBTTableViewCellInfo.m
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/5.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#define IBT_CELL_HEIGHT_DEFAULT                         (44.0f)
#define IBT_CELL_INNER_GAP                              (10.0f)

#define IBT_CELL_TITLE_LABEL_TAG                        (9999)
#define IBT_CELL_TITLE_FONT_SIZE_DEFAULT                (17.0f)
#define IBT_CELL_TITLE_DETAIL_FONT_SIZE_DEFAULT         (16.0f)
#define IBT_CELL_TITLE_COLOR_DEFAULT                    [UIColor blackColor]

#define IBT_CELL_DETAIL_FONT_SIZE_DEFAULT               (13.0f)
#define IBT_CELL_DETAIL_COLOR_DEFAULT                   [UIColor lightGrayColor]

#define IBT_CELL_LEFT_LABEL_MIN_WIDTH                   (1.0f)
#define IBT_CELL_LEFT_FONT_SIZE_DEFAULT                 (15.0f)
#define IBT_CELL_LEFT_COLOR_DEFAULT                     [UIColor lightGrayColor]

#define IBT_CELL_RIGHT_LABEL_MIN_WIDTH                  (20.0f)
#define IBT_CELL_RIGHT_FONT_SIZE_DEFAULT                (15.0f)
#define IBT_CELL_RIGHT_COLOR_DEFAULT                    [UIColor lightGrayColor]

#define IBT_CELL_URL_DEFAULT_COLOR                      [UIColor colorWithRed:0.341176 green:0.41960 blue:0.584314 alpha:1]

#define IBT_CELL_TEXTFIELD_MIN_WIDTH                    (40.0f)
#define IBT_CELL_TEXTFIELD_DEFAULT_HEIGHT               (30.0f)

#import "IBTTableViewCellInfo.h"
#import "IBTTableViewCell.h"
#import "IBTUILabel.h"
#import "IBTBadgeView.h"

@implementation IBTTableViewCellInfo

#pragma mark - Class Method
+ (IBTTableViewCellInfo *)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue
{
    return [[self class] normalCellForSel:nil target:nil title:title rightValue:rightValue imageName:nil accessoryType:UITableViewCellAccessoryNone];
}

+ (IBTTableViewCellInfo *)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue
                                   imageName:(NSString *)imgName
{
    return [[self class] normalCellForSel:nil target:nil title:title rightValue:rightValue imageName:imgName accessoryType:UITableViewCellAccessoryNone];
}

+ (IBTTableViewCellInfo *)normalCellForSel:(SEL)sel target:(id)target
                                     title:(NSString *)title
                                rightValue:(NSString *)rightValue
                             accessoryType:(UITableViewCellAccessoryType)type
{
    return [[self class] normalCellForSel:sel target:target title:title rightValue:rightValue imageName:nil accessoryType:type];
}

+ (IBTTableViewCellInfo *)normalCellForSel:(SEL)sel target:(id)target
                                     title:(NSString *)title
                             accessoryType:(UITableViewCellAccessoryType)type;
{
    return [[self class] normalCellForSel:sel target:target title:title rightValue:nil accessoryType:type];
}

+ (IBTTableViewCellInfo *)normalCellForSel:(SEL)sel target:(id)target
                                     title:(NSString *)title
                                rightValue:(NSString *)rightValue
                                 imageName:(NSString *)imgName
                             accessoryType:(UITableViewCellAccessoryType)type
{
    IBTTableViewCellInfo *cellInfo = [[IBTTableViewCellInfo alloc] init];
    cellInfo.makeTarget = cellInfo;
    cellInfo.makeSel = @selector(makeNormalCell:);
    cellInfo.actionTarget = target;
    cellInfo.actionSel = sel;
    cellInfo.accessoryType = type;
    cellInfo.cellStyle = UITableViewCellStyleSubtitle;
    cellInfo.selectionStyle = UITableViewCellSelectionStyleBlue;
    cellInfo.fCellHeight = IBT_CELL_HEIGHT_DEFAULT;
    
    if (title) {
        [cellInfo addUserInfoValue:title forKey:CInfoTitleKey];
    }
    
    if (rightValue.length > 0) {
        [cellInfo addUserInfoValue:rightValue forKey:CInfoRightValueKey];
    }
    
    if (imgName.length > 0) {
        [cellInfo addUserInfoValue:imgName forKey:CInfoImageNameKey];
    }
    
    return cellInfo;
}

+ (IBTTableViewCellInfo *)badgeRightCellForSel:(SEL)sel target:(id)target
                                         title:(NSString *)title badge:(id)badge rightValue:(NSString *)rightValue
                                     imageName:(NSString *)name
{
    IBTTableViewCellInfo *cellInfo =
    [[self class] badgeCellForSel:sel target:target title:title badge:badge rightValue:rightValue imageName:name];
    
    [cellInfo addUserInfoValue:@( YES ) forKey:CInfoBadgeAlignmentRightKey];
    
    return cellInfo;
}

+ (IBTTableViewCellInfo *)badgeCellForSel:(SEL)sel target:(id)target
                                    title:(NSString *)title badge:(id)badge rightValue:(NSString *)rightValue
                                imageName:(NSString *)imageName
{
    IBTTableViewCellInfo *cellInfo =
    [[self class] normalCellForSel:sel target:target title:title rightValue:rightValue imageName:imageName accessoryType:UITableViewCellAccessoryNone];
    
    if (badge) {
        if ([badge isKindOfClass:[NSString class]]) {
            [cellInfo addUserInfoValue:badge forKey:CInfoBadgeKey];
        }
        else if ([badge isKindOfClass:[NSNumber class]]) {
            [cellInfo addUserInfoValue:[NSString stringWithFormat:@"%@", badge] forKey:CInfoBadgeKey];
        }
    }
    
    return cellInfo;
}

+ (IBTTableViewCellInfo *)badgeCellForSel:(SEL)sel target:(id)target
                                    title:(NSString *)title badge:(id)badge rightValue:(NSString *)rightValue
{
    return [[self class] badgeCellForSel:sel target:target title:title badge:badge rightValue:rightValue imageName:nil];
}

+ (IBTTableViewCellInfo *)badgeCellForSel:(SEL)sel target:(id)target
                                    title:(NSString *)title badge:(id)badge
{
    return [[self class] badgeCellForSel:sel target:target title:title badge:badge rightValue:nil imageName:nil];
}

+ (IBTTableViewCellInfo *)switchCellForSel:(SEL)sel target:(id)target
                                     title:(NSString *)title on:(BOOL)bOn
{
    IBTTableViewCellInfo *cellInfo =
    [[self class] normalCellForSel:sel target:nil title:title rightValue:nil imageName:nil accessoryType:UITableViewCellAccessoryNone];
    
    /*
      @{"switch":#"<UISwitch: 0x17ea71d0; frame = (254 6; 51 31); layer = <CALayer: 0x17ea7260>>","title":"Sticky on Top","on":false}
     */
    cellInfo.makeSel = @selector(makeSwitchCell:);
    cellInfo.actionTargetForSwitchCell = target;
    cellInfo.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UISwitch *mSwitch = [[UISwitch alloc] init];
    mSwitch.on = bOn;
    [mSwitch addTarget:cellInfo
                action:@selector(actionSwitchCell:)
      forControlEvents:UIControlEventValueChanged];
    [cellInfo addUserInfoValue:mSwitch forKey:CInfoSwitchKey];
    [cellInfo addUserInfoValue:@( mSwitch.on ) forKey:CInfoSwitchOnKey];
    
    return cellInfo;
}

+ (IBTTableViewCellInfo *)centerCellForSel:(SEL)sel target:(id)target
                                     title:(NSString *)title
{
    IBTTableViewCellInfo *cellInfo =
    [[self class] normalCellForSel:sel target:target title:title accessoryType:UITableViewCellAccessoryNone];
    cellInfo.makeSel = @selector(makeCenterCell:);
    
    return cellInfo;
}

// Open url Inner WebView
+ (IBTTableViewCellInfo *)urlInnerBlueCellForTitle:(NSString *)title leftValue:(NSString *)leftValue url:(id)url
{
    IBTTableViewCellInfo *cellInfo =
    [[self class] normalCellForSel:nil target:nil title:title accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    cellInfo.actionTarget = cellInfo;
    cellInfo.actionSel = @selector(actionUrlInnerCell);
    
    if (url) {
        [cellInfo addUserInfoValue:url forKey:CInfoURLKey];
    }
    
    if (leftValue) {
        [cellInfo addUserInfoValue:leftValue forKey:CInfoLeftValueKey];
        [cellInfo addUserInfoValue:IBT_CELL_URL_DEFAULT_COLOR forKey:CInfoLeftValueColorKey];
    }
    
    return cellInfo;
}

// Open url Safari (Call open url)
+ (IBTTableViewCellInfo *)urlCellForTitle:(NSString *)title url:(id)url {
    IBTTableViewCellInfo *cellInfo =
    [[self class] normalCellForSel:nil target:nil title:title accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    cellInfo.actionTarget = cellInfo;
    cellInfo.actionSel = @selector(actionUrlCell);
    
    if (url) {
        [cellInfo addUserInfoValue:url forKey:CInfoURLKey];
    }
    
    return cellInfo;
}

+(IBTTableViewCellInfo *)editorCellForSel:(SEL)sel target:(id)target
                                      tip:(NSString *)tip focus:(BOOL)focus text:(NSString *)text
{
    return [[self class] editorCellForSel:sel target:target title:nil margin:0 tip:tip autoCorrect:YES focus:focus text:text];
}

+(IBTTableViewCellInfo *)editorCellForSel:(SEL)sel target:(id)target
                                      tip:(NSString *)tip focus:(BOOL)focus autoCorrect:(BOOL)correct
                                     text:(NSString *)text
{
    return [[self class] editorCellForSel:sel target:target title:nil margin:0 tip:tip autoCorrect:correct focus:focus text:text];
}

+(IBTTableViewCellInfo *)editorCellForSel:(SEL)sel target:(id)target
                                    title:(NSString *)title margin:(CGFloat)margin
                                      tip:(NSString *)tip focus:(BOOL)focus
                                     text:(NSString *)text
{
    return [[self class] editorCellForSel:sel target:target title:title margin:margin tip:tip autoCorrect:YES focus:focus text:text];
}

+ (IBTTableViewCellInfo *)editorCellForSel:(SEL)sel target:(id)target
                                     title:(NSString *)title
                                    margin:(CGFloat)margin tip:(NSString *)tip
                               autoCorrect:(BOOL)autoCorrect focus:(BOOL)focus
                                      text:(NSString *)text
{
    IBTTableViewCellInfo *cellInfo =
    [[self class] normalCellForSel:sel target:target title:title accessoryType:UITableViewCellAccessoryNone];
    
    /*
     @{"title":"WeChat ID","fEditorLMargin":0,"focus":true,"keyboardType":1,"editor":#"<UITextField: 0x180a6a50; frame = (108 7; 202 30); text = ''; clipsToBounds = YES; opaque = NO; autoresize = W; gestureRecognizers = <NSArray: 0x178e13a0>; layer = <CALayer: 0x178dc930>>","tip":" "}
     */
    
    cellInfo.makeSel = @selector(makeEditorCell:);
    cellInfo.selectionStyle = UITableViewCellSelectionStyleNone;
    cellInfo.autoCorrectionType = autoCorrect ? UITextAutocorrectionTypeYes : UITextAutocorrectionTypeNo;
    
    UITextField *textField = [[UITextField alloc] init];
    [cellInfo addUserInfoValue:textField forKey:CInfoEditorKey];
    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:cellInfo
                   selector:@selector(actionEditorCell:)
                       name:UITextFieldTextDidChangeNotification
                     object:textField];
    
    [cellInfo addUserInfoValue:@( margin ) forKey:CInfoEditorLMarginKey];
    
    if (tip) {
        [cellInfo addUserInfoValue:tip forKey:CInfoEditorTipKey];
    }
    
    if (text) {
        [cellInfo addUserInfoValue:text forKey:CInfoEditorTextKey];
    }
    
    if (focus) {
        [cellInfo addUserInfoValue:@( focus ) forKey:CInfoEditorFocusKey];
    }
    
    return cellInfo;
}

#pragma mark - Life Cycle
- (void)dealloc {
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter removeObserver:self
                          name:UITextFieldTextDidChangeNotification
                        object:nil];
}

#pragma mark - Getter
- (CGFloat)fCellHeight {
    if (self.calHeightTarget &&
        [self.calHeightTarget respondsToSelector:self.calHeightSel]) {
        IMP imp = [self.calHeightTarget methodForSelector:self.calHeightSel];
        CGFloat (*func)(id, SEL, id) = (void *)imp;
        _fCellHeight = func(self.calHeightTarget, self.calHeightSel, self);
    }
    return _fCellHeight;
}

#pragma mark - Make Cell

- (void)makeNormalCell:(IBTTableViewCell *)cell {
    
    for (UIView *v in [cell.contentView subviews]) {
        if (v.tag == IBT_CELL_TITLE_LABEL_TAG) {
            continue;
        }
        
        [v removeFromSuperview];
    }
    
    self.cell = cell;
//    cell.editingStyle = self.editStyle;
    cell.selectionStyle = self.selectionStyle;
    cell.accessoryType = self.accessoryType;
    
    CGFloat fGap = IBT_CELL_MARGIN;
    CGFloat fLeftX = fGap;
    CGFloat fMaxWidth = CGRectGetWidth(cell.contentView.bounds) - ((cell.accessoryType !=UITableViewCellAccessoryNone || cell.accessoryView) ? 0 : fGap);
    CGFloat fRightX = fMaxWidth;
    
    // Left Image
    UIImageView *leftImageV = nil;
    NSString *imageName = [self getUserInfoValueForKey:CInfoImageNameKey];
    if (imageName.length > 0) {
        UIImage *leftImg = [UIImage imageNamed:imageName];
        if (leftImg) {
            leftImageV = [[UIImageView alloc] initWithImage:leftImg];
            leftImageV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
            CGFloat imageH = leftImg.size.height;
            CGFloat imageW = leftImg.size.width;
            
            if (leftImg.size.height > CGRectGetHeight(cell.contentView.bounds)) {
                imageH = CGRectGetHeight(cell.contentView.bounds);
                imageW = leftImg.size.width / leftImg.size.height * imageH;
            }
            
            leftImageV.frame = (CGRect){
                .origin.x = fLeftX,
                .origin.y = (CGRectGetHeight(cell.contentView.bounds) - imageH) * .5f,
                .size.width = imageW,
                .size.height = imageH
            };
            
            [cell.contentView addSubview:leftImageV];
            
            fLeftX = CGRectGetMaxX(leftImageV.frame) + fGap;
        }
    }
    
    // Title Label
    UILabel *titleLabel;
    NSString *nsTitle = [self getUserInfoValueForKey:CInfoTitleKey];
    NSString *nsDetail = [self getUserInfoValueForKey:CInfoDetailKey];
    
    CGFloat fW = fMaxWidth - fLeftX;
    CGFloat fH = CGRectGetHeight(cell.contentView.bounds);
    
    UIView *lastTitleLabel = [cell.contentView viewWithTag:IBT_CELL_TITLE_LABEL_TAG];
    if ([lastTitleLabel isKindOfClass:[IBTUILabel class]]) {
        titleLabel = (IBTUILabel *)lastTitleLabel;
    }
    else {
        titleLabel = [[IBTUILabel alloc] init];
        [cell.contentView addSubview:titleLabel];
    }
    
    titleLabel.textAlignment = NSTextAlignmentLeft;
    id titleColor = [self getUserInfoValueForKey:CInfoTitleColorKey];
    if ([titleColor isKindOfClass:[UIColor class]]) {
        titleLabel.textColor = titleColor;
    }
    else {
        titleLabel.textColor = IBT_CELL_TITLE_COLOR_DEFAULT;
    }
    
    cell.textLabel.text = nil;
    titleLabel.text = nsTitle;
    
    if (nsDetail) {
        id titleFont = [self getUserInfoValueForKey:CInfoTitleFontKey];
        if ([titleFont isKindOfClass:[UIFont class]]) {
            titleLabel.font = titleFont;
        }
        else {
            id titleFontSize = [self getUserInfoValueForKey:CInfoTitleFontSizeKey];
            CGFloat fTitleFontSize =
            ([titleFontSize isKindOfClass:[NSNumber class]]) ?
            [titleFontSize floatValue] :
            IBT_CELL_TITLE_DETAIL_FONT_SIZE_DEFAULT;
            titleLabel.font = [UIFont systemFontOfSize:fTitleFontSize];
        }
        
        // Detail Label
        IBTUILabel *detailLabel = [[IBTUILabel alloc] init];
        detailLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        detailLabel.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:detailLabel];
        
        id detailFont = [self getUserInfoValueForKey:CInfoDetailFontKey];
        if ([detailFont isKindOfClass:[UIFont class]]) {
            detailLabel.font = detailFont;
        }
        else {
            id detailFontSize = [self getUserInfoValueForKey:CInfoDetailFontSizeKey];
            CGFloat fDetailFontSize =
            ([detailFontSize isKindOfClass:[NSNumber class]]) ?
            [detailFontSize floatValue] :
            IBT_CELL_DETAIL_FONT_SIZE_DEFAULT;
            detailLabel.font = [UIFont systemFontOfSize:fDetailFontSize];
        }
        
        id detailValueColor = [self getUserInfoValueForKey:CInfoDetailColorKey];
        if ([detailValueColor isKindOfClass:[UIColor class]]) {
            detailLabel.textColor = detailValueColor;
        }
        else {
            detailLabel.textColor = IBT_CELL_DETAIL_COLOR_DEFAULT;
        }
        
        detailLabel.text = nsDetail;
        
        fW = fMaxWidth - fLeftX;
        CGSize titleLabelSize = [titleLabel sizeThatFits:CGSizeMake(fW, fH *.5f)];
        CGSize detailLabelSize = [detailLabel sizeThatFits:CGSizeMake(fW, fH * .5f)];
        
        CGFloat fTopY = (fH - titleLabelSize.height - detailLabelSize.height) * .5f;
        
        titleLabel.frame = (CGRect){
            .origin.x = fLeftX,
            .origin.y = fTopY,
            .size = titleLabelSize
        };
        
        fTopY = CGRectGetMaxY(titleLabel.frame);
        detailLabel.frame = (CGRect){
            .origin.x = fLeftX,
            .origin.y = fTopY,
            .size = detailLabelSize
        };
        
        fLeftX = MAX(CGRectGetMaxX(titleLabel.frame), CGRectGetMaxX(detailLabel.frame))  + IBT_CELL_INNER_GAP;
    }
    else {
        
        id titleFont = [self getUserInfoValueForKey:CInfoTitleFontKey];
        if ([titleFont isKindOfClass:[UIFont class]]) {
            titleLabel.font = titleFont;
        }
        else {
            id titleFontSize = [self getUserInfoValueForKey:CInfoTitleFontSizeKey];
            CGFloat fTitleFontSize =
            ([titleFontSize isKindOfClass:[NSNumber class]]) ?
            [titleFontSize floatValue] :
            IBT_CELL_TITLE_FONT_SIZE_DEFAULT;
            titleLabel.font = [UIFont systemFontOfSize:fTitleFontSize];
        }
        
        CGSize titleLabelSize = [titleLabel sizeThatFits:CGSizeMake(fW, fH)];
        titleLabel.frame = (CGRect){
            .origin.x = fLeftX,
            .origin.y = (fH - titleLabelSize.height) * .5f,
            .size = titleLabelSize
        };
        
        fLeftX = CGRectGetMaxX(titleLabel.frame) + IBT_CELL_INNER_GAP;
    }
    
    
    // Left Value
    IBTUILabel *leftValueLabel = nil;
    NSString *nsLeftValue = [self getUserInfoValueForKey:CInfoLeftValueKey];
    if (nsLeftValue.length > 0) {
        leftValueLabel = [[IBTUILabel alloc] init];
        leftValueLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        leftValueLabel.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:leftValueLabel];
        
        id leftValueFont = [self getUserInfoValueForKey:CInfoLeftValueFontKey];
        if ([leftValueFont isKindOfClass:[UIFont class]]) {
            leftValueLabel.font = leftValueFont;
        }
        else {
            id leftValueFontSize = [self getUserInfoValueForKey:CInfoLeftValueFontSizeKey];
            CGFloat fLeftValueFontSize =
            ([leftValueFontSize isKindOfClass:[NSNumber class]]) ?
            [leftValueFontSize floatValue] :
            IBT_CELL_LEFT_FONT_SIZE_DEFAULT;
            leftValueLabel.font = [UIFont systemFontOfSize:fLeftValueFontSize];
        }
        
        id leftValueColor = [self getUserInfoValueForKey:CInfoLeftValueColorKey];
        if ([leftValueColor isKindOfClass:[UIColor class]]) {
            leftValueLabel.textColor = leftValueColor;
        }
        else {
            leftValueLabel.textColor = IBT_CELL_LEFT_COLOR_DEFAULT;
        }
        
        leftValueLabel.text = nsLeftValue;
        
        fW = MAX(fMaxWidth - fLeftX, IBT_CELL_LEFT_LABEL_MIN_WIDTH);
        CGSize leftLabelSize = [leftValueLabel sizeThatFits:CGSizeMake(fW, fH)];
        leftValueLabel.frame = (CGRect){
            .origin.x = fLeftX,
            .origin.y = (fH - leftLabelSize.height) * .5f,
            .size = leftLabelSize
        };
        
        fLeftX = CGRectGetMaxX(leftValueLabel.frame) + IBT_CELL_INNER_GAP;
    }
    
    // Badge
    IBTBadgeView *badgeView = nil;
    NSString *nsBadgeStr = [self getUserInfoValueForKey:CInfoBadgeKey];
    BOOL bBadgeRight = [[self getUserInfoValueForKey:CInfoBadgeAlignmentRightKey] boolValue];
    
    // Set LeftBadge
    if (nsBadgeStr && !bBadgeRight) {
        badgeView =
        [[IBTBadgeView alloc] initWithFrame:(CGRect){
            .origin.x = fLeftX,
            .origin.y = (CGRectGetHeight(cell.contentView.bounds) - DEFUALT_BADGE_HEIGHT) * .5f,
            .size.width = DEFUALT_BADGE_HEIGHT,
            .size.height = DEFUALT_BADGE_HEIGHT
        }];
        badgeView.autoresizingMask =
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        UIColor *badgeColor = [self getUserInfoValueForKey:CInfoBadgeBGColorKey];
        if ([badgeColor isKindOfClass:[UIColor class]]) {
            [badgeView setBadgeColor:badgeColor];
        }
        
        [cell.contentView addSubview:badgeView];
        
        [badgeView setString:nsBadgeStr];
        
        fLeftX = CGRectGetMaxX(badgeView.frame) + IBT_CELL_INNER_GAP;
    }
    
    // Right Value
    IBTUILabel *rightValueLabel = nil;
    NSString *nsRightValue = [self getUserInfoValueForKey:CInfoRightValueKey];
    if (nsRightValue.length > 0) {
        rightValueLabel = [[IBTUILabel alloc] init];
        rightValueLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        rightValueLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:rightValueLabel];
        
        id rightValueFont = [self getUserInfoValueForKey:CInfoRightValueFontKey];
        if ([rightValueFont isKindOfClass:[UIFont class]]) {
            rightValueLabel.font = rightValueFont;
        }
        else {
            id rightValueFontSize = [self getUserInfoValueForKey:CInfoRightValueFontSizeKey];
            CGFloat fRightValueFontSize =
            ([rightValueFontSize isKindOfClass:[NSNumber class]]) ?
            [rightValueFontSize floatValue] :
            IBT_CELL_RIGHT_FONT_SIZE_DEFAULT;
            rightValueLabel.font = [UIFont systemFontOfSize:fRightValueFontSize];
        }
        
        id rightValueColor = [self getUserInfoValueForKey:CInfoRightValueColorKey];
        if ([rightValueColor isKindOfClass:[UIColor class]]) {
            rightValueLabel.textColor = rightValueColor;
        }
        else {
            rightValueLabel.textColor = IBT_CELL_RIGHT_COLOR_DEFAULT;
        }
        
        rightValueLabel.text = nsRightValue;
        
        fW = MAX(fMaxWidth - fLeftX, IBT_CELL_RIGHT_LABEL_MIN_WIDTH);
        CGSize rightLabelSize = [rightValueLabel sizeThatFits:CGSizeMake(fW, fH)];
        rightValueLabel.frame = (CGRect){
            .origin.x = fMaxWidth - rightLabelSize.width,
            .origin.y = (fH - rightLabelSize.height) * .5f,
            .size = rightLabelSize
        };
        
        fRightX = CGRectGetMinX(rightValueLabel.frame) - IBT_CELL_INNER_GAP;
    }
    
    // Set RightBadge
    if (nsBadgeStr && bBadgeRight) {
        badgeView =
        [[IBTBadgeView alloc] initWithFrame:(CGRect){
            .origin.x = fRightX - DEFUALT_BADGE_HEIGHT,
            .origin.y = (CGRectGetHeight(cell.contentView.bounds) - DEFUALT_BADGE_HEIGHT) * .5f,
            .size.width = DEFUALT_BADGE_HEIGHT,
            .size.height = DEFUALT_BADGE_HEIGHT
        }];
        badgeView.bRightAlignment = YES;
        badgeView.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        UIColor *badgeColor = [self getUserInfoValueForKey:CInfoBadgeBGColorKey];
        if ([badgeColor isKindOfClass:[UIColor class]]) {
            [badgeView setBadgeColor:badgeColor];
        }
        
        [cell.contentView addSubview:badgeView];
        
        [badgeView setString:nsBadgeStr];
        
        fRightX = CGRectGetMinX(badgeView.frame) - IBT_CELL_INNER_GAP;
    }
}

- (void)makeSwitchCell:(IBTTableViewCell *)cell {
    UISwitch *mSwitch = [self getUserInfoValueForKey:CInfoSwitchKey];
    if ([mSwitch isKindOfClass:[UISwitch class]]) {
        mSwitch.on = [[self getUserInfoValueForKey:CInfoSwitchOnKey] boolValue];
//        NSLog(@"%@ %@", mSwitch.allTargets, [mSwitch actionsForTarget:mSwitch forControlEvent:UIControlEventValueChanged]);
//        NSLog(@"%@ %@", mSwitch.allTargets, [mSwitch actionsForTarget:mSwitch forControlEvent:UIControlEventValueChanged]);
        cell.accessoryView = mSwitch;
    }
    
    [self makeNormalCell:cell];
}

- (void)makeCenterCell:(IBTTableViewCell *)cell {
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.cell = cell;
    //    cell.editingStyle = self.editStyle;
    cell.selectionStyle = self.selectionStyle;
    cell.accessoryType = self.accessoryType;
    
    NSString *nsTitle = [self getUserInfoValueForKey:CInfoTitleKey];
    id titleFont = [self getUserInfoValueForKey:CInfoTitleFontKey];
    if ([titleFont isKindOfClass:[UIFont class]]) {
        cell.textLabel.font = titleFont;
    }
    else {
        id titleFontSize = [self getUserInfoValueForKey:CInfoTitleFontSizeKey];
        CGFloat fTitleFontSize =
        ([titleFontSize isKindOfClass:[NSNumber class]]) ?
        [titleFontSize floatValue] :
        IBT_CELL_TITLE_FONT_SIZE_DEFAULT;
        cell.textLabel.font = [UIFont systemFontOfSize:fTitleFontSize];
    }
    
    id titleColor = [self getUserInfoValueForKey:CInfoTitleColorKey];
    if ([titleColor isKindOfClass:[UIColor class]]) {
        cell.textLabel.textColor = titleColor;
    }
    else {
        cell.textLabel.textColor = IBT_CELL_TITLE_COLOR_DEFAULT;
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = nsTitle;
}

- (void)makeEditorCell:(IBTTableViewCell *)cell {
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.cell = cell;
    //    cell.editingStyle = self.editStyle;
    cell.selectionStyle = self.selectionStyle;
    cell.accessoryType = self.accessoryType;
    
    CGFloat fGap = IBT_CELL_MARGIN;
    CGFloat fLeftX = fGap;
    CGFloat fMaxWidth = CGRectGetWidth(cell.contentView.bounds) - ((cell.accessoryType !=UITableViewCellAccessoryNone || cell.accessoryView) ? 0 : fGap);
    CGFloat fW = fMaxWidth - fLeftX;
    CGFloat fH = CGRectGetHeight(cell.contentView.bounds);
    
    NSString *nsTitle = [self getUserInfoValueForKey:CInfoTitleKey];
    
    if (nsTitle) {
        id titleFont = [self getUserInfoValueForKey:CInfoTitleFontKey];
        if ([titleFont isKindOfClass:[UIFont class]]) {
            cell.textLabel.font = titleFont;
        }
        else {
            id titleFontSize = [self getUserInfoValueForKey:CInfoTitleFontSizeKey];
            CGFloat fTitleFontSize =
            ([titleFontSize isKindOfClass:[NSNumber class]]) ?
            [titleFontSize floatValue] :
            IBT_CELL_TITLE_FONT_SIZE_DEFAULT;
            cell.textLabel.font = [UIFont systemFontOfSize:fTitleFontSize];
        }
        
        id titleColor = [self getUserInfoValueForKey:CInfoTitleColorKey];
        if ([titleColor isKindOfClass:[UIColor class]]) {
            cell.textLabel.textColor = titleColor;
        }
        else {
            cell.textLabel.textColor = IBT_CELL_TITLE_COLOR_DEFAULT;
        }
        
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.text = nsTitle;
        
        
        CGSize titleLabelSize = [cell.textLabel sizeThatFits:CGSizeMake(fW, fH)];
        CGRect rect = cell.textLabel.frame;
        rect.size.width = titleLabelSize.width;
        cell.textLabel.frame = rect;
        
        
        fGap = IBT_CELL_INNER_GAP;
        id leftMargin = [self getUserInfoValueForKey:CInfoEditorLMarginKey];
        if (leftMargin) {
            fGap += [leftMargin floatValue];
        }
        
        fLeftX += CGRectGetWidth(cell.textLabel.frame) + fGap;
    }
    else {
        cell.textLabel.text = nsTitle;
    }
    
    
    UITextField *textField = [self getUserInfoValueForKey:CInfoEditorKey];
    if ([textField isKindOfClass:[UITextField class]]) {
        
        textField.keyboardType = [[self getUserInfoValueForKey:CInfoEditorKeyboardTypeKey] integerValue];
        textField.secureTextEntry = [[self getUserInfoValueForKey:CInfoEditorSecureTextEntryKey] boolValue];
        textField.placeholder = [self getUserInfoValueForKey:CInfoEditorTipKey];
        textField.autocorrectionType = self.autoCorrectionType;
        
        NSString *nsText = [self getUserInfoValueForKey:CInfoEditorTextKey];
        if (nsText) {
            textField.text = nsText;
        }
        
        fW = fMaxWidth - fLeftX;
        
        textField.frame = (CGRect){
            .origin.x = fLeftX,
            .origin.y = (fH - IBT_CELL_TEXTFIELD_DEFAULT_HEIGHT) * .5f,
            .size.width = MAX(IBT_CELL_TEXTFIELD_MIN_WIDTH, fW),
            .size.height = IBT_CELL_TEXTFIELD_DEFAULT_HEIGHT
        };
        
        [cell.contentView addSubview:textField];
        
        if ([[self getUserInfoValueForKey:CInfoEditorFocusKey] boolValue]) {
            [textField becomeFirstResponder];
        }
    }
}

#pragma mark - Cell Action
- (void)actionSwitchCell:(UISwitch *)sender {
    
    [self addUserInfoValue:@( sender.isOn ) forKey:CInfoSwitchOnKey];
    
    if (self.actionTargetForSwitchCell &&
        [self.actionTargetForSwitchCell respondsToSelector:self.actionSel]) {
        IMP imp = [self.actionTargetForSwitchCell methodForSelector:self.actionSel];
        void (*func)(id, SEL, id) = (void *)imp;
        func(self.actionTargetForSwitchCell, self.actionSel, sender);
    }
}

- (void)actionEditorCell:(NSNotification *)sender {
    
    id <UITextInput> textHolder = sender.object;
    
    if (self.actionTarget &&
        [self.actionTarget respondsToSelector:self.actionSel])
    {
        IMP imp = [self.actionTarget methodForSelector:self.actionSel];
        void (*func)(id, SEL, id) = (void *)imp;
        func(self.actionTarget, self.actionSel, self);
    }
    else {
        NSString *toBeString = [textHolder performSelector:@selector(text)];
        [self addUserInfoValue:toBeString forKey:CInfoEditorTextKey];
    }
    
}

- (void)actionUrlInnerCell {
    NSURL *url = [self getUserInfoValueForKey:CInfoURLKey];
    if ([url isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:(id)url];
    }
    
    if ([url isKindOfClass:[NSURL class]] &&
        [[UIApplication sharedApplication] canOpenURL:url])
    {
        // TODO Call your WebView
    }
}

- (void)actionUrlCell {
    NSURL *url = [self getUserInfoValueForKey:CInfoURLKey];
    if ([url isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:(id)url];
    }
    
    if ([url isKindOfClass:[NSURL class]] &&
        [[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end


/*
 @{"title":"Friend Radar","titleFont":#'<UICTFont: 0x17df36f0> font-family: ".HelveticaNeueInterface-Regular"; font-weight: normal; font-style: normal; font-size: 16.00pt',"imageName":"add_friend_icon_reda","detail":"Quickly add friends in your vicinity"}
 */
NSString * const CInfoTitleKey                  = @"title";
NSString * const CInfoTitleFontKey              = @"titleFont";
NSString * const CInfoTitleFontSizeKey          = @"titleFontSize";
NSString * const CInfoTitleColorKey             = @"titleColor";
NSString * const CInfoDetailKey                 = @"detail";
NSString * const CInfoDetailFontKey             = @"detailFont";
NSString * const CInfoDetailFontSizeKey         = @"detailFontSize";
NSString * const CInfoDetailColorKey            = @"detailColor";
NSString * const CInfoImageNameKey              = @"imageName";

/*
 @{"imageName":"MoreMyBankCard.png","title":"Wallet","badge":"New"}
 */
NSString * const CInfoBadgeKey                  = @"badge";
NSString * const CInfoBadgeBGColorKey           = @"badgeColor";
NSString * const CInfoBadgeAlignmentRightKey    = @"badgeRight";

/*
 @{"title":"Settings","rightValueFontSize":"14","imageName":"MoreSetting.png","rightValue":"Unprotected"}
 */
NSString * const CInfoRightValueKey             = @"rightValue";
NSString * const CInfoRightValueFontKey         = @"rightValueFont";
NSString * const CInfoRightValueFontSizeKey     = @"rightValueFontSize";
NSString * const CInfoRightValueColorKey        = @"rightValueColor";

/*
 @{"title":"Xummer0","leftValueColor":#"UIDeviceRGBColorSpace 0.341176 0.419608 0.584314 1","leftValue":"2333","url":"http://xummer26.com"}
 */
NSString * const CInfoLeftValueKey              = @"leftValue";
NSString * const CInfoLeftValueFontKey          = @"leftValueFont";
NSString * const CInfoLeftValueFontSizeKey      = @"leftValueFontSize";
NSString * const CInfoLeftValueColorKey         = @"leftValueColor";

NSString * const CInfoURLKey                    = @"url";
NSString * const CInfoSwipeAbleKey              = @"swipeable";

/*
 @{"switch":#"<UISwitch: 0x17ea71d0; frame = (254 6; 51 31); layer = <CALayer: 0x17ea7260>>","title":"Sticky on Top","on":false}
 */
NSString * const CInfoSwitchKey                 = @"switch";
NSString * const CInfoSwitchOnKey               = @"on";

/*
 @{"title":"WeChat ID","fEditorLMargin":0,"focus":true,"keyboardType":1,"editor":#"<UITextField: 0x180a6a50; frame = (108 7; 202 30); text = ''; clipsToBounds = YES; opaque = NO; autoresize = W; gestureRecognizers = <NSArray: 0x178e13a0>; layer = <CALayer: 0x178dc930>>","tip":" "}
 */
NSString * const CInfoEditorKey                 = @"editor";
NSString * const CInfoEditorLMarginKey          = @"fEditorLMargin";
NSString * const CInfoEditorFocusKey            = @"focus";
NSString * const CInfoEditorKeyboardTypeKey     = @"keyboardType";
NSString * const CInfoEditorSecureTextEntryKey  = @"secureTextEntry";
NSString * const CInfoEditorTextKey             = @"text";
NSString * const CInfoEditorTipKey              = @"tip";
