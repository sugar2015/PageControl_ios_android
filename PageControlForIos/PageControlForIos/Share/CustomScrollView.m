//
//  CustomScrollView.m
//  PageControlForIos
//
//  Created by wim on 16/9/21.
//  Copyright © 2016年 sugar. All rights reserved.
//

#import "CustomScrollView.h"

#import "PageView.h"

@interface CustomScrollView ()<UIScrollViewDelegate>{
    
}

@property (nonatomic, strong) NSMutableArray *imageViews;

- (void)setup;

@end


@implementation CustomScrollView

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    _scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 20);
    _pageView.frame = CGRectMake(0, _scrollView.frame.size.height, self.bounds.size.width, 20);
    
    for (int i = 0; i < _imageViews.count; i++) {
        UIImageView *imageView = (UIImageView *)[_imageViews objectAtIndex:i];
        imageView.frame = CGRectMake(i * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    }
    
   _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * _imageViews.count, _scrollView.frame.size.height);
}

- (void)setContentData:(NSArray*)datas {
    for (int i = 0; i < datas.count; i++) {
        UIColor *color = (UIColor*)[datas objectAtIndex:i];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = color;
        imageView.tag = i;
        [_scrollView addSubview:imageView];
        
        [_imageViews addObject:imageView];
    }
    [_pageView setPageCount:datas.count];
}



- (void)setup {
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _pageView = [[PageView alloc] init];
    [self addSubview:_pageView];
    
    _imageViews = [[NSMutableArray alloc] init];
}


#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x > 0 && scrollView.contentOffset.x < scrollView.contentSize.width) {
        int page = scrollView.contentOffset.x / scrollView.frame.size.width;
        float offset = fmod(scrollView.contentOffset.x, scrollView.frame.size.width);
        float changeWidth = offset * _pageView.itemWidth / scrollView.frame.size.width;
        [_pageView changeWidthAtIndex:page offset:changeWidth];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    [_pageView setSelectedAtIndex:page];
}

@end
