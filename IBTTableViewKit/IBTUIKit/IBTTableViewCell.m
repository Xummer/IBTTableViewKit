//
//  IBTTableViewCell.m
//  IBTTableViewKit
//
//  Created by Xummer on 15/1/5.
//  Copyright (c) 2015年 Xummer. All rights reserved.
//

#import "IBTTableViewCell.h"

@interface IBTTableViewCell ()
@end

@implementation IBTTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Setter
- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType {
    [super setAccessoryType:accessoryType];
    
    switch (accessoryType) {
        case UITableViewCellAccessoryDisclosureIndicator:
        {            
            __block UIButton *arrowBtn = nil;
            [self.subviews enumerateObjectsWithOptions:NSEnumerationReverse
                                            usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                if ([obj isKindOfClass:[UIButton class]]) {
                                                    arrowBtn = obj;
                                                    *stop = YES;
                                                }
                                            }];
            
            [arrowBtn setImage:[UIImage imageNamed:@"CellCustomArrow"]
                      forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Private
- (void)addCustomArrow {
    
    UIImage *image = [UIImage imageNamed:@"CellCustomArrow"];
    UIButton *customArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    [customArrow setImage:image forState:UIControlStateNormal];
    customArrow.frame = (CGRect){
        .origin.x = CGRectGetWidth(self.bounds) - 11 - image.size.width,
        .origin.y = (CGRectGetHeight(self.bounds) - image.size.height) * .5f,
        .size = image.size
    };
    [self addSubview:customArrow];
    
    self.accessoryView = customArrow;
}

@end
