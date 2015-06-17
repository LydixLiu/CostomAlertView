//
//  CustomActionSheet.h
//  CostomAlertView
//
//  Created by Lydix-Liu on 15/6/17.
//  Copyright (c) 2015年 某隻. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ColorHelper.h"
#import "Header.h"

@interface CustomActionSheet : NSObject
{
    CGFloat height;//计算高度
    NSMutableArray *mArrBlocks;//创建按钮所需@[title,color,block]
    BOOL hasCancelOrDst;//是否有取消或明显提示按钮,用于分段
    BOOL hasTitle;//是否有标题或说明文字
}

@property (nonatomic, retain) UIView *view;

/**
 *  带标题和说明文字的actionsheet
 */
+ (CustomActionSheet *)actionSheetWithTitle:(NSString *)title
                                    message:(NSString *)message;

/**
 *  添加普通按钮
 */
- (void)addButtonWithTitle:(NSString *)title block:(Block)block;

/**
 *  设置取消按钮
 */
- (void)setCancelButtonWithTitle:(NSString *)title block:(Block)block;

/**
 *  设置明显提示按钮
 */
- (void)setDestructiveButtonWithTitle:(NSString *)title block:(Block)block;

/**
 *  显示方法
 */
- (void)show;

@end
