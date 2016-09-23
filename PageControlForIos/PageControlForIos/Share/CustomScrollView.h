//
//  CustomScrollView.h
//  PageControlForIos
//
//  Created by wim on 16/9/21.
//  Copyright © 2016年 sugar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageView;

@interface CustomScrollView : UIView

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) PageView *pageView;

- (void)setContentData:(NSArray*)datas;

@end
