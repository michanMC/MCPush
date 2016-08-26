//
//  ViewController.m
//  MCPush
//
//  Created by MC on 16/8/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "ViewController.h"
#import "View2Controller.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    View2Controller *vc1 = [[View2Controller alloc] init];
    //    vc1.tabBarItem.badgeValue = @"23";
    vc1.title = @"首页";
    vc1.tabBarItem.image = [UIImage imageNamed:@"home_normal"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"home_pre"];
    vc1.tabBarItem.tag = 90000;
    UINavigationController *navC1 = [[UINavigationController alloc] initWithRootViewController:vc1];

    
    [navC1.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor darkTextColor], NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"CourierNewPSMT" size:20.0], NSFontAttributeName,
                                                                     nil]];
    navC1.navigationBar.barTintColor =    [UIColor redColor];
    navC1.navigationBar.tintColor = [UIColor grayColor];//RGBCOLOR(127, 125, 147);
    navC1.navigationBar.barStyle = UIBarStyleDefault;

    
    
    UITabBarController *tabBarC    = [[UITabBarController alloc] init];

    tabBarC.viewControllers        = @[navC1];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    appDelegate.window.rootViewController = tabBarC;

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
