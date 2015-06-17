//
//  AFFCActionSheetButton.h
//  AnyfishApp
//
//  Created by Lydix-Liu on 15/6/17.
//  Copyright (c) 2015年 某隻. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

typedef NS_ENUM(NSInteger, CustomActionSheetButtonCornerType) {
    
    AFFCActionSheetButtonCornerTypeNoCornersRounded,
    AFFCActionSheetButtonCornerTypeTopCornersRounded,
    AFFCActionSheetButtonCornerTypeBottomCornersRounded,
    AFFCActionSheetButtonCornerTypeAllCornersRounded
    
};

#pragma mark - CustomActionSheetButton

@interface CustomActionSheetButton : UIButton


- (id)initWithTopCornersRounded;
- (id)initWithAllCornersRounded;
- (id)initWithBottomCornersRounded;
- (void)resizeForPortraitOrientation;
- (void)resizeForLandscapeOrientation;
- (void)setTextColor:(UIColor *)color;

@property NSInteger index;
@property CustomActionSheetButtonCornerType cornerType;
@property(nonatomic,strong) UIColor *originalTextColor, *highlightTextColor;
@property(nonatomic,strong) UIColor *originalBackgroundColor, *highlightBackgroundColor;


@end


#pragma mark - CustomActionSheetTitleView

@interface CustomActionSheetTitleView : UIView

- (void)resizeForPortraitOrientation;
- (void)resizeForLandscapeOrientation;
- (id)initWithTitle:(NSString *)title;
+ (id)viewWithTitle:(NSString *)title;



@property(nonatomic,strong) UILabel *titleLabel;

@end

