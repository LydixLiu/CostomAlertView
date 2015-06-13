//
//  CustomAlertView.h
//  CostomAlertView
//
//  Created by Lydix-Liu on 15/6/13.
//  Copyright (c) 2015年 某隻. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^Block) (NSMutableDictionary *dataDic);

@interface CustomAlertView : NSObject <UITextFieldDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
{
@protected
    CGFloat height;//弹出框view高度计算
    UIImage *bgImage;//弹出框背景
    NSMutableArray *mArrBlocks;//弹出框按钮点击回调block
    NSMutableDictionary *mDic;//回调block返回数据
}

/** 弹出框显示view */
@property (nonatomic, retain) UIView *view;

/** 是否点击消失 */
@property (nonatomic, assign) BOOL tapToDismiss;

/** 当前键盘显示状态 */
@property (nonatomic, assign) BOOL isKeyboardShowing;

+ (CustomAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message;

+ (CustomAlertView *)promptAlertWithTitle:(NSString *)title;

/**
 *  添加按钮
 */
- (void)addButtonWithTitle:(NSString *)title block:(Block)block;

/**
 *  隐藏键盘，手势处理
 */
- (void)hideKeyBoard;

/** 弹出框显示方法 */
- (void)show;

@end
