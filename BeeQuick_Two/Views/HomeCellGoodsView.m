//
//  HomeCellGoodsView.m
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/20.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import "HomeCellGoodsView.h"
#import "HomeCell.h"
@implementation HomeCellGoodsView

-(instancetype)init
{
    self =[super init];
    if (self)
    {
        for (NSInteger i = 0; i < 3; i++)
        {
            HomeCell *homecell = [[HomeCell alloc]init];
            homecell.layer.borderColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0].CGColor;
            homecell.layer.borderWidth = 0.5;
            [self addSubview:homecell];
        }
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat cellHeight = 200;
    CGFloat cellWidth = LSCREENW / 3;
    for (NSInteger i = 0; i < self.subviews.count; i++)
    {
        HomeCell *cell = self.subviews[i];
        cell.frame = CGRectMake(i * cellWidth, 0, cellWidth, cellHeight);
    }
}
-(void)setActRow:(ActRow *)actRow
{
    for (NSInteger i = 0; i < self.subviews.count; i++)
    {
        HomeCell *cell = self.subviews[i];
        cell.goods = actRow.category_detail.goods[i];
    }
}
@end
