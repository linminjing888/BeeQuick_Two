//
//  HeaderLinePageView.m
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/23.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import "HeaderLinePageView.h"
#import "HeaderLineContentView.h"

static const CGFloat MaxContentViewCount = 3;

@interface HeaderLinePageView()<UIScrollViewDelegate>

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIScrollView *headlineScrollView;
@property (nonatomic,assign) NSInteger currentPage;
@end
@implementation HeaderLinePageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self)
    {
        _headlineScrollView = [[UIScrollView alloc]init];
        _headlineScrollView.pagingEnabled = YES;
        _headlineScrollView.bounces = NO;
        _headlineScrollView.delegate = self;
        _headlineScrollView.showsHorizontalScrollIndicator = NO;
        _headlineScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_headlineScrollView];
        
        for (NSInteger i =0; i<MaxContentViewCount; i++)
        {
            HeaderLineContentView * contentView = [[HeaderLineContentView alloc]init];
            contentView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentViewClicked:)];
            [contentView addGestureRecognizer:tap];
            [_headlineScrollView addSubview:contentView];
            
        }
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.headlineScrollView.frame = self.bounds;
    CGFloat scrollViewW = self.headlineScrollView.frame.size.width;
    CGFloat scrollViewH = self.headlineScrollView.frame.size.height;
    self.headlineScrollView.contentSize = CGSizeMake(scrollViewW, scrollViewH * MaxContentViewCount);
    for (NSInteger i= 0; i<MaxContentViewCount; i++)
    {
        HeaderLineContentView * contentView =self.headlineScrollView.subviews[i];
        contentView.frame =CGRectMake(0, i *  scrollViewH, scrollViewW, scrollViewH);
    }
}

-(void)updateHeadlinePageView
{
    CGFloat scrollViewH = self.headlineScrollView.frame.size.height;
    for (NSInteger i = 0; i < MaxContentViewCount; i++)
    {
        NSInteger index = self.currentPage;
        HeaderLineContentView *contentView = self.headlineScrollView.subviews[i];
        if (i==0){
            index--;
        }else if(i==2){
            index ++;
        }
        if (index < 0) {
            index = self.info.act_rows.count - 1;
        }else if (index > self.info.act_rows.count -1)
        {
            index = 0;
        }
        
        //current=2 i=0 index=1   i=1 index=2  i=2 index=3=0
        //current=1 i=0 index=0   i=1 index=1  i=2 index=2
        
        contentView.tag = index;
        contentView.actRow = self.info.act_rows[index];
    }
    self.headlineScrollView.contentOffset = CGPointMake(0, scrollViewH);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat minDistance = MAXFLOAT;
    for (NSInteger i = 0; i < MaxContentViewCount; i++)
    {
        HeaderLineContentView *contentView = self.headlineScrollView.subviews[i];
        CGFloat distance = fabs(contentView.frame.origin.y - self.headlineScrollView.contentOffset.y);
        if (distance < minDistance)
        {
            minDistance = distance;
            self.currentPage = contentView.tag;
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateHeadlinePageView];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateHeadlinePageView];
}

-(void)setInfo:(ActInfo *)info
{
    [self layoutIfNeeded];
    _info = info;
    self.currentPage = 0;
    [self stopTimer];
    [self startTimer];
    [self updateHeadlinePageView];
    
}
-(void)startTimer
{
    self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)stopTimer
{
    if (self.timer != nil)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)next
{
    CGFloat scrollViewH = self.headlineScrollView.frame.size.height;
    [self.headlineScrollView setContentOffset:CGPointMake(0, 2 * scrollViewH) animated:YES];
}

-(void)contentViewClicked:(UITapGestureRecognizer*)tap
{
    if (self.callback)
    {
        self.callback(HeadViewItemTypeHeadline,tap.view.tag);
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
