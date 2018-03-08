//
//  StoreBaseVC.m
//  Dlt
//
//  Created by 张君泽 on 2018/3/8.
//  Copyright © 2018年 mr_chen. All rights reserved.
//

#import "StoreBaseVC.h"

@interface StoreBaseVC ()

@end

@implementation StoreBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftBtn];
    // Do any additional setup after loading the view.
}
//设置左侧的返回按钮
- (void)addLeftBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(clickeLeftBtnItem) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"redpacker_00"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}
- (void)clickeLeftBtnItem{
    [self.tabBarController.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
