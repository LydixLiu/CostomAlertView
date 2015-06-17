//
//  CustomAlertBackGround.m
//  CostomAlertView
//
//  Created by Lydix-Liu on 15/6/13.
//  Copyright (c) 2015年 某隻. All rights reserved.
//

#import "CustomAlertBackGround.h"
#import "ColorHelper.h"

@implementation CustomAlertBackGround

static CustomAlertBackGround *alertBg = nil;

+ (CustomAlertBackGround *)shareInstance {
    if (!alertBg) {
        alertBg = [[self alloc] init];
    }
    return alertBg;
}

- (instancetype)init {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.windowLevel = UIWindowLevelAlert;
        self.hidden = YES;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [ColorHelper colorWithARGBString:@"#000000" alpha:.5];
    }
    return self;
}

#pragma mark - 显示
- (void)show:(id)obj {
    
    if (showingView) {
        if (!mArrWaiting) {
            mArrWaiting = [NSMutableArray array];
        }
        [mArrWaiting addObject:obj];
    } else {
        //首先判断类型
        if ([obj isKindOfClass:[CustomActionSheet class]]) {
            showingAction = obj;
            showingView = showingAction.view;
        } else if ([obj isKindOfClass:[CustomAlertView class]]) {
            showingAlertView = obj;
            showingView = showingAlertView.view;
        }
        
        for (UIView *view in self.subviews) {//清空subviews
            [view removeFromSuperview];
        }
        
        //添加view
        [self addSubview:showingView];
        self.userInteractionEnabled = YES;
        
        //window操作
        if (!previousKeyWindow) {
            previousKeyWindow = [UIApplication sharedApplication].keyWindow;
        }
        previousKeyWindow.userInteractionEnabled = NO;
        
        //添加手势
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureEvent:)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
        
        //显示动画
        self.alpha = currentAlpha;
        if (showingAlertView) {
            showingView.alpha = 0;
            showingView.center = self.center;
            [UIView animateWithDuration:.2 animations:^{
                showingView.alpha = 1.f;
                self.alpha = 1.f;
            }];
        } else if (showingAction) {
            CGRect frame = showingView.frame;
            frame.origin.y = SCREEN_HEIGHT - frame.size.height - 5;
            showingView.alpha = 1.f;
            self.alpha = 1.f;
            
            [UIView animateWithDuration:.2 animations:^{
                showingView.frame = frame;
            }];
        }
        
    }
    [self makeKeyAndVisible];
}

#pragma mark - 移除
- (void)dismiss:(id)obj {
    
    [UIView animateWithDuration:.2
                     animations:^{
                         if ([obj isKindOfClass:[CustomAlertView class]]) {
                             showingView.alpha = 0;
                         } else if ([obj isKindOfClass:[CustomActionSheet class]]) {
                             CGRect frame = showingView.frame;
                             frame.origin.y = SCREEN_HEIGHT;
                             showingView.frame = frame;
                         }
                         self.alpha = mArrWaiting.count;
                     }
                     completion:^(BOOL finished) {
                         [showingView removeFromSuperview];
                         showingAlertView = nil;
                         showingAction = nil;
                         showingView = nil;
                         if (mArrWaiting.count > 0) {
                             currentAlpha = 1;
                             [self show:mArrWaiting.lastObject];
                             [mArrWaiting removeLastObject];
                         } else {
                             [self reduceAlphaIfEmpty];
                             previousKeyWindow.userInteractionEnabled = YES;
                             [previousKeyWindow makeKeyAndVisible];
                         }
                     }];
}

#pragma mark - 手势
- (void)handleGestureEvent:(UITapGestureRecognizer *)gesture {
    if (showingAlertView) {
        if (showingAlertView.tapToDismiss)
            [self dismiss:showingAlertView];
            else
            [showingAlertView hideKeyBoard];
    } else if (showingAction) {
        [self dismiss:showingAction];
    }
}

#pragma mark - 清理
- (void)reduceAlphaIfEmpty {
    if (self.subviews.count == 0)
    {
        [UIView animateWithDuration:.1 animations:^{
            self.alpha = 0.0f;
            self.userInteractionEnabled = NO;
        }];
        currentAlpha = 0;
        [self cleanSelf];
    }
}

- (void)cleanSelf {
    if (mArrWaiting) {
        [mArrWaiting removeAllObjects];
        mArrWaiting = nil;
    }
    
    showingAlertView = nil;
}

@end
