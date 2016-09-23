//
//  ColorEvaluator.h
//  PageControlForIos
//
//  Created by wim on 16/9/22.
//  Copyright © 2016年 sugar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorEvaluator : NSObject

- (id)initWithColor:(NSString*)startColor endColor:(NSString*)endColor;

- (void)setColor:(NSString*)startColor endColor:(NSString*)endColor;

- (UIColor*)getCurrentColor:(CGFloat)offset;



@end
