//
//  FirstItemView.m
//  PageControlForIos
//
//  Created by wim on 16/9/21.
//  Copyright © 2016年 sugar. All rights reserved.
//

#import "FirstItemView.h"

#import "NSString+HexColor.h"

#import "ColorEvaluator.h"

@interface FirstItemView (){
    UIBezierPath *_path;
    
    CAShapeLayer *_shapeLayer;
    
    ColorEvaluator *_colorEvaluator;
    ColorEvaluator *_reveseColorEvaluator;
    
    CGFloat _curWidth;
    
}

@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *curColor;



@end

@implementation FirstItemView

- (id)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _selectedColorString = @"72AA50";
        _normalColorString = @"F9FbFc";
        
        _selectedColor = [_selectedColorString colorValue];
        _normalColor = [_normalColorString colorValue];
        
        _colorEvaluator = [[ColorEvaluator alloc] initWithColor:_normalColorString endColor:_selectedColorString];
        _reveseColorEvaluator = [[ColorEvaluator alloc] initWithColor:_selectedColorString endColor:_normalColorString];
        
        _curColor = _selectedColor;
    }
    return self;
}


- (void)setSelected:(BOOL)selected {
    _selected = selected;
}

- (void)resetNormalColor {
    _normalColor = [_normalColorString colorValue];
}

- (void)changeWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
    if (width > _curWidth && _curWidth != 0) {
        float offset = (width - _normalWidth) / _normalWidth;
        _curColor = [_colorEvaluator getCurrentColor:offset];
        _normalColor = _curColor;
    }
    else if (width < _curWidth && _curWidth != 0){
        float offset = (_maxWidth - width) / _normalWidth;
        _curColor = [_reveseColorEvaluator getCurrentColor:offset];
        
    }
    
    _curWidth = width;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [_shapeLayer removeFromSuperlayer];
 
    _path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:10];
    [_path stroke];
    
    if (!_shapeLayer) {
        _shapeLayer = [[CAShapeLayer alloc] init];
    }
    if (_selected) {
        _shapeLayer.fillColor = _curColor.CGColor;
    }
    else{
        _shapeLayer.fillColor = _normalColor.CGColor;
    }
    _shapeLayer.path = _path.CGPath;
    _shapeLayer.lineWidth = 1;
    _shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    if (!_shapeLayer.superlayer) {
        [self.layer addSublayer:_shapeLayer];
    }
}






@end
