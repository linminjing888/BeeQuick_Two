//
//  IconImageView.m
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/22.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import "IconImageView.h"
@interface IconImageView()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel * textLabel;

@end
@implementation IconImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self)
    {
        self.imageView = [[UIImageView alloc]init];
        self.imageView.userInteractionEnabled = NO;
        [self addSubview:self.imageView];
        
        self.textLabel = [[UILabel alloc]init];
        self.textLabel.userInteractionEnabled = NO;
        self.textLabel.font = [UIFont systemFontOfSize:12];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(20);
        }];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(5);
            make.top.mas_equalTo(5);
            make.trailing.mas_equalTo(-5);
            make.bottom.equalTo(self.textLabel.mas_top).offset(-5);
        }];
    }
    return self;
}
+ (instancetype)IconImageTextView:(NSString *)image title:(NSString *)title placeHolder:(UIImage *)placeHolder
{
    IconImageView * view =[[self alloc]init];
    [view.imageView setImageWithURLStr:image placeholderImage:placeHolder];
    view.textLabel.text = title;
    return view;
}

@end
