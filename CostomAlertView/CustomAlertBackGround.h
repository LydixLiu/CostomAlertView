//
//  CustomAlertBackGround.h
//  CostomAlertView
//
//  Created by Lydix-Liu on 15/6/13.
//  Copyright (c) 2015年 某隻. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertView.h"
#import "CustomActionSheet.h"

@interface CustomAlertBackGround : UIWindow <UIGestureRecognizerDelegate>
{
@private
    NSMutableArray *mArrWaiting;//等待显示的弹出框列表
    
    //ARC模式下防止对象释放使用
    CustomAlertView *showingAlertView;//当前显示的弹出框对象
    CustomActionSheet *showingAction;//当前显示的actionsheet
    
    UIView *showingView;//当前显示弹出框的view
    
    UIWindow *previousKeyWindow;//程序主window
    
    CGFloat currentAlpha;//调整显示的alpha值
    
    UITapGestureRecognizer *tapGesture;
}

/**
 *  单例
 */
+ (CustomAlertBackGround *)shareInstance;

/**
 *  显示弹出框到window,若当前已有弹出框显示,将进入等待
 */
- (void)show:(id)obj;

/**
 *  移除显示弹出框
 */
- (void)dismiss:(id)obj;

@end
