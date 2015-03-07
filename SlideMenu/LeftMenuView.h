//
//  LeftMenuView.h
//  SlideMenu
//
//  Created by KentarOu on 2015/03/07.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LeftMenuViewDelegate <NSObject>

- (void)closeLeftMenu:(NSInteger)indexRow;

@end

@interface LeftMenuView : UIView

+ (instancetype)loadFromNib;

@property (assign, nonatomic) id delegate;

@end
