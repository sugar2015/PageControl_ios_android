//
//  ColorEvaluator.m
//  PageControlForIos
//
//  Created by wim on 16/9/22.
//  Copyright © 2016年 sugar. All rights reserved.
//

#import "ColorEvaluator.h"

#import "NSString+HexColor.h"

@interface ColorEvaluator (){
    NSInteger _startColor;
    NSInteger _endColor;
    
    NSInteger _startRed;
    NSInteger _startGreen;
    NSInteger _startBlue;
    
    NSInteger _endRed;
    NSInteger _endGreen;
    NSInteger _endBlue;
    
    NSInteger _currentRed;
    NSInteger _currentGreen;
    NSInteger _currentBlue;
    
    NSInteger _redDiff;
    NSInteger _greenDiff;
    NSInteger _blueDiff;
    
    BOOL _canChange;
    BOOL _isMaxBlue;
    BOOL _isMaxGreen;
    BOOL _isMaxRed;
}

@end

@implementation ColorEvaluator

- (id)initWithColor:(NSString*)startColor endColor:(NSString*)endColor {
    self = [super init];
    if (self) {
        [self setColor:startColor endColor:endColor];
    }
    return self;
}

- (void)setColor:(NSString*)startColor endColor:(NSString*)endColor{
    _startColor = [self toInt:startColor];
    _endColor = [self toInt:endColor];
    
    _startRed = [self toInt:[startColor substringWithRange:NSMakeRange(0, 2)]];
    _startGreen = [self toInt:[startColor substringWithRange:NSMakeRange(2, 2)]];
    _startBlue = [self toInt:[startColor substringWithRange:NSMakeRange(4, 2)]];
    
    _endRed = [self toInt:[endColor substringWithRange:NSMakeRange(0, 2)]];
    _endGreen = [self toInt:[endColor substringWithRange:NSMakeRange(2, 2)]];
    _endBlue = [self toInt:[endColor substringWithRange:NSMakeRange(4, 2)]];
    
    _currentRed = _startRed;
    _currentGreen = _startGreen;
    _currentBlue = _startBlue;
    
    _redDiff = labs(_startRed - _endRed);
    _greenDiff = labs(_startGreen - _endGreen);
    _blueDiff = labs(_startBlue - _endBlue);
}


- (NSInteger)getChangeOfSingleColor:(NSInteger)startColor
                   endColor:(NSInteger)endColor
                  colorDiff:(NSInteger)colorDiff
                   fraction:(float)fraction{
    NSInteger currentColor;
    if (startColor > endColor) {
        currentColor = (NSInteger) (startColor - fraction * colorDiff);
     
    } else {
        currentColor = (NSInteger) (startColor + fraction * colorDiff);
    }
    
    return currentColor;
}

- (UIColor*)getCurrentColor:(CGFloat)offset{
    NSString *color = @"";
    if (offset > 0.0) {
        float fraction  = offset;
        
        NSInteger curRed = [self getChangeOfSingleColor:_startRed endColor:_endRed colorDiff:_redDiff fraction:fraction];
        if (_startRed > _endRed && curRed >= _endRed) {
            _currentRed = curRed;
        }
        else if (_startRed <= _endRed && curRed <= _endRed){
            _currentRed = curRed;
        }
        
        NSInteger curGreen = [self getChangeOfSingleColor:_startGreen endColor:_endGreen colorDiff:_greenDiff fraction:fraction];
        if (_startGreen > _endGreen && curGreen >= _endGreen) {
                _currentGreen = curGreen;
        }
        else if (_startGreen <= _endGreen && curGreen <= _endGreen){
            _currentGreen = curGreen;
        }
        
        NSInteger curBlue = [self getChangeOfSingleColor:_startBlue endColor:_endBlue colorDiff:_blueDiff fraction:fraction];
        if (_startBlue > _endBlue && curBlue >= _endBlue) {
            _currentBlue = curBlue;
        }
        else if (_startBlue < _endBlue && curBlue <= _endBlue) {
            _currentBlue = curBlue;
        }
        
        
    }
    
    color = [NSString stringWithFormat:@"%@%@%@",[self toHex:_currentRed],[self toHex:_currentGreen],[self toHex:_currentBlue]];
    
//    NSLog(@"%@",color);
    return [color colorValue];
}

- (unsigned int)toInt:(NSString*)string {
    unsigned int number = 0;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner scanHexInt:&number];
    return number;
}


- (NSString *)toHex:(NSInteger)number
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=number%16;
        number=number/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        
        if (number == 0) {
            break;
        }
    }
    
    if ([str length] == 1) {
        str = [@"0" stringByAppendingString:str];
    }
    return str;
}

@end
