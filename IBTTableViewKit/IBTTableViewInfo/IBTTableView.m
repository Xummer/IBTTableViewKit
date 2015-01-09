//
//  IBTTableView.m
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/5.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import "IBTTableView.h"

@implementation IBTTableView

- (void)setContentInsetTop:(CGFloat)top andBottom:(CGFloat)bottom {
    self.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.scrollIndicatorInsets = self.contentInset;
}

@end
