//
//  HotView.h
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/22.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotView : UIView

- (instancetype)initWithImages:(NSArray<NSString *> *)images title:(NSArray *)titles placeHolder:(UIImage *)image;
@property (nonatomic,copy) ClikedCallback callback;

@end
