//
//  RightMenuView.m
//  SlideMenu
//
//  Created by KentarOu on 2015/03/07.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

#import "RightMenuView.h"

@interface RightMenuView()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *rightMenuTable;

@end


@implementation RightMenuView

+ (instancetype)loadFromNib {
    
    RightMenuView *view = [[UINib nibWithNibName:@"RightMenuView" bundle:nil]instantiateWithOwner:nil options:nil][0];
    return view;
}

- (void)awakeFromNib {
    
    self.rightMenuTable.delegate = self;
    self.rightMenuTable.dataSource = self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"RightMenuVC_%zd",indexPath.row + 1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate closeRightMenu:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
