//
//  HotView.m
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/22.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import "HotView.h"
#import "IconImageView.h"

static const CGFloat DefaultMargin = 10;

@implementation HotView

-(instancetype)initWithImages:(NSArray<NSString *> *)images title:(NSArray *)titles placeHolder:(UIImage *)image
{
    self =[super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        for (NSInteger i = 0; i<images.count; i++)
        {
            IconImageView *iconView = [IconImageView IconImageTextView:images[i] title:titles[i] placeHolder:image];
            iconView.tag = i;
            UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicked:)];
            [iconView addGestureRecognizer:tap];
            [self addSubview:iconView];
        }

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat iconW = (LSCREENW - 2 * DefaultMargin) / 4;
    CGFloat iconH = iconW * 0.68 + 20;
    for (NSInteger i = 0; i<self.subviews.count; i++)
    {
        IconImageView *iconView = self.subviews[i];
        CGFloat iconX = (i % 4) * iconW + DefaultMargin;
        CGFloat iconY = (i / 4) * iconH;
        iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    }
    self.bounds = CGRectMake(0, 0, LSCREENW, (self.subviews.count / 4) * iconH);
    
}
-(void)clicked:(UITapGestureRecognizer*)tap
{
    if (self.callback)
    {
        self.callback(HeadViewItemTypeHot,tap.view.tag);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
