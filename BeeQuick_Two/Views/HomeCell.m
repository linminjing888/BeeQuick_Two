//
//  HomeCell.m
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/19.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import "HomeCell.h"
#import "Goods.h"
#import "BuyView.h"
@interface HomeCell()

/** 背景图 */
@property (nonatomic,strong) UIImageView *backImageView;
/** 商品的图片 */
@property (nonatomic,strong) UIImageView *goodsImageView;
/** 商品名字的图片 */
@property (nonatomic,strong) UILabel *nameLabel;
/** 精选的图片 */
@property (nonatomic,strong) UIImageView *fineImageView;
/** 买一赠一的图片 */
@property (nonatomic,strong) UIImageView *giveImageView;
/** 商品单位的图片 */
@property (nonatomic,strong) UILabel *specificsLabel;

@property (nonatomic,strong) BuyView *buyView;
/** 选择数量 */
//@property (nonatomic,assign) HomeCellType type;
@end
@implementation HomeCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _goodsImageView = [[UIImageView alloc]init];
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = kFont(14);
        
        _fineImageView = [[UIImageView alloc]init];
        [_fineImageView setImage:[UIImage imageNamed:@"jingxuan.png"]];
        
        _giveImageView = [[UIImageView alloc]init];
        [_giveImageView setImage:[UIImage imageNamed:@"buyOne.png"]];
        
        _specificsLabel = [[UILabel alloc]init];
        _specificsLabel.font = kFont(12);
        _specificsLabel.textColor = [UIColor darkGrayColor];
        
        _buyView = [[BuyView alloc]init];
        
        [self addSubview:_goodsImageView];
        [self addSubview:_nameLabel];
        [self addSubview:_fineImageView];
        [self addSubview:_giveImageView];
        [self addSubview:_specificsLabel];
        [self addSubview:_buyView];
        
        [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.leading.equalTo(self);
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(self.mas_width);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_goodsImageView.mas_bottom);
            make.leading.equalTo(self).offset(5);
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(20);
        }];
        [_fineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_nameLabel);
            make.top.equalTo(_nameLabel.mas_bottom);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(15);
        }];
        [_giveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_fineImageView.mas_trailing);
            make.top.equalTo(_fineImageView);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(15);
        }];
        [_specificsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_nameLabel);
            make.top.equalTo(_fineImageView.mas_bottom);
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(20);
        }];
     
        [_buyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-5);
            make.trailing.equalTo(self).offset(-5);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(25);
        }];

    }
    return self;
}
-(void)setGoods:(Goods *)goods
{
    [self.goodsImageView setImageWithURLStr:goods.img placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
    self.nameLabel.text = goods.name;
    if ([goods.pm_desc isEqualToString:@"买一赠一"]) {
        self.giveImageView.hidden = NO;
    }else{
        self.giveImageView.hidden = YES;
    }
    self.specificsLabel.text = goods.specifics;
    self.buyView.goodNum = 0 ;
}
@end
