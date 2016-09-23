//
//  PageView.h
//  PageControlForIos
//
//  Created by wim on 16/9/21.
//  Copyright © 2016年 sugar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageView : UIView

@property (nonatomic, assign) NSInteger itemWidth;

- (void)setPageCount:(NSInteger)count;

- (void)setSelectedAtIndex:(NSInteger)index;

- (void)changeWidthAtIndex:(NSInteger)index offset:(float)offset;


@end


