//
//  HomeHeaderView.m
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/20.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import "HomeHeaderView.h"
#import "BranchView.h"
#import "HotView.h"
#import "HeaderLineView.h"
@implementation HomeHeaderView

- (instancetype)initWithHeadData:(HomeHeaderData *)headData
{
    self =[super init];
    if (!self) {
        return  nil;
    }
    
    NSMutableArray *iconImages = [NSMutableArray array];
    NSMutableArray *iconTitles = [NSMutableArray array];
    
    
    [headData.icon.act_rows enumerateObjectsUsingBlock:^(ActRow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [iconImages addObject:obj.activity.img];
        [iconTitles addObject:obj.activity.name];
    }];
    
    _hotView =[[HotView alloc]initWithImages:iconImages title:iconTitles placeHolder:[UIImage imageNamed:@"icon_icons_holder"]];
    
    _brandView = [[BranchView alloc]initWithActRow:headData.brand];
    
    _sceneView = [[BranchView alloc]initWithActRow:headData.scene];
    
    _lineView = [[HeaderLineView alloc]init];
    _lineView.info = headData.headline;
    
    [self addSubview:_hotView];
    [self addSubview:_lineView];
    [self addSubview:_brandView];
    [self addSubview:_sceneView];
    
    [_hotView layoutIfNeeded];
    [_brandView layoutIfNeeded];
    [_sceneView layoutIfNeeded];
    
    [_hotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.trailing.equalTo(self);
        make.leading.equalTo(self);
        make.height.mas_equalTo(_hotView.bounds.size.height);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hotView.mas_bottom);
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    [_brandView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.mas_bottom).offset(10);;
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.height.mas_equalTo(_brandView.bounds.size.height);
    }];
    [_sceneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_brandView.mas_bottom).offset(10);
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.height.mas_equalTo(_sceneView.bounds.size.height);
    }];

    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.height = CGRectGetMaxY(self.sceneView.frame);
}

- (void)setHeight:(CGFloat)height
{
    [[NSNotificationCenter defaultCenter] postNotificationName:HomeTableHeadViewHeightDidChange object:[NSNumber numberWithFloat:height]];
}

-(void)setCallback:(ClikedCallback)callback
{
    self.hotView.callback = callback;
    self.brandView.callback = callback;
    self.sceneView.callback = callback;
    self.lineView.callback = callback;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
