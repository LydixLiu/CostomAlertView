//
//  Header.h
//  CostomAlertView
//
//  Created by Lydix-Liu on 15/6/13.
//  Copyright (c) 2015年 某隻. All rights reserved.
//

#ifndef CostomAlertView_Header_h
#define CostomAlertView_Header_h

//弹出框size相关
#define SCREEN_WIDTH            ([UIScreen mainScreen].bounds.size.width)
#define kAlertViewBorder        25
#define kAlertViewWidth         (320-2*kAlertViewBorder)
#define kAlertViewBackgroundCapHeight   100
#define kAlertViewTextFieldHeight   29

#define kAlertViewBgImgFrame    CGRectMake(0, 0, 270, 100)
#define kAlertButtonHeight      40

#define kAlertViewDefaultBtnTitle   @"确定"

//弹出框相关字体
#define kAlertViewTitleFont         [UIFont boldSystemFontOfSize:13]
#define kAlertViewMesssageTxtFont   [UIFont systemFontOfSize:12]
#define kAlertViewOtherFont         [UIFont systemFontOfSize:11]

//弹出框相关字体色
#define kAlertViewTitleTextColor        [ColorHelper colorWithARGBString:@"#2a2a2a"]
#define kAlertViewMessageTextColor      [ColorHelper colorWithARGBString:@"#808080"]
#define kAlertViewOtherTextColor        [ColorHelper colorWithARGBString:@"#d8d9db"]

//弹出框button色值
#define kAlertViewButtonColorBlue       [ColorHelper colorWithARGBString:@"#1c93e5"]
#define kAlertViewButtonColorGray       [ColorHelper colorWithARGBString:@"#94979a"]
#define kAlertViewButtonColorRed        [ColorHelper colorWithARGBString:@"#ff0028"]

#if __IPHONE_6_0 // iOS6 and later

#   define kTextAlignmentCenter    NSTextAlignmentCenter
#   define kTextAlignmentLeft      NSTextAlignmentLeft
#   define kTextAlignmentRight     NSTextAlignmentRight

#   define kTextLineBreakByWordWrapping      NSLineBreakByWordWrapping
#   define kTextLineBreakByCharWrapping      NSLineBreakByCharWrapping
#   define kTextLineBreakByClipping          NSLineBreakByClipping
#   define kTextLineBreakByTruncatingHead    NSLineBreakByTruncatingHead
#   define kTextLineBreakByTruncatingTail    NSLineBreakByTruncatingTail
#   define kTextLineBreakByTruncatingMiddle  NSLineBreakByTruncatingMiddle

#else // older versions

#   define kTextAlignmentCenter    UITextAlignmentCenter
#   define kTextAlignmentLeft      UITextAlignmentLeft
#   define kTextAlignmentRight     UITextAlignmentRight

#   define kTextLineBreakByWordWrapping       UILineBreakModeWordWrap
#   define kTextLineBreakByCharWrapping       UILineBreakModeCharacterWrap
#   define kTextLineBreakByClipping           UILineBreakModeClip
#   define kTextLineBreakByTruncatingHead     UILineBreakModeHeadTruncation
#   define kTextLineBreakByTruncatingTail     UILineBreakModeTailTruncation
#   define kTextLineBreakByTruncatingMiddle   UILineBreakModeMiddleTruncation

#endif


//判断是否 Retina屏、设备是否iPhone 5、iPhone4、是否是iPad
#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isRetina !iPhone4


//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

#endif
