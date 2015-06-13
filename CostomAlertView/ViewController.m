//
//  ViewController.m
//  CostomAlertView
//
//  Created by Lydix-Liu on 15/6/13.
//  Copyright (c) 2015年 某隻. All rights reserved.
//

#import "ViewController.h"
#import "CustomAlertView.h"
#import "ColorHelper.h"
#import "Header.h"

@interface ViewController ()
{
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"弹窗测试"];
    self.view.backgroundColor = [ColorHelper colorWithARGBString:@"#f0f4f7"];
    [self setup];
}

- (void)setup {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 29)];
    button.backgroundColor = kAlertViewButtonColorBlue;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [button setTitle:@"click me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    button.center = self.view.center;
    [self.view addSubview:button];
}

- (void)showAlert {
    CustomAlertView *alert = [CustomAlertView promptAlertWithTitle:@"请输入值"];
    [alert addButtonWithTitle:@"确定" block:^(NSMutableDictionary *dataDic) {
        CustomAlertView *alertInner = [CustomAlertView alertWithTitle:[NSString stringWithFormat:@"输入值:%@",[dataDic valueForKey:@"input"]] message:nil];
        [alertInner addButtonWithTitle:@"确定" block:^(NSMutableDictionary *dataDic) {
            
        }];
        [alertInner addButtonWithTitle:@"取消" block:nil];
        [alertInner show];
    }];
    [alert addButtonWithTitle:@"取消" block:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
