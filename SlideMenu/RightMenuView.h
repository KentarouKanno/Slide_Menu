//
//  RightMenuView.h
//  SlideMenu
//
//  Created by KentarOu on 2015/03/07.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RightMenuViewDelegate <NSObject>

- (void)closeRightMenu:(NSInteger)indexRow;

@end

@interface RightMenuView : UIView

@property (assign, nonatomic) id delegate;

+ (instancetype)loadFromNib;

@end
