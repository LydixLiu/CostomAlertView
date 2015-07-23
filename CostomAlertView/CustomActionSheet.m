//
//  CustomActionSheet.m
//  CostomAlertView
//
//  Created by Lydix-Liu on 15/6/17.
//  Copyright (c) 2015年 某隻. All rights reserved.
//

#import "CustomActionSheet.h"
#import "CustomActionSheetButton.h"
#import "CustomAlertBackGround.h"
#import "costomAlertView-Swift.h"

@implementation CustomActionSheet

+ (CustomActionSheet *)actionSheetWithTitle:(NSString *)title message:(NSString *)message {
    return [[CustomActionSheet alloc] initWithTitle:title message:message];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message
{
    hasTitle = NO;
    if ((self = [super init]))
    {
        UIWindow *parentView = [CustomAlertBackGround shareInstance];
        CGRect frame = parentView.bounds;
        
        _view = [[UIView alloc] initWithFrame:frame];
        mArrBlocks = [[NSMutableArray alloc] init];
        height = kActionSheetTopMargin;
        
        if (title || message)
        {
            hasTitle = YES;
            
            CustomActionSheetTitleView *titleView = nil;
            if (title && message) {
                titleView = [CustomActionSheetTitleView viewWithTitle:[NSString stringWithFormat:@"%@\n%@",title,message]];
            }
            else if (title)
            {
                titleView = [CustomActionSheetTitleView viewWithTitle:title];
            }
            else
            {
                titleView = [CustomActionSheetTitleView viewWithTitle:message];
            }
            
            titleView.backgroundColor = [UIColor whiteColor];
            [_view addSubview:titleView];
            height += titleView.frame.size.height + kActionSheetBorder;
        }
    }
    
    return self;
}

#pragma mark - 添加按钮
- (void)addButtonWithTitle:(NSString *)title block:(Block)block {
    NSArray *btnArr = @[title,kActionSheetBtnTitleColorNormal,block?[block copy]:[NSNull null]];
    if (hasCancelOrDst) {
        [mArrBlocks insertObject:btnArr atIndex:mArrBlocks.count-2];
    } else {
        [mArrBlocks addObject:btnArr];
    }
}

- (void)setCancelButtonWithTitle:(NSString *)title block:(Block)block {
    NSArray *btnArr = @[title,kActionSheetBtnTitleColorNormal,block?[block copy]:[NSNull null]];
    [mArrBlocks addObject:btnArr];
    hasCancelOrDst = YES;
}

- (void)setDestructiveButtonWithTitle:(NSString *)title block:(Block)block {
    NSArray *btnArr = @[title,kActionSheetBtnTitleColorDestiv,block?[block copy]:[NSNull null]];
    [mArrBlocks addObject:btnArr];
    hasCancelOrDst = YES;
}

#pragma mark - 显示
- (void)show {
    NSUInteger i = 1;
    height -= 15.0;
    for (int j = 0;j < mArrBlocks.count;j ++)
    {
        NSArray *block = [mArrBlocks objectAtIndex:j];
        NSString *title = [block objectAtIndex:0];
        NSString *color = [block objectAtIndex:1];
        
        CustomActionSheetButton *button = [[CustomActionSheetButton alloc] init];
        if (mArrBlocks.count > 2) {
            if (!hasTitle && j == 0) {
                button = [[CustomActionSheetButton alloc] initWithTopCornersRounded];
                hasTitle = NO;
            }
            else if(j == mArrBlocks.count - 2)
            {
                button = [[CustomActionSheetButton alloc] initWithBottomCornersRounded];
            }
            else if(j == mArrBlocks.count - 1)
            {
                button = [[CustomActionSheetButton alloc] initWithAllCornersRounded];
            }
        }
        else
        {
            if (hasTitle)
            {
                button = [[CustomActionSheetButton alloc] initWithBottomCornersRounded];
                hasTitle = NO;
            }
            else
            {
                button = [[CustomActionSheetButton alloc] initWithAllCornersRounded];
            }
        }
        
        [button setTitle:title forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(button.frame.origin.x, height, button.frame.size.width, button.frame.size.height);
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [button setBackgroundImage:[self imageWithColor:@"#E5E5E5" frame:self.view.bounds] forState:UIControlStateHighlighted];
        button.tag = i++;
        
        if ([color isEqualToString:@"red"])
        {
            [button setTitleColor:[ColorHelper colorWithARGBString:@"#ff0028"] forState:UIControlStateNormal];
        }
        else
        {
            [button setTitleColor:[ColorHelper colorWithARGBString:@"#007aff"] forState:UIControlStateNormal];
        }
        
        [_view addSubview:button];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (j == mArrBlocks.count - 2 || j == block.count - 1)
        {
            height += button.frame.size.height + 10;
        }
        else
        {
            height += button.frame.size.height + kActionSheetBorder;
        }
    }
    
    UIImageView *modalBackground = [[UIImageView alloc] initWithFrame:_view.bounds];
    modalBackground.image = nil;
    modalBackground.contentMode = UIViewContentModeScaleToFill;
    [_view insertSubview:modalBackground atIndex:0];
    
    
    CGRect frame = _view.frame;
    frame.origin.y = [CustomAlertBackGround shareInstance].bounds.size.height;
    frame.size.height = height;
    _view.frame = frame;
    [[CustomAlertBackGround shareInstance] show:self];
//    [[CustomAlertBG shareInstance] show:self];
}

- (UIImage *)imageWithColor:(NSString *)colorString frame:(CGRect)frame {
    UIColor *bgColor = [ColorHelper colorWithARGBString:colorString];
    
    CGRect rect = frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [bgColor set];
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 点击事件处理
- (void)buttonClicked:(UIButton *)sener {
    id block = [[mArrBlocks objectAtIndex:sener.tag - 1] objectAtIndex:2];
    if (block != [NSNull null]) {
        ((Block)block)([NSMutableDictionary dictionary]);
    }
    [[CustomAlertBackGround shareInstance] dismiss:self];
//    [[CustomAlertBG shareInstance] dismiss:self];
}

@end
