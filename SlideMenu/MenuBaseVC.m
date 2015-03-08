//
//  MenuViewController.m
//  SlideMenu
//
//  Created by KentarOu on 2015/03/07.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

#import "MenuBaseVC.h"
#import "AppDelegate.h"
#import "NextViewController.h"
#import "RightMenuView.h"
#import "LeftMenuView.h"

#import "RightMenuVC_1.h"
#import "RightMenuVC_2.h"
#import "RightMenuVC_3.h"

#import "LeftMenuVC_1.h"
#import "LeftMenuVC_2.h"
#import "LeftMenuVC_3.h"

#define BUTTON_TITLE_COLOR [UIColor colorWithRed:0.059 green:0.380 blue:0.996 alpha:1.000]
#define BUTTON_TITLE_SELECT_COLOR [UIColor colorWithRed:0.059 green:0.380 blue:0.996 alpha:0.300]

#define MENU_WIDTH 200
#define VIEW_HEIGHT 1024
#define VIEW_WIDTH 768

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

#pragma mark- Life Cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    showRightMenu = NO;
    showLeftMenu = NO;
    

    // ナビ右ボタン生成
    UIButton *rightMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    rightMenu.frame = CGRectMake(0, 0, 50, 30);
    [rightMenu addTarget:self action:@selector(rightMenu:) forControlEvents:UIControlEventTouchUpInside];
    [rightMenu setTitleColor:BUTTON_TITLE_COLOR forState:UIControlStateNormal];
    [rightMenu setTitleColor:BUTTON_TITLE_SELECT_COLOR forState:UIControlStateHighlighted];
    [rightMenu setTitle:@"Menu" forState:UIControlStateNormal];
    rightMenu.adjustsImageWhenHighlighted = YES;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(70, 0, 40, 30);
    [nextButton addTarget:self action:@selector(nextView:) forControlEvents:UIControlEventTouchUpInside];
    [nextButton setTitleColor:BUTTON_TITLE_COLOR forState:UIControlStateNormal];
    [nextButton setTitleColor:BUTTON_TITLE_SELECT_COLOR forState:UIControlStateHighlighted];
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    
    UIView *rightBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, CGRectGetMaxX(nextButton.frame), 30)];
    
    [rightBaseView addSubview:rightMenu];
    [rightBaseView addSubview:nextButton];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBaseView];
    self.navigationItem.rightBarButtonItem = rightItem;
    

    // ナビ左ボタン生成
    UIButton *leftMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    leftMenu.frame = CGRectMake(70, 0, 50, 30);
    [leftMenu addTarget:self action:@selector(leftMenu:) forControlEvents:UIControlEventTouchUpInside];
    [leftMenu setTitleColor:BUTTON_TITLE_COLOR forState:UIControlStateNormal];
    [leftMenu setTitleColor:BUTTON_TITLE_SELECT_COLOR forState:UIControlStateHighlighted];
    [leftMenu setTitle:@"Menu" forState:UIControlStateNormal];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 50, 30);
    [backButton addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitleColor:BUTTON_TITLE_COLOR forState:UIControlStateNormal];
    [backButton setTitleColor:BUTTON_TITLE_SELECT_COLOR forState:UIControlStateHighlighted];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    
    UIView *leftBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(leftMenu.frame), 30)];
    [leftBaseView addSubview:leftMenu];
    [leftBaseView addSubview:backButton];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBaseView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 右メニュースワイプ
    UIView *rightSwipeView = [[UIView alloc]initWithFrame:CGRectMake(VIEW_WIDTH - 100, 0, 100, VIEW_HEIGHT)];
    [self.view addSubview:rightSwipeView];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightMenu:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    [rightSwipeView addGestureRecognizer:rightSwipe];
    
    
    // 左メニュースワイプ
    UIView *leftSwipeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, VIEW_HEIGHT)];
    [self.view addSubview:leftSwipeView];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftMenu:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
    [leftSwipeView addGestureRecognizer:leftSwipe];
    
}

#pragma mark- Button Action

// 「右Menu」ボタン押下処理
- (void)rightMenu:(id)sender {
    
    if (sender) {
        select = MenuClose;
    }
    
    if (!showRightMenu) {
        
        //メニュー画面生成
        rightMenuView = [RightMenuView loadFromNib];
        rightMenuView.delegate = self;
        rightMenuView.frame = CGRectMake(VIEW_WIDTH, 0, MENU_WIDTH, VIEW_HEIGHT);
    }
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window = [[UIApplication sharedApplication].windows objectAtIndex:[window subviews].count - 1];
    [window addSubview:rightMenuView];
    
    // メニュー表示アニメーション
    [UIView animateWithDuration:0.3 animations:^{
        if (showRightMenu) {
            self.navigationController.view.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
            rightMenuView.frame = CGRectMake(VIEW_WIDTH, 0, MENU_WIDTH, VIEW_HEIGHT);
            
        } else {
            self.navigationController.view.frame = CGRectMake(- MENU_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT);
            rightMenuView.frame = CGRectMake(VIEW_WIDTH - MENU_WIDTH, 0, MENU_WIDTH, VIEW_HEIGHT);
        }
        
    } completion:^(BOOL finished) {
        
        if (showRightMenu) {
            [rightMenuView removeFromSuperview];
            showRightMenu = NO;
            
            if (select != MenuClose) {
                
                // 画面遷移先を判定
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

// 「Next」ボタン押下処理
- (void)nextView:(id)sender {
    
    if (showRightMenu) return;
    if (showLeftMenu) return;
    
    NextViewController *next = [self.storyboard instantiateViewControllerWithIdentifier:@"NextViewController"];
    [self.navigationController pushViewController:next animated:YES];
}


// 「左Menu」ボタン押下処理
- (void)leftMenu:(id)sender {
    
    if (sender) {
        select = MenuClose;
    }
    
    if (!showLeftMenu) {
        
        //メニュー画面生成
        leftMenuView = [LeftMenuView loadFromNib];
        leftMenuView.delegate = self;
        leftMenuView.frame = CGRectMake(- MENU_WIDTH, 0, MENU_WIDTH, VIEW_HEIGHT);
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:[window subviews].count - 1];
    [window addSubview:leftMenuView];
    
    // メニュー表示アニメーション
    [UIView animateWithDuration:0.3 animations:^{
        if (showLeftMenu) {
            self.navigationController.view.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
            leftMenuView.frame = CGRectMake(- MENU_WIDTH, 0, MENU_WIDTH, VIEW_HEIGHT);
            
        } else {
            self.navigationController.view.frame = CGRectMake(MENU_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT);
            leftMenuView.frame = CGRectMake(0, 0, MENU_WIDTH, VIEW_HEIGHT);
        }
        
    } completion:^(BOOL finished) {
        
        if (showLeftMenu) {
            [leftMenuView removeFromSuperview];
            showLeftMenu = NO;
            
            if (select != MenuClose) {
                
                // 画面遷移先を判定
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

// 「Back」ボタン押下処理
- (void)backView:(UIButton*)sender {
    
    if (showRightMenu) return;
    if (showLeftMenu) return;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark- RightMenuViewDelegate
- (void)closeRightMenu:(NSInteger)indexRow {
    
    select = indexRow;
    [self rightMenu:nil];
}


#pragma mark- LeftMenuViewDelegate
- (void)closeLeftMenu:(NSInteger)indexRow {
    
    select = indexRow + 3;
    [self leftMenu:nil];
}


#pragma mark- Memory Manage
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end
