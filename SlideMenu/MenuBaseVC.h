//
//  MenuViewController.h
//  SlideMenu
//
//  Created by KentarOu on 2015/03/07.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SelectView) {
    // 右メニュー遷移
    RightMenu_1,
    RightMenu_2,
    RightMenu_3,
    
    // 左メニュー遷移
    LeftMenu_1,
    LeftMenu_2,
    LeftMenu_3,
    
    MenuClose = 999
};

@interface MenuBaseVC : UIViewController

@end
