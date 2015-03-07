//
//  LeftMenuView.m
//  SlideMenu
//
//  Created by KentarOu on 2015/03/07.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

#import "LeftMenuView.h"

@interface LeftMenuView()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *leftMenuTable;

@end

@implementation LeftMenuView

+ (instancetype)loadFromNib {
    
    LeftMenuView *view = [[UINib nibWithNibName:@"LeftMenuView" bundle:nil]instantiateWithOwner:nil options:nil][0];
    return view;
}


- (void)awakeFromNib {
    
    self.leftMenuTable.delegate = self;
    self.leftMenuTable.dataSource = self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"LeftMenuVC_%zd",indexPath.row + 1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate closeLeftMenu:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
