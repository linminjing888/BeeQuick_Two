//
//  BranchView.h
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/20.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHeaderData.h"
typedef NS_ENUM(NSInteger, BrandViewType) {
    BrandViewTypeThree,
    BrandViewTypeFour
};


@interface BranchView : UIView

- (instancetype)initWithActRow:(ActInfo *)actInfo;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,copy) ClikedCallback callback;
@end
