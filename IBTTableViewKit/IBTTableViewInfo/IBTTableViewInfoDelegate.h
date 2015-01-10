//
//  IBTTableViewInfoDelegate.h
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/5.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IBTTableViewInfoDelegate <NSObject, UIScrollViewDelegate>
@optional
- (void)commitEditingForRowAtIndexPath:(NSIndexPath *)indexPath Cell:(id)cellInfo;
- (void)accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath Cell:(id)cellInfo;

@end
