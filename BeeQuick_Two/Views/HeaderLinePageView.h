//
//  HeaderLinePageView.h
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/23.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHeaderData.h"

@interface HeaderLinePageView : UIView
@property (nonatomic,strong)ActInfo * info;
@property (nonatomic,copy) ClikedCallback callback;
@end
