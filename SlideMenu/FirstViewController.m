//
//  ViewController.m
//  SlideMenu
//
//  Created by KentarOu on 2015/03/07.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "RightMenuVC_1.h"

@interface FirstViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初回遷移画面設定
    RightMenuVC_1 *menuView1 = [self.storyboard instantiateViewControllerWithIdentifier:@"RightMenuVC_1"];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.nowViewController = menuView1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (IBAction)pushMenuView:(id)sender {
    [self.navigationController pushViewController:appDelegate.nowViewController animated:YES];
}

@end
