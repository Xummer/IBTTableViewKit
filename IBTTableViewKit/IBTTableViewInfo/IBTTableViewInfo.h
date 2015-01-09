//
//  IBTTableViewInfo.h
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/5.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import "IBTTableViewUserInfo.h"
#import "IBTTableViewSectionInfo.h"
#import "IBTTableViewCellInfo.h"
#import "IBTTableView.h"

@class IBTTableView;
@protocol IBTTableViewInfoDelegate;
@interface IBTTableViewInfo : IBTTableViewUserInfo

@property(assign, nonatomic, setter=setDelegate:) id<IBTTableViewInfoDelegate> delegate;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

- (IBTTableView *)getTableView;

// Section
// return |IBTTableViewSectionInfo|
- (IBTTableViewSectionInfo *)getSectionAt:(NSUInteger)secIndex;
- (void)addSection:(IBTTableViewSectionInfo *)section;
- (void)removeSectionAt:(NSUInteger)secIndex;
- (NSUInteger)getSectionCount;
- (void)clearAllSection;

// Cell
// return |IBTTableViewCellInfo|
- (IBTTableViewCellInfo *)getCellAtSection:(NSUInteger)section row:(NSUInteger)row;
- (void)removeCellAt:(NSIndexPath *)indexPath;

@end
