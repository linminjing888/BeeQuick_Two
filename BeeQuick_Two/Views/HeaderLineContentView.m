//
//  HeaderLineContentView.m
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/23.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import "HeaderLineContentView.h"

@interface HeaderLineContentView()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;

@end
@implementation HeaderLineContentView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self)
    {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor redColor];
        _titleLabel.font = kFont(12);
        _titleLabel.layer.borderColor = [UIColor redColor].CGColor;
        _titleLabel.layer.borderWidth = 1;
        _titleLabel.layer.cornerRadius = 3;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _detailLabel = [[UILabel alloc]init];
        [_detailLabel sizeToFit];
        _detailLabel.font = kFont(12);
        _detailLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        [self addSubview:_detailLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(10);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(18);
        }];
       
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_titleLabel.mas_trailing).offset(10);
            make.centerY.equalTo(self);
        }];

    }
    return self;
}

-(void)setActRow:(ActRow *)actRow
{
    self.titleLabel.text = actRow.headline_detail.title;
    self.detailLabel.text = actRow.headline_detail.content;
}

@end
