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

- (void)showAlertView:(CustomAlertView *)alert {
    if (showingAlertView) {//判断当前是否正在显示
        if (!mArrWaiting) {
            mArrWaiting = [NSMutableArray array];
        }
        [mArrWaiting addObject:alert];
    } else {
        for (UIView *view in self.subviews) {//清空之前残留view
            [view removeFromSuperview];
        }
        showingView = alert.view;
        
        showingAlertView = alert;
        showingView.alpha = 0;
        self.alpha = currentAlpha;
        self.userInteractionEnabled = YES;
        [self addSubview:showingView];
        showingView.userInteractionEnabled = YES;
        
        if (!previousKeyWindow) {
            previousKeyWindow = [UIApplication sharedApplication].keyWindow;
        }
        previousKeyWindow.userInteractionEnabled = NO;
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureEvent:)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
        showingView.center = self.center;
        [UIView animateWithDuration:.2 animations:^{
            showingView.alpha = 1.f;
            self.alpha = 1.f;
        }];
    }
    [self makeKeyAndVisible];
    self.userInteractionEnabled = YES;
}

- (void)dismissAlertView:(CustomAlertView *)alert {
    
    [UIView animateWithDuration:.2
                     animations:^{
                         showingView.alpha = 0;
                         self.alpha = mArrWaiting.count;
                     }
                     completion:^(BOOL finished) {
                         [showingView removeFromSuperview];
                         showingAlertView = nil;
                         showingView = nil;
                         if (mArrWaiting.count > 0) {
                             currentAlpha = 1;
                             [self showAlertView:mArrWaiting.lastObject];
                             [mArrWaiting removeLastObject];
                         } else {
                             [self reduceAlphaIfEmpty];
                             previousKeyWindow.userInteractionEnabled = YES;
                             [previousKeyWindow makeKeyAndVisible];
                         }
                     }];
}

- (void)handleGestureEvent:(UITapGestureRecognizer *)gesture {
    if (showingAlertView) {
        if (showingAlertView.tapToDismiss)
            [self dismissAlertView:showingAlertView];
            else
            [showingAlertView hideKeyBoard];
    }
}

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
