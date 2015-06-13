//
//  ColorHelper.h
//  AnyfishApp
//
//  颜色帮助类
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Anyfish. All rights reserved.
//

#define DEFAULT_VOID_COLOR [UIColor whiteColor]

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorHelper : NSObject

/** 根据十六进制字符串得到默认颜色以及高亮颜色,一般用于按钮
 @param 十六进制字符串 eg: '#FFFFFF'
 @return 颜色数组，第一个为默认颜色
 */
+ (NSArray *)colorsWithARGBString:(NSString *) stringToConvert;

/** 根据十六进制字符串得到颜色
 @param 十六进制字符串 eg: '#FFFFFF'
 @return UIColor
 */
+ (UIColor *)colorWithARGBString:(NSString *) stringToConvert;
+ (UIColor *)colorWithARGBString:(NSString *) stringToConvert alpha:(CGFloat)alpha;

+ (BOOL)isNilOrEmpty:(NSString *)str;

@end
