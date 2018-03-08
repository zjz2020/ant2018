//
//  StoreTabBarVC.m
//  Dlt
//
//  Created by 张君泽 on 2018/3/8.
//  Copyright © 2018年 mr_chen. All rights reserved.
//

#import "StoreTabBarVC.h"
#import "FirstStoreVC.h"
#import "SecondStoreVC.h"
#import "ThirdStoreVC.h"
@interface StoreTabBarVC ()

@end

@implementation StoreTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableBarAtFirst];
    // Do any additional setup after loading the view.
}
#pragma mark 私有方法
//设置tabbar
- (void)setUpTableBarAtFirst{
    FirstStoreVC *first = [[FirstStoreVC alloc] init];
    [self setupChildViewController:first title:@"first" imageName:@"" selectedImageName:@""];
    
    SecondStoreVC *second = [[SecondStoreVC alloc] init];
    [self setupChildViewController:second title:@"second" imageName:@"" selectedImageName:@""];
    
    ThirdStoreVC *third = [[ThirdStoreVC alloc] init];
    [self setupChildViewController:third title:@"third" imageName:@"" selectedImageName:@""];
}
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedIamge = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = [selectedIamge imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:navVc];
    
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
