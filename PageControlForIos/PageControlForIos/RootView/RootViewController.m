//
//  RootViewController.m
//  PageControlForIos
//
//  Created by wim on 16/9/20.
//  Copyright © 2016年 sugar. All rights reserved.
//

#import "RootViewController.h"

#import "UIView+Border.h"
#import "NSString+HexColor.h"

#import "CustomScrollView.h"



@interface RootViewController () {
    NSMutableArray *_colors;
    
}

@end

@implementation RootViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _colors = [[NSMutableArray alloc] init];
    [_colors addObject:[@"CAB5A3" colorValue]];
    [_colors addObject:[@"E6AD73" colorValue]];
    [_colors addObject:[@"5D9EA1" colorValue]];
    [_colors addObject:[@"C2606f" colorValue]];
    
    [_customScrollView setContentData:_colors];
    
    [_customScrollView showBorder:[@"0B9FDD" colorValue]];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}







@end
