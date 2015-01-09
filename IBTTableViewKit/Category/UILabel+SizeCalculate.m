//
//  UILabel+SizeCalculate.m
//  
//
//  Created by Xummer on 14-2-19.
//  Copyright (c) 2014年 Xummer. All rights reserved.
//

#import "UILabel+SizeCalculate.h"

@implementation UILabel (SizeCalculate)

+ (CGSize)getSizeWithText:(NSString *)text font:(UIFont *)font andSize:(CGSize)size {
    CGSize expectedLabelSize = CGSizeZero;
    if (!font || !text ) {
        return expectedLabelSize;
    }
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *stringAttributes = @{ NSFontAttributeName : font };
        
        expectedLabelSize =
        [text boundingRectWithSize:size
                           options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                        attributes:stringAttributes
                           context:nil].size;
    }
    else {
        expectedLabelSize =
        [text sizeWithFont:font
         constrainedToSize:size
             lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return expectedLabelSize;
}

+ (CGSize)getSizeWithText:(NSString *)text font:(UIFont *)font andWidth:(CGFloat)width {
    return [[self class] getSizeWithText:text
                                    font:font
                                 andSize:CGSizeMake(width, MAXFLOAT)];
}

+ (CGFloat)getWidthWithText:(NSString *)text font:(UIFont *)font andHeight:(CGFloat)height {
    CGSize expectedLabelSize = CGSizeZero;
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *stringAttributes = @{ NSFontAttributeName : font };
        
        expectedLabelSize =
        [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                           options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                        attributes:stringAttributes
                           context:nil].size;
    }
    else {
        expectedLabelSize =
        [text sizeWithFont:font
         constrainedToSize:CGSizeMake(MAXFLOAT, height)
             lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return ceil(expectedLabelSize.width);
}

+ (CGFloat)getLabelWidth:(UILabel *)label {
    return [[self class] getWidthWithText:label.text
                                     font:label.font
                                andHeight:CGRectGetHeight(label.frame)];
}

+ (CGFloat)getLabelHeight:(UILabel *)label {
    return [[self class] getHeightWithText:label.text
                                      font:label.font
                                  andWidth:label.frame.size.width];
}

+ (CGSize)getLabelSize:(UILabel *)label {
    
    return [[self class] getSizeWithText:label.text
                                    font:label.font
                                andWidth:CGRectGetWidth(label.frame)];
}

+ (CGFloat)getHeightWithText:(NSString *)text font:(UIFont *)font andWidth:(CGFloat)width {
    return ceil([[self class] getSizeWithText:text
                                         font:font
                                     andWidth:width].height);
}

- (CGFloat)calculateWidth {
    return [[self class] getLabelWidth:self];
}

- (CGFloat)calculateHeight {
    return [[self class] getLabelHeight:self];
}

- (CGSize)calculateSize {
    return [[self class] getLabelSize:self];
}
@end
