//
//  TableViewCell.m
//  MCPush
//
//  Created by MC on 16/8/25.
//  Copyright © 2016年 MC. All rights reserved.
//
#import "TableViewCell.h"

@implementation TableViewCell
-(void)prepareUI1{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.contentView.backgroundColor = AppMCBgCOLOR;
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    img.image = [UIImage imageNamed:@"bg1.jpeg"];
    [self.contentView addSubview:img];
    
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
