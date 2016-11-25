//
//  HeaderLineView.m
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/23.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import "HeaderLineView.h"
#import "HeaderLinePageView.h"
@interface HeaderLineView ()
@property (nonatomic,strong) UIImageView *headlineImageView;
@property (nonatomic,strong) HeaderLinePageView *pageView;
@end
@implementation HeaderLineView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0].CGColor;
        self.layer.borderWidth = 1;
        
        _headlineImageView = [[UIImageView alloc]init];
        _headlineImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_headlineImageView];
        
        _pageView = [[HeaderLinePageView alloc]init];
        [self addSubview:_pageView];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        [self addSubview:line];
        
        [_headlineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
            make.height.equalTo(self);
            make.leading.equalTo(self).offset(10);
            make.top.equalTo(self);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.leading.equalTo(_headlineImageView.mas_trailing);
            make.bottom.equalTo(self).offset(-5);
            make.width.mas_equalTo(1);
        }];
        
        [_pageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_headlineImageView.mas_trailing);
            make.top.equalTo(self);
            make.height.equalTo(self);
            make.trailing.equalTo(self);
        }];
    }
    return self;
}
-(void)setInfo:(ActInfo *)info
{
    [self.headlineImageView setImageWithURLStr:info.head_img placeholderImage:nil];
    self.pageView.info = info;
}
-(void)setCallback:(ClikedCallback)callback
{
    self.pageView.callback = callback;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
