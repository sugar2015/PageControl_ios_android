//
//  PageView.m
//  PageControlForIos
//
//  Created by wim on 16/9/21.
//  Copyright © 2016年 sugar. All rights reserved.
//

#import "PageView.h"

#import "FirstItemView.h"

@interface PageView (){
    
}

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger maxWidth;
@property (nonatomic, assign) NSInteger itemHeight;
@property (nonatomic, assign) NSInteger itemSpace;
@property (nonatomic, assign) float originX;

@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, assign) NSInteger currentIndex;


- (void)setup;

@end

@implementation PageView

- (id)init {
    self = [super init];
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



- (void)setup {
    _itemWidth = 20;
    _itemHeight = 10;
    _itemSpace = 10;
    
    _maxWidth = _itemWidth * 2;
    
    _pageViews = [[NSMutableArray alloc] init];
    _currentIndex = -1;
}

- (void)setPageCount:(NSInteger)count {
    _count = count;
    
    [_pageViews removeAllObjects];
    
    for (NSInteger i = 0; i < _count; i++) {
        FirstItemView *pageItemView = [[FirstItemView alloc] init];
        pageItemView.tag = i;
        pageItemView.normalWidth = _itemWidth;
        pageItemView.maxWidth = _maxWidth;
        [self addSubview:pageItemView];
        
        [_pageViews addObject:pageItemView];
    }
    
    [self setSelectedAtIndex:0];
}


- (void)setSelectedAtIndex:(NSInteger)index{
    if (index == _currentIndex) {
        return;
    }
    
    for (int i = 0; i < _count; i++) {
        FirstItemView *pageItemView = (FirstItemView*)[_pageViews objectAtIndex:i];
        if (i == index) {
            pageItemView.selected = YES;
            [pageItemView changeWidth:_maxWidth];
        }
        else{
            pageItemView.selected = NO;
            [pageItemView changeWidth:_itemWidth];
            [pageItemView resetNormalColor];
        }
    }
    _currentIndex = index;
}

- (void)changeWidthAtIndex:(NSInteger)index offset:(float)offset{
    FirstItemView *itemView = (FirstItemView*)[_pageViews objectAtIndex:index];
    float tempWidth = _maxWidth - offset;
    [itemView changeWidth:tempWidth];
    if (index + 1 < _count ) {
        FirstItemView *otherItemView = (FirstItemView*)[_pageViews objectAtIndex:index + 1];
        [otherItemView changeWidth:_itemWidth + offset];
    }
}



- (void)layoutSubviews{
    _originX = (self.frame.size.width - (_itemWidth * _count) - (_count - 1) * _itemSpace - _itemWidth) / 2.0;
    float y = (self.frame.size.height - _itemHeight) / 2;
    float x = _originX;
    for (NSInteger i = 0; i < _pageViews.count; i++) {
        FirstItemView *pageItemView = (FirstItemView*)[_pageViews objectAtIndex:i];
        
        float width = pageItemView.frame.size.width;
    
        pageItemView.frame = CGRectMake(x, y, width, _itemHeight);
        x += width + _itemSpace;
    }
}

@end
