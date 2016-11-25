//
//  HomeHeaderView.h
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/20.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHeaderData.h"
@class BranchView;
@class HotView;
@class HeaderLineView;
@class PageScrollView;
@interface HomeHeaderView : UIView

@property (nonatomic,strong) PageScrollView * pageView;
@property (nonatomic,strong) HotView * hotView;
@property (nonatomic,strong) BranchView *brandView;
@property (nonatomic,strong) BranchView *sceneView;
@property (nonatomic,strong) HeaderLineView * lineView;

- (instancetype)initWithHeadData:(HomeHeaderData *)headData;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,copy) ClikedCallback callback;

@end
