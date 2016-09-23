//
//  UIView+Border.m
//  PageControlForIos
//
//  Created by wim on 16/9/22.
//  Copyright © 2016年 sugar. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (Border)

- (void)showBorder:(UIColor*)color {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 2.0f;
}

@end
