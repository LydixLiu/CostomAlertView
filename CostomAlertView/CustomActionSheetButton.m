//
//  AFFCActionSheetButton.m
//  AnyfishApp
//
//  Created by Lydix-Liu on 15/6/17.
//  Copyright (c) 2015年 某隻. All rights reserved.
//

#import "CustomActionSheetButton.h"

#pragma mark - AFFCActionSheetButton

@implementation CustomActionSheetButton


- (id)init
{
    
    float width;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        width = CGRectGetWidth([UIScreen mainScreen].bounds);
    } else {
        width = CGRectGetHeight([UIScreen mainScreen].bounds);
    }
    self = [self initWithFrame:CGRectMake(8, 0, width - 16, 45)];
    
    self.backgroundColor = [UIColor clearColor];
    self.originalBackgroundColor = self.backgroundColor;
    self.titleLabel.font = [UIFont systemFontOfSize:21];
    [self setTitleColor:[UIColor colorWithRed:0.000 green:0.500 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    self.originalTextColor = [UIColor colorWithRed:0.000 green:0.500 blue:1.000 alpha:1.000];
    
    self.alpha = 1.0f;
    
    self.cornerType = AFFCActionSheetButtonCornerTypeNoCornersRounded;
    
    return self;
}

- (id)initWithTopCornersRounded
{
    self = [self init];
    [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
    self.cornerType = AFFCActionSheetButtonCornerTypeTopCornersRounded;
    return self;
}

- (id)initWithBottomCornersRounded
{
    self = [self init];
    [self setMaskTo:self byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
    self.cornerType = AFFCActionSheetButtonCornerTypeBottomCornersRounded;
    return self;
}

- (id)initWithAllCornersRounded
{
    self = [self init];
    [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight];
    self.cornerType = AFFCActionSheetButtonCornerTypeAllCornersRounded;
    return self;
}

- (void)setTextColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)resizeForPortraitOrientation
{
    
    self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds) - 16, CGRectGetHeight(self.frame));
    
    switch (self.cornerType) {
        case AFFCActionSheetButtonCornerTypeNoCornersRounded:
            break;
            
        case AFFCActionSheetButtonCornerTypeTopCornersRounded: {
            [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
            break;
        }
        case AFFCActionSheetButtonCornerTypeBottomCornersRounded: {
            [self setMaskTo:self byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
            break;
        }
            
        case AFFCActionSheetButtonCornerTypeAllCornersRounded: {
            [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight];
            break;
        }
            
        default:
            break;
    }
}

- (void)resizeForLandscapeOrientation
{
    self.frame = CGRectMake(0, 0, CGRectGetHeight([UIScreen mainScreen].bounds) - 16, CGRectGetHeight(self.frame));
    
    switch (self.cornerType) {
        case AFFCActionSheetButtonCornerTypeNoCornersRounded:
            break;
            
        case AFFCActionSheetButtonCornerTypeTopCornersRounded: {
            [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
            break;
        }
        case AFFCActionSheetButtonCornerTypeBottomCornersRounded: {
            [self setMaskTo:self byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
            break;
        }
            
        case AFFCActionSheetButtonCornerTypeAllCornersRounded: {
            [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight];
            break;
        }
            
        default:
            break;
    }
    
}

- (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(kButtonCornerRadius, kButtonCornerRadius)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    view.layer.mask = shape;
}

@end



#pragma mark - CustomActionSheetTitleView

@implementation CustomActionSheetTitleView

+ (id)viewWithTitle:(NSString *)title
{
    return [[CustomActionSheetTitleView alloc] initWithTitle:title];
}

- (id)initWithTitle:(NSString *)title
{
    
    self = [self init];
    
    float width;
    float labelBuffer;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        width = CGRectGetWidth([UIScreen mainScreen].bounds);
        labelBuffer = 36;
    } else {
        width = CGRectGetHeight([UIScreen mainScreen].bounds);
        labelBuffer = 24;
    }
    
    self.alpha = 1.0f;
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width - labelBuffer, 44)];
    self.titleLabel.center = self.center;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor colorWithWhite:0.564 alpha:1.000];
    self.titleLabel.textAlignment = kTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = title;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.titleLabel sizeToFit];
    
    
    
    if ((CGRectGetHeight(self.titleLabel.frame) + 36) < 44) {
        self.frame = CGRectMake(8, 0, width - 16, 44);
    } else {
        self.frame = CGRectMake(8, 0, width - 16, CGRectGetHeight(self.titleLabel.frame) + 36);
    }
    
    [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
    [self addSubview:self.titleLabel];
    self.titleLabel.center = CGPointMake(self.center.x-8, self.center.y); //self.center;
    
    return self;
}

- (void)resizeForPortraitOrientation
{
    
    self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds) - 16, CGRectGetHeight(self.frame));
    self.titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds) - 24, 44);
    [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
}

- (void)resizeForLandscapeOrientation
{
    
    self.frame = CGRectMake(0, 0, CGRectGetHeight([UIScreen mainScreen].bounds) - 16, CGRectGetHeight(self.frame));
    self.titleLabel.frame = CGRectMake(0, 0, CGRectGetHeight([UIScreen mainScreen].bounds) - 44, 44);
    [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
}

- (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(kButtonCornerRadius, kButtonCornerRadius)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    view.layer.mask = shape;
}

@end

