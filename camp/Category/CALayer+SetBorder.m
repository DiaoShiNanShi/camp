//
//  CALayer+SetBorder.m
//  camp
//
//  Created by 张三好 on 2017/5/2.
//  Copyright © 2017年 张三好. All rights reserved.
//

#import "CALayer+SetBorder.h"

@implementation CALayer (SetBorder)
- (void)setBorderUIColor:(UIColor *)borderUIColor{
    self.borderColor = borderUIColor.CGColor;
}
- (UIColor *)borderUIColor{
    return [UIColor colorWithCGColor:(__bridge CGColorRef _Nonnull)(self.borderUIColor)];
}
@end
