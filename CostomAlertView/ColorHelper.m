//
//  ColorHelper.m
//  AnyfishApp
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Anyfish. All rights reserved.
//

#import "ColorHelper.h"

@implementation ColorHelper

+ (NSArray *)colorsWithARGBString:(NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];//字符串处理
    
    //例子，stringToConvert #ffffff
    if ([cString length] < 6){
        return [NSArray arrayWithObjects:DEFAULT_VOID_COLOR, nil];//如果非十六进制，返回白色
    }
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];//去掉头
    if ([cString length] != 6)//去头非十六进制，返回白色
        return [NSArray arrayWithObjects:DEFAULT_VOID_COLOR, nil];
    //分别取RGB的值
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    //NSScanner把扫描出的制定的字符串转换成Int类型
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //转换为UIColor
    return [NSArray arrayWithObjects:[UIColor colorWithRed:((float) r / 255.0f)
                                                     green:((float) g / 255.0f)
                                                      blue:((float) b / 255.0f)
                                                     alpha:1.0f],
            [UIColor colorWithRed:((float) (r>40 ? r-30 : r) / 255.0f)
                            green:((float) (g>40 ? g-30 : g) / 255.0f)
                             blue:((float) (b>40 ? b-30 : b) / 255.0f)
                            alpha:1.0f],
            nil];
}

+ (UIColor *)colorWithARGBString:(NSString *) stringToConvert alpha:(CGFloat)alpha{
    if([self isEmptyString:stringToConvert])
        return DEFAULT_VOID_COLOR;
    
    stringToConvert = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];//字符串处理
    
    //例子，stringToConvert #ffffff
    if ([stringToConvert length] < 6){
        return DEFAULT_VOID_COLOR;//如果非十六进制，返回白色
    }
    if ([stringToConvert hasPrefix:@"#"])
        stringToConvert = [stringToConvert substringFromIndex:1];//去掉头
    if ([stringToConvert length] != 6)//去头非十六进制，返回白色
        return DEFAULT_VOID_COLOR;
    
    unsigned int r, g, b;
    //NSScanner把扫描出的制定的字符串转换成Int类型
    [[NSScanner scannerWithString:[stringToConvert substringWithRange:NSMakeRange(0, 2)]] scanHexInt:&r];
    [[NSScanner scannerWithString:[stringToConvert substringWithRange:NSMakeRange(2, 2)]] scanHexInt:&g];
    [[NSScanner scannerWithString:[stringToConvert substringWithRange:NSMakeRange(4, 2)]] scanHexInt:&b];
    //转换为UIColor
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

+ (UIColor *)colorWithARGBString:(NSString *) stringToConvert
{
    return [ColorHelper colorWithARGBString:stringToConvert alpha:1.0];
}

#pragma mark - 字符串判断
+ (NSString *)trimWhitespace:(NSString *)string
{
    NSMutableString *str = [string mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    return str;
}

+ (BOOL)isNilOrEmpty:(NSString *)str{
    if(str){
        return [self isEmptyString:str];
    }
    
    return YES;
}

+ (BOOL)isEmptyString:(NSString *)string
{
    return [[self trimWhitespace:string] isEqualToString:@""];
}

@end
