//
//  IBTTableViewCellInfo.h
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/5.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import "IBTTableViewUserInfo.h"

@class IBTTableViewCell;
@interface IBTTableViewCellInfo : IBTTableViewUserInfo
@property (weak,   nonatomic) id actionTargetForSwitchCell;
//@property (assign, nonatomic) BOOL bTitleNormalFont;
//@property (assign, nonatomic) BOOL bNeedSeperateLine;
@property (weak,   nonatomic) IBTTableViewCell* cell;

@property (assign, nonatomic) UITableViewCellStyle cellStyle;
@property (assign, nonatomic) UITextAutocorrectionType autoCorrectionType;
@property (assign, nonatomic) UITableViewCellEditingStyle editStyle;
@property (assign, nonatomic) UITableViewCellAccessoryType accessoryType;
@property (assign, nonatomic) UITableViewCellSelectionStyle selectionStyle;

@property (assign, nonatomic) CGFloat fCellHeight;
@property (weak,   nonatomic) id calHeightTarget;
@property (assign, nonatomic) SEL calHeightSel;
@property (weak,   nonatomic) id actionTarget;
@property (assign, nonatomic) SEL actionSel;
@property (weak,   nonatomic) id makeTarget;
@property (assign, nonatomic) SEL makeSel;

// Normal
+ (IBTTableViewCellInfo *)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue;

+ (IBTTableViewCellInfo *)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue
                                   imageName:(NSString *)imgName;

+ (IBTTableViewCellInfo *)normalCellForSel:(SEL)sel target:(id)target
                                     title:(NSString *)title
                             accessoryType:(UITableViewCellAccessoryType)type;

+ (IBTTableViewCellInfo *)normalCellForSel:(SEL)sel target:(id)target
                                     title:(NSString *)title
                                rightValue:(NSString *)rightValue
                             accessoryType:(UITableViewCellAccessoryType)type;

+ (IBTTableViewCellInfo *)normalCellForSel:(SEL)sel target:(id)target
                                     title:(NSString *)title
                                rightValue:(NSString *)rightValue
                                 imageName:(NSString *)imgName
                             accessoryType:(UITableViewCellAccessoryType)type;

+ (IBTTableViewCellInfo *)badgeRightCellForSel:(SEL)sel target:(id)target
                                         title:(NSString *)title badge:(id)badge rightValue:(NSString *)rightValue
                                     imageName:(NSString *)name;

+ (IBTTableViewCellInfo *)badgeCellForSel:(SEL)sel target:(id)target
                                    title:(NSString *)title badge:(id)badge rightValue:(NSString *)rightValue
                                imageName:(NSString *)name;
+ (IBTTableViewCellInfo *)badgeCellForSel:(SEL)sel target:(id)target
                                    title:(NSString *)title badge:(id)badge rightValue:(NSString *)rightValue;
+ (IBTTableViewCellInfo *)badgeCellForSel:(SEL)sel target:(id)target
                                    title:(NSString *)title badge:(id)badge;

+ (IBTTableViewCellInfo *)switchCellForSel:(SEL)sel target:(id)target
                                     title:(NSString *)title on:(BOOL)bOn;

+ (IBTTableViewCellInfo *)centerCellForSel:(SEL)sel target:(id)target
                                     title:(NSString *)title;

// Open url Inner WebView
+ (IBTTableViewCellInfo *)urlInnerBlueCellForTitle:(NSString *)title leftValue:(NSString *)value url:(id)url;

// Open url Safari (Call open url)
+ (IBTTableViewCellInfo *)urlCellForTitle:(NSString *)title url:(id)url;

+(IBTTableViewCellInfo *)editorCellForSel:(SEL)sel target:(id)target
                                      tip:(NSString *)tip focus:(BOOL)focus text:(NSString *)text;
+(IBTTableViewCellInfo *)editorCellForSel:(SEL)sel target:(id)target
                                      tip:(NSString *)tip focus:(BOOL)focus autoCorrect:(BOOL)correct
                                     text:(NSString *)text;
+(IBTTableViewCellInfo *)editorCellForSel:(SEL)sel target:(id)target
                                    title:(NSString *)title margin:(CGFloat)margin
                                      tip:(NSString *)tip focus:(BOOL)focus
                                     text:(NSString *)text;

+ (IBTTableViewCellInfo *)editorCellForSel:(SEL)sel target:(id)target
                                     title:(NSString *)title
                                    margin:(CGFloat)margin tip:(NSString *)tip
                               autoCorrect:(BOOL)correct focus:(BOOL)focus
                                      text:(NSString *)text;

- (void)makeNormalCell:(IBTTableViewCellInfo *)cellInfo;
- (void)makeSwitchCell:(IBTTableViewCellInfo *)cellInfo;
- (void)makeCenterCell:(IBTTableViewCellInfo *)cellInfo;
- (void)makeEditorCell:(IBTTableViewCellInfo *)cellInfo;

@end

#define IBT_CELL_MARGIN                                (15.0f)

/*
 @{"title":"Friend Radar","titleFont":#'<UICTFont: 0x17df36f0> font-family: ".HelveticaNeueInterface-Regular"; font-weight: normal; font-style: normal; font-size: 16.00pt',"imageName":"add_friend_icon_reda","detail":"Quickly add friends in your vicinity"}
 */
FOUNDATION_EXPORT NSString * const CInfoTitleKey;
FOUNDATION_EXPORT NSString * const CInfoTitleFontKey;
FOUNDATION_EXPORT NSString * const CInfoTitleFontSizeKey;
FOUNDATION_EXPORT NSString * const CInfoTitleColorKey;

FOUNDATION_EXPORT NSString * const CInfoDetailKey;
FOUNDATION_EXPORT NSString * const CInfoDetailFontKey;
FOUNDATION_EXPORT NSString * const CInfoDetailFontSizeKey;
FOUNDATION_EXPORT NSString * const CInfoDetailColorKey;

FOUNDATION_EXPORT NSString * const CInfoImageNameKey;
FOUNDATION_EXPORT NSString * const CInfoImageRightMarginKey;

/*
 @{"imageName":"MoreMyBankCard.png","title":"Wallet","badge":"New", "badgeRight":YES}
 */
FOUNDATION_EXPORT NSString * const CInfoBadgeKey;
FOUNDATION_EXPORT NSString * const CInfoBadgeBGColorKey;
FOUNDATION_EXPORT NSString * const CInfoBadgeAlignmentRightKey;

/*
 @{"title":"Settings","rightValueFontSize":"14","imageName":"MoreSetting.png","rightValue":"Unprotected"}
 */
FOUNDATION_EXPORT NSString * const CInfoRightValueKey;
FOUNDATION_EXPORT NSString * const CInfoRightValueFontKey;
FOUNDATION_EXPORT NSString * const CInfoRightValueFontSizeKey;
FOUNDATION_EXPORT NSString * const CInfoRightValueColorKey;

/*
 @{"title":"Xummer0","leftValueColor":#"UIDeviceRGBColorSpace 0.341176 0.419608 0.584314 1","leftValue":"2333","url":"http://xummer26.com"}
 */
FOUNDATION_EXPORT NSString * const CInfoLeftValueKey;
FOUNDATION_EXPORT NSString * const CInfoLeftValueFontKey;
FOUNDATION_EXPORT NSString * const CInfoLeftValueFontSizeKey;
FOUNDATION_EXPORT NSString * const CInfoLeftValueColorKey;

FOUNDATION_EXPORT NSString * const CInfoURLKey;
FOUNDATION_EXPORT NSString * const CInfoSwipeAbleKey;   // swipe show delete button

/*
 @{"switch":#"<UISwitch: 0x17ea71d0; frame = (254 6; 51 31); layer = <CALayer: 0x17ea7260>>","title":"Sticky on Top","on":false}
 */
FOUNDATION_EXPORT NSString * const CInfoSwitchKey;
FOUNDATION_EXPORT NSString * const CInfoSwitchOnKey;

/*
 @{"title":"WeChat ID","fEditorLMargin":0,"focus":true,"keyboardType":1,"editor":#"<UITextField: 0x180a6a50; frame = (108 7; 202 30); text = ''; clipsToBounds = YES; opaque = NO; autoresize = W; gestureRecognizers = <NSArray: 0x178e13a0>; layer = <CALayer: 0x178dc930>>","tip":" "}
 */
FOUNDATION_EXPORT NSString * const CInfoEditorKey;
FOUNDATION_EXPORT NSString * const CInfoEditorLMarginKey;
FOUNDATION_EXPORT NSString * const CInfoEditorFocusKey;
FOUNDATION_EXPORT NSString * const CInfoEditorKeyboardTypeKey;
FOUNDATION_EXPORT NSString * const CInfoEditorSecureTextEntryKey;
FOUNDATION_EXPORT NSString * const CInfoEditorTextKey;
FOUNDATION_EXPORT NSString * const CInfoEditorTipKey;
