//
//  HomeCategoryCell.m
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/19.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import "HomeCategoryCell.h"
#import "HomeCellGoodsView.h"
@interface HomeCategoryCell ()
///颜色块
@property (nonatomic,strong) UIView *rectangleView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *moreLabel;

@property (nonatomic,strong) UIImageView *brandImg;

@property (nonatomic,strong) HomeCellGoodsView * goodsView;

@end
@implementation HomeCategoryCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self)
    {
        self.contentView.backgroundColor =[UIColor whiteColor];
        
        UIView *titleView = [[UIView alloc]init];
        [self.contentView addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.leading.equalTo(self);
            make.width.equalTo(self);
            make.height.mas_equalTo(40);
        }];
        
        _rectangleView = [[UIView alloc]init];
        [titleView addSubview:_rectangleView];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"优选水果";
        _titleLabel.font = kFont(15);
        [_titleLabel sizeToFit];
        [titleView addSubview:_titleLabel];
        
        UILabel *moreLabel = [[UILabel alloc]init];
        moreLabel.text = @"更多 >";
        moreLabel.font = kFont(13);
        [moreLabel sizeToFit];
        moreLabel.textAlignment = NSTextAlignmentRight;
        moreLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0  blue:150/255.0  alpha:1.0];
        [titleView addSubview:moreLabel];
        
        [_rectangleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(10);
            make.width.mas_equalTo(5);
            make.height.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_rectangleView.mas_trailing).offset(5);
            make.width.mas_equalTo(LSCREENW / 2);
            make.centerY.mas_equalTo(0);
        }];
        
        [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_titleLabel.mas_trailing);
            make.trailing.equalTo(self).offset(-10);
            make.centerY.mas_equalTo(0);
        }];
        
        _brandImg = [[UIImageView alloc]init];
        [self.contentView addSubview:_brandImg];
        
        _goodsView = [[HomeCellGoodsView alloc]init];
        [self.contentView addSubview:_goodsView];
        
        [_brandImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(10);
            make.trailing.equalTo(self).offset(-10);
            make.top.equalTo(titleView.mas_bottom);
            make.height.mas_equalTo(80);
        }];
        
        [_goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.top.equalTo(_brandImg.mas_bottom);
            make.trailing.equalTo(self);
            make.height.mas_equalTo(200);
        }];

    }
    return self;
}

-(void)setActRow:(ActRow *)actRow
{
    UIColor * color =[UIColor hexStringToColor:actRow.category_detail.category_color];
    self.rectangleView.backgroundColor = color;
    self.titleLabel.textColor = color;
    self.titleLabel.text = actRow.category_detail.name;
    
    [self.brandImg setImageWithURLStr:actRow.activity.img placeholderImage:[UIImage imageNamed:@"v2_placeholder_full_size"]];
    
    self.goodsView.actRow = actRow;
}
@end
