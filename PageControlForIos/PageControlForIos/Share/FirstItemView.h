//
//  FirstItemView.h
//  PageControlForIos
//
//  Created by wim on 16/9/21.
//  Copyright © 2016年 sugar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstItemView : UIView

@property (nonatomic, assign) NSInteger normalWidth;
@property (nonatomic, assign) NSInteger maxWidth;

@property (nonatomic, strong) NSString *selectedColorString;
@property (nonatomic, strong) NSString *normalColorString;

@property (nonatomic, assign) BOOL selected;

- (void)changeWidth:(CGFloat)width;
- (void)resetNormalColor;


@end
