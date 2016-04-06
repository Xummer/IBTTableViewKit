//
//  ViewController.m
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/5.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import "ViewController.h"
#import "IBTTableView.h"
#import "IBTTableViewInfo.h"
#import "IBTTableViewCell.h"

#import "EditorCellsViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBTTableViewInfo *m_tableViewInfo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = [[NSBundle mainBundle] infoDictionary][ (NSString *)kCFBundleNameKey ];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method
- (void)initTableView {
    self.m_tableViewInfo = [[IBTTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    // Section 0
    IBTTableViewSectionInfo *secInfo = [IBTTableViewSectionInfo sectionInfoHeader:@"Profile"];
    IBTTableViewCellInfo *titleCellInfo =
    [IBTTableViewCellInfo normalCellForSel:@selector(onTitleCellInfoAction:) target:self
                                     title:@"Xummer"
                             accessoryType:UITableViewCellAccessoryNone];
    titleCellInfo.selectionStyle = UITableViewCellSelectionStyleNone;
    [secInfo addCell:titleCellInfo];
    
    IBTTableViewCellInfo *rightValueCellInfo =
    [IBTTableViewCellInfo normalCellForSel:@selector(onRightValueCellAction:) target:self
                                     title:@"Gender" rightValue:@"Male"
                             accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [secInfo addCell:rightValueCellInfo];
    
    IBTTableViewCellInfo *rightBadgeCellInfo =
    [IBTTableViewCellInfo badgeRightCellForSel:@selector(onRightValueCellAction:) target:self
                                         title:@"Age" badge:@"26"
                                    rightValue:nil imageName:nil];
    [secInfo addCell:rightBadgeCellInfo];
    [_m_tableViewInfo addSection:secInfo];
    
    // Section 1
    IBTTableViewSectionInfo *sec1Info = [IBTTableViewSectionInfo sectionInfoFooter:@"Prepare to Die -- From Software"];
    IBTTableViewCellInfo *imageCellInfo =
    [IBTTableViewCellInfo badgeCellForSel:@selector(onImageCellInfoAction:) target:self
                                    title:@"Games" badge:@"HOT" rightValue:@"Dark Souls II"
                                imageName:@"MoreGame"];
    imageCellInfo.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [sec1Info addCell:imageCellInfo];
    
    [_m_tableViewInfo addSection:sec1Info];
    
    // Section 2
    IBTTableViewSectionInfo *sec2Info = [IBTTableViewSectionInfo sectionInfoDefaut];
    IBTTableViewCellInfo *urlCellInfo =
    [IBTTableViewCellInfo urlCellForTitle:@"Xummer26.com" url:@"http://xummer26.com"];
    [sec2Info addCell:urlCellInfo];
    IBTTableViewCellInfo *innerUrlCellInfo =
    [IBTTableViewCellInfo urlInnerBlueCellForTitle:@"Home Page" leftValue:@"Xummer26.com" url:@"http://xummer26.com"];
    [innerUrlCellInfo addUserInfoValue:@( YES ) forKey:CInfoSwipeAbleKey];
    [sec2Info addCell:innerUrlCellInfo];
    
    IBTTableViewCellInfo *badgeCellInfo =
    [IBTTableViewCellInfo badgeCellForSel:@selector(onImageCellInfoAction:) target:self
                                    title:@"Custom Badge Color" badge:@"10086" rightValue:nil];
    [badgeCellInfo addUserInfoValue:[UIColor colorWithRed:0 green:216.0f/255.0f blue:0 alpha:1]
                             forKey:CInfoBadgeBGColorKey];
    badgeCellInfo.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [sec2Info addCell:badgeCellInfo];
    
    [_m_tableViewInfo addSection:sec2Info];
    
    
    // Section 3
    IBTTableViewSectionInfo *sec3Info = [IBTTableViewSectionInfo sectionInfoFooter:@"Editor cells tests"];
    IBTTableViewCellInfo *centerCellInfo =
    [IBTTableViewCellInfo centerCellForSel:@selector(onCenterCellAction:) target:self title:@"Here We Go"];
    [sec3Info addCell:centerCellInfo];
    [_m_tableViewInfo addSection:sec3Info];
    
    
    // Section 4
    IBTTableViewSectionInfo *sec4Info = [IBTTableViewSectionInfo sectionInfoDefaut];
    IBTTableViewCellInfo *detailCellInfo =
    [IBTTableViewCellInfo normalCellForSel:@selector(onDetailCellAction:) target:self title:@"GitHub" rightValue:nil imageName:@"MoreMyFavorites" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [detailCellInfo addUserInfoValue:@"https://github.com/Xummer" forKey:CInfoDetailKey];
    detailCellInfo.fCellHeight = 60;
    [sec4Info addCell:detailCellInfo];
    
    IBTTableViewCellInfo *switchCellInfo =
    [IBTTableViewCellInfo switchCellForSel:@selector(onSwitchChange:) target:self
                                     title:@"Follow" on:YES];
    [sec4Info addCell:switchCellInfo];
    [_m_tableViewInfo addSection:sec4Info];
    
    // Section 5
    IBTTableViewSectionInfo *sec5Info = [IBTTableViewSectionInfo sectionInfoDefaut];
    IBTTableViewCellInfo *customCellInfo = [IBTTableViewCellInfo new];
    customCellInfo.makeTarget = self;
    customCellInfo.makeSel = @selector(makeCustomCell:);
    customCellInfo.actionTarget = self;
    customCellInfo.actionSel = @selector(onCustomCellAction:);
    customCellInfo.selectionStyle = UITableViewCellSelectionStyleNone;
    [sec5Info addCell:customCellInfo];
    [_m_tableViewInfo addSection:sec5Info];
    
    // Add tableView
    IBTTableView *tableV = [_m_tableViewInfo getTableView];
    [self.view addSubview:tableV];
}

- (void)makeCustomCell:(IBTTableViewCellInfo *)cellInfo {
    
    IBTTableViewCell *cell = cellInfo.cell;
    for (UIView *v in [cell.contentView subviews]) {
        [v removeFromSuperview];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    UILabel *customLabel = [[UILabel alloc] initWithFrame:CGRectInset(cell.contentView.bounds, 15, 0)];
    customLabel.font = [UIFont boldSystemFontOfSize:17];
    
    NSString *nsText = @"Google";
    
    if ([customLabel respondsToSelector:@selector(attributedText)]) {
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:nsText
                                               attributes:@{
                                                            NSForegroundColorAttributeName : customLabel.textColor,
                                                            NSFontAttributeName : customLabel.font
                                                            }];
        UIColor *blue = [UIColor colorWithRed:66/255.0f green:133/255.0f blue:244/255.0f alpha:1];
        UIColor *red = [UIColor colorWithRed:234/255.0f green:67/255.0f blue:53/255.0f alpha:1];
        UIColor *yellow = [UIColor colorWithRed:251/255.0f green:188/255.0f blue:5/255.0f alpha:1];
        UIColor *green = [UIColor colorWithRed:52/255.0f green:168/255.0f blue:83/255.0f alpha:1];
        [attributedText setAttributes:@{ NSForegroundColorAttributeName : blue }
                                range:NSMakeRange(0, 1)];
        [attributedText setAttributes:@{ NSForegroundColorAttributeName : red }
                                range:NSMakeRange(1, 1)];
        [attributedText setAttributes:@{ NSForegroundColorAttributeName : yellow }
                                range:NSMakeRange(2, 1)];
        [attributedText setAttributes:@{ NSForegroundColorAttributeName : blue }
                                range:NSMakeRange(3, 1)];
        [attributedText setAttributes:@{ NSForegroundColorAttributeName : green }
                                range:NSMakeRange(4, 1)];
        [attributedText setAttributes:@{ NSForegroundColorAttributeName : red }
                                range:NSMakeRange(5, 1)];
        customLabel.attributedText = attributedText;
    }
    else {
        customLabel.text = nsText;
    }
    
    [cell.contentView addSubview:customLabel];
}

#pragma mark - Actions
- (void)onTitleCellInfoAction:(id)sender {
    NSLog(@"onTitleCellInfoAction:");
}

- (void)onRightValueCellAction:(id)sender {
    NSLog(@"onRightValueCellAction:");
}

- (void)onImageCellInfoAction:(id)sender {
    NSLog(@"onImageCellInfoAction:");
}

- (void)onSwitchChange:(id)sender {
    NSLog(@"onSwitchChange:%@", sender);
    IBTTableViewCellInfo *switchCellInfo = [_m_tableViewInfo getCellAtSection:4 row:1];
    NSLog(@"%@", [switchCellInfo valueForKey:@"_dicInfo"]);
}

- (void)onCenterCellAction:(id)sender {
    NSLog(@"onCenterCellAction:");
    
    EditorCellsViewController *editVC = [[EditorCellsViewController alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)onDetailCellAction:(id)sender {
    NSLog(@"onDetailCellAction:");
}

- (void)onCustomCellAction:(id)sender {
    NSLog(@"onCustomCellAction");
}

@end
