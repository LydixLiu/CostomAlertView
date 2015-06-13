//
//  CustomAlertView.m
//  CostomAlertView
//
//  Created by Lydix-Liu on 15/6/13.
//  Copyright (c) 2015年 某隻. All rights reserved.
//

#import "CustomAlertView.h"
#import "ColorHelper.h"
#import "Header.h"
#import "CustomAlertBackGround.h"

@implementation CustomAlertView

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    UIWindow *parentView = [CustomAlertBackGround shareInstance];
    CGRect frame = parentView.bounds;
    frame.origin.x = 25;
    frame.size.width = kAlertViewWidth;
    
    bgImage = [self imageWithColor:@"#ffffff" frame:kAlertViewBgImgFrame];
    bgImage = [bgImage stretchableImageWithLeftCapWidth:0 topCapHeight:kAlertViewBackgroundCapHeight];
    
    _view = [[UIView alloc] initWithFrame:frame];
    mArrBlocks = [[NSMutableArray alloc] init];
    _view.layer.cornerRadius = 8;
    _view.layer.masksToBounds = YES;
    
    mDic = [NSMutableDictionary dictionary];
    
    height = 0;
}

#pragma mark - class methods
+ (CustomAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message {
    return [[self alloc] initAlertWithTitle:title message:message];
}

+ (CustomAlertView *)promptAlertWithTitle:(NSString *)title {
    return [[self alloc] initPromptAlert:title];
}

#pragma mark - init methods
- (id)initAlertWithTitle:(NSString *)title message:(NSString *)message {
    if ([self init]) {
        height = kAlertViewBorder;
        if (![ColorHelper isNilOrEmpty:title])
        {
            CGSize size = [title sizeWithFont:kAlertViewTitleFont
                            constrainedToSize:CGSizeMake(kAlertViewWidth-kAlertViewBorder*2, 1000)
                                lineBreakMode:NSLineBreakByWordWrapping];
            
            UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(kAlertViewBorder, height, kAlertViewWidth-kAlertViewBorder*2, size.height)];
            labelView.font = kAlertViewTitleFont;
            labelView.numberOfLines = 0;
            labelView.lineBreakMode = NSLineBreakByWordWrapping;
            labelView.textColor = kAlertViewTitleTextColor;
            labelView.backgroundColor = [UIColor clearColor];
            labelView.textAlignment = kTextAlignmentCenter;
            labelView.text = title;
            [_view addSubview:labelView];
            
            height += size.height + kAlertViewBorder;
        }
        
        if (![ColorHelper isNilOrEmpty:message])
        {
            CGSize size = [message sizeWithFont:kAlertViewMesssageTxtFont
                              constrainedToSize:CGSizeMake(kAlertViewWidth-kAlertViewBorder*2, 1000)
                                  lineBreakMode:NSLineBreakByWordWrapping];
            
            UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(kAlertViewBorder, height, kAlertViewWidth-kAlertViewBorder*2, size.height)];
            labelView.font = kAlertViewMesssageTxtFont;
            labelView.numberOfLines = 0;
            labelView.lineBreakMode = NSLineBreakByWordWrapping;
            if ([ColorHelper isNilOrEmpty:title])
            {
                labelView.textColor = kAlertViewTitleTextColor;
            }
            else
            {
                labelView.textColor = kAlertViewMessageTextColor;
            }
            
            labelView.backgroundColor = [UIColor clearColor];
            labelView.textAlignment = kTextAlignmentCenter;
            labelView.text = message;
            [_view addSubview:labelView];
            
            height += size.height + kAlertViewBorder;
        }
    }
    return self;
}

- (id)initPromptAlert:(NSString *)title {
    if ([self init]) {
        height = kAlertViewBorder;
        
        CGSize size = [title sizeWithFont:kAlertViewTitleFont
                        constrainedToSize:CGSizeMake(kAlertViewWidth-kAlertViewBorder*2, 1000)
                            lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(kAlertViewBorder, height, kAlertViewWidth-kAlertViewBorder*2, size.height)];
        labelView.font = kAlertViewTitleFont;
        labelView.numberOfLines = 0;
        labelView.lineBreakMode = NSLineBreakByWordWrapping;
        labelView.textColor = kAlertViewTitleTextColor;
        labelView.backgroundColor = [UIColor clearColor];
        labelView.textAlignment = kTextAlignmentCenter;
        labelView.text = title;
        [_view addSubview:labelView];
        
        height += size.height + kAlertViewBorder;
        
        UITextField *textFiled = [[UITextField alloc] initWithFrame:CGRectMake(kAlertViewBorder, height, kAlertViewWidth-2*kAlertViewBorder, kAlertViewTextFieldHeight)];
        textFiled.backgroundColor = [UIColor clearColor];
        textFiled.layer.cornerRadius = 3;
        textFiled.layer.borderWidth = .5;
        textFiled.layer.borderColor = [kAlertViewOtherTextColor CGColor];
        textFiled.layer.masksToBounds = YES;
        textFiled.font = kAlertViewTitleFont;
        textFiled.delegate = self;
        textFiled.textAlignment = kTextAlignmentCenter;
        textFiled.placeholder = @"点击输入";
        [_view addSubview:textFiled];
        
        height += kAlertViewTextFieldHeight + kAlertViewBorder;
    }
    return self;
}

- (void)show {
    for (NSUInteger i = 0; i < mArrBlocks.count; i++)
    {
        NSArray *block = [mArrBlocks objectAtIndex:i];
        NSString *title = [block objectAtIndex:0];
        UIImage *image = [self imageWithColor:@"#ffffff" frame:CGRectMake(0, 0, _view.frame.size.width/2, 50)];
        UIImage *highLighImg = [self imageWithColor:@"#1fa4ff" frame:CGRectMake(0, 0, _view.frame.size.width/2, 50)];
        
        CGFloat width = mArrBlocks.count > 1 ? (_view.bounds.size.width/2 + 2) : (_view.bounds.size.width + 2);
        CGFloat xOffset = (i % 2) * _view.bounds.size.width / 2 - 1;
        
        if (mArrBlocks.count > 2) {
            width = _view.bounds.size.width+2;
            xOffset = -1;
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(xOffset, height, width, kAlertButtonHeight);
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.textAlignment = kTextAlignmentCenter;
        button.backgroundColor = [UIColor clearColor];
        button.tag = i+1;
        
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:highLighImg forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setTitle:title forState:UIControlStateNormal];
        button.accessibilityLabel = title;
        button.layer.borderColor = [ColorHelper colorWithARGBString:@"#d8d9db"].CGColor;
        button.layer.borderWidth = .5f;
        
        [_view addSubview:button];
        
        [button addTarget:self action:@selector(dismissWithButton:) forControlEvents:UIControlEventTouchUpInside];
        
        if (mArrBlocks.count != 2 || (mArrBlocks.count == 2 && i == 1)) {
            height += kAlertButtonHeight - 1;
        }
    }
    
    if (height < bgImage.size.height)
    {
        CGFloat offset = bgImage.size.height - height;
        height = bgImage.size.height;
        CGRect frame;
        for (NSUInteger i = 0; i < mArrBlocks.count; i++)
        {
            UIButton *btn = (UIButton *)[_view viewWithTag:i+1];
            frame = btn.frame;
            frame.origin.y += offset;
            btn.frame = frame;
        }
    }
    
    CGRect frame = _view.frame;
    frame.origin.y = - height;
    frame.size.height = height;
    _view.frame = frame;
    
    if(!bgImage) {
        bgImage = [self imageWithColor:@"#ffffff" frame:kAlertViewBgImgFrame];
    }
    UIImageView *modalBackground = [[UIImageView alloc] initWithFrame:_view.bounds];
    modalBackground.image = bgImage;
    modalBackground.backgroundColor = [UIColor greenColor];
    modalBackground.contentMode = UIViewContentModeScaleToFill;
    [_view insertSubview:modalBackground atIndex:0];
    
    UITapGestureRecognizer *tap1 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    tap1.delegate = self;
    [_view addGestureRecognizer:tap1];
    
    [[CustomAlertBackGround shareInstance] showAlertView:self];
}

#pragma mark - 手势处理
- (void)handleGestureEvent:(UITapGestureRecognizer *)gesture {
    [self hideKeyBoard];
    
    if (self.tapToDismiss) {//点击消失
        [[CustomAlertBackGround shareInstance] dismissAlertView:self];
    }
}

#pragma mark - 键盘处理
- (void)showKeyboard
{
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    __block CGRect frame = _view.frame;
    
    float a;
    
    CGFloat kbHeight = 254.f;
    
    if (iPhone6)
        kbHeight = 264.f;
    if (iPhone6p)
        kbHeight = 304.f;
    
    if (frame.origin.y+frame.size.height > screenHeight - kbHeight) {
        
        a =frame.origin.y+frame.size.height-(screenHeight - kbHeight);
        
        frame.origin.y =  frame.origin.y - a ;
        if (IOS_VERSION < 7) {
            frame.origin.y = frame.origin.y - 19;
        }
        if ((iPhone4s || iPhone4) && frame.origin.y < -25) {
            frame.origin.y = -25;
        }
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             _view.frame = frame;
                         }
                         completion:^(BOOL finished){
                             self.isKeyboardShowing = YES;
                         }];
    }
}

- (void)hideKeyBoard
{
    if (!self.isKeyboardShowing)
    {
        return;
    }
    
    for (UIView *subV in self.view.subviews) {
        if ([subV isKindOfClass:[UITextField class]]) {
            if (((UITextField *)subV).isFirstResponder) {
                [((UITextField *)subV) resignFirstResponder];
                break;
            }
        } else if ([subV isKindOfClass:[UITextView class]]) {
            if (((UITextView *)subV).isFirstResponder) {
                [((UITextView *)subV) resignFirstResponder];
                break;
            }
        } else {
            for (UIView *sv in subV.subviews) {
                if ([sv isKindOfClass:[UITextField class]]) {
                    if (((UITextField *)sv).isFirstResponder) {
                        [((UITextField *)sv) resignFirstResponder];
                        break;
                    }
                } else if ([sv isKindOfClass:[UITextView class]]) {
                    if (((UITextView *)sv).isFirstResponder) {
                        [((UITextView *)sv) resignFirstResponder];
                        break;
                    }
                }
            }
        }
    }
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         _view.center = [CustomAlertBackGround shareInstance].center;
                     }
                     completion:^(BOOL finished){
                         self.isKeyboardShowing = NO;
                     }];
}

#pragma mark - button点击处理
- (void)dismissWithButton:(UIButton *)button {
    [self hideKeyBoard];//先将键盘收起
    
    NSInteger buttonIndex = button.tag - 1;
    if (buttonIndex < mArrBlocks.count) {
        [mDic setValue:[NSNumber numberWithInteger:buttonIndex] forKey:@"clickedButtonIndex"];
        id block = [[mArrBlocks objectAtIndex:buttonIndex] objectAtIndex:1];
        if (block != [NSNull null]) {
            ((Block)block)(mDic);
        }
    }
    [[CustomAlertBackGround shareInstance] dismissAlertView:self];
}

#pragma mark - 为alert添加按钮
- (void)addButtonWithTitle:(NSString *)title block:(Block)block {
    if (!mArrBlocks) {
        mArrBlocks = [NSMutableArray array];
    }
    NSArray *array = [NSArray arrayWithObjects:title?title:kAlertViewDefaultBtnTitle,block?[block copy]:[NSNull null], nil];
    [mArrBlocks addObject:array];
}

#pragma mark - textFiled & textView delegates
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self showKeyboard];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [mDic setValue:textField.text forKey:@"input"];
    [self hideKeyBoard];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self showKeyboard];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [mDic setValue:textView.text forKey:@"input"];
    [self hideKeyBoard];
    return YES;
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

@end
