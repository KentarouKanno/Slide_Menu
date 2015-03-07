//
//  MenuViewController.m
//  SlideMenu
//
//  Created by KentarOu on 2015/03/07.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

#import "MenuBaseVC.h"
#import "NextViewController.h"
#import "RightMenuView.h"
#import "LeftMenuView.h"
#import "AppDelegate.h"

#import "RightMenuVC_1.h"
#import "RightMenuVC_2.h"
#import "RightMenuVC_3.h"

#import "LeftMenuVC_1.h"
#import "LeftMenuVC_2.h"
#import "LeftMenuVC_3.h"


@interface MenuBaseVC ()
{
    RightMenuView *rightMenuView;
    LeftMenuView *leftMenuView;
    
    BOOL showRightMenu;
    BOOL showLeftMenu;
    
    SelectView select;
    AppDelegate *appDelegate;
    
    // Right View
    RightMenuVC_1 *rightMenuView1;
    RightMenuVC_2 *rightMenuView2;
    RightMenuVC_3 *rightMenuView3;
    
    // Left View
    LeftMenuVC_1 *leftMenuView1;
    LeftMenuVC_2 *leftMenuView2;
    LeftMenuVC_3 *leftMenuView3;
}

@end

@implementation MenuBaseVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    showRightMenu = NO;
    showLeftMenu = NO;
    
    
    
    // ナビ右ボタン
    UIButton *rightMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    rightMenu.frame = CGRectMake(0, 0, 50, 30);
    [rightMenu addTarget:self action:@selector(rightMenu:) forControlEvents:UIControlEventTouchUpInside];
    [rightMenu setTitleColor:[UIColor colorWithRed:0.137 green:0.294 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [rightMenu setTitle:@"Menu" forState:UIControlStateNormal];
    rightMenu.adjustsImageWhenHighlighted = YES;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(70, 0, 40, 30);
    [nextButton addTarget:self action:@selector(nextView:) forControlEvents:UIControlEventTouchUpInside];
    [nextButton setTitleColor:[UIColor colorWithRed:0.320 green:0.561 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    
    UIView *rightBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(nextButton.frame), 30)];
    
    [rightBaseView addSubview:rightMenu];
    [rightBaseView addSubview:nextButton];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBaseView];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    // ナビ左ボタン
    UIButton *leftMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    leftMenu.frame = CGRectMake(70, 0, 50, 30);
    [leftMenu addTarget:self action:@selector(leftMenu:) forControlEvents:UIControlEventTouchUpInside];
    [leftMenu setTitleColor:[UIColor colorWithRed:0.137 green:0.294 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [leftMenu setTitle:@"Menu" forState:UIControlStateNormal];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 50, 30);
    [backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitleColor:[UIColor colorWithRed:0.137 green:0.294 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    
    UIView *leftBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(leftMenu.frame), 30)];
    [leftBaseView addSubview:leftMenu];
    [leftBaseView addSubview:backButton];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBaseView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

// 右ボタン処理
- (void)rightMenu:(UIButton*)sender {
    
    if (sender) {
        select = MenuClose;
    }
    
    if (!showRightMenu) {
        
        rightMenuView = [RightMenuView loadFromNib];
        rightMenuView.delegate = self;
        rightMenuView.frame = CGRectMake(768, 0, 200, 1024);
    }
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window = [[UIApplication sharedApplication].windows objectAtIndex:[window subviews].count - 1];
    [window addSubview:rightMenuView];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        if (showRightMenu) {
            self.navigationController.view.frame = CGRectMake(0, 0, 768, 1024);
            rightMenuView.frame = CGRectMake(768, 0, 200, 1024);
            
        } else {
            self.navigationController.view.frame = CGRectMake(-200, 0, 768, 1024);
            rightMenuView.frame = CGRectMake(768 - 200, 0, 200, 1024);
            
        }
        
    } completion:^(BOOL finished) {
        
        if (showRightMenu) {
            [rightMenuView removeFromSuperview];
            showRightMenu = NO;
            
            if (select != MenuClose) {
                
                switch (select) {
                    case RightMenu_1:
                    {
                        
                        rightMenuView1 = [self.storyboard instantiateViewControllerWithIdentifier:@"RightMenuVC_1"];
                        appDelegate.nowViewController = rightMenuView1;
                    }
                        break;
                    case RightMenu_2:
                    {
                        
                        rightMenuView2 = [self.storyboard instantiateViewControllerWithIdentifier:@"RightMenuVC_2"];
                        appDelegate.nowViewController = rightMenuView2;
                    }
                        break;
                    case RightMenu_3:
                    {
                        
                        rightMenuView3 = [self.storyboard instantiateViewControllerWithIdentifier:@"RightMenuVC_3"];
                        appDelegate.nowViewController = rightMenuView3;
                    }
                        break;
                        
                    default:
                        break;
                }
                
                [self.navigationController pushViewController:appDelegate.nowViewController animated:NO];
            }
            
        } else {
            
            showRightMenu = YES;
        }
    }];
}

- (void)nextView:(UIButton*)sender {
    
    if (showRightMenu) return;
    if (showLeftMenu) return;
    
    NextViewController *next = [self.storyboard instantiateViewControllerWithIdentifier:@"NextViewController"];
    [self.navigationController pushViewController:next animated:YES];
}

// 左ボタン処理
- (void)leftMenu:(UIButton*)sender {
    
    if (sender) {
        select = MenuClose;
    }
    
    if (!showLeftMenu) {
        
        leftMenuView = [LeftMenuView loadFromNib];
        leftMenuView.delegate = self;
        leftMenuView.frame = CGRectMake(-200, 0, 200, 1024);
    }
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:[window subviews].count - 1];
    [window addSubview:leftMenuView];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        if (showLeftMenu) {
            self.navigationController.view.frame = CGRectMake(0, 0, 768, 1024);
            leftMenuView.frame = CGRectMake(-200, 0, 200, 1024);
            
        } else {
            self.navigationController.view.frame = CGRectMake(200, 0, 768, 1024);
            leftMenuView.frame = CGRectMake(0, 0, 200, 1024);
            
        }
        
    } completion:^(BOOL finished) {
        
        if (showLeftMenu) {
            [leftMenuView removeFromSuperview];
            showLeftMenu = NO;
            
            if (select != MenuClose) {
                
                switch (select) {
                    case LeftMenu_1:
                    {
                        
                        leftMenuView1 = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenuVC_1"];
                        appDelegate.nowViewController = leftMenuView1;
                    }
                        break;
                    case LeftMenu_2:
                    {
                        
                        leftMenuView2 = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenuVC_2"];
                        appDelegate.nowViewController = leftMenuView2;
                    }
                        break;
                    case LeftMenu_3:
                    {
                        
                        leftMenuView3 = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenuVC_3"];
                        appDelegate.nowViewController = leftMenuView3;
                    }
                        break;
                        
                    default:
                        break;
                }
                
                [self.navigationController pushViewController:appDelegate.nowViewController animated:NO];
            }
            
        } else {
            
            showLeftMenu = YES;
        }
    }];
    
}

- (void)backView:(UIButton*)sender {
    
    if (showRightMenu) return;
    if (showLeftMenu) return;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)closeRightMenu:(NSInteger)indexRow {
    
    select = indexRow;
    [self rightMenu:nil];
}

- (void)closeLeftMenu:(NSInteger)indexRow {
    
    select = indexRow + 3;
    [self leftMenu:nil];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
