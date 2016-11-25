//
//  HomeHeaderData.h
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/20.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Goods.h"
typedef void(^CompleteBlock)(id data,NSError *error);
@class ActInfo;
@class ActRow;
@class HeadlineDetail;
@class CategoryDetail;
@class ExtParams;
@class Activity;

@interface HomeHeaderData : NSObject

@property (nonatomic,copy) NSArray<ActInfo *> *act_info;

@property (nonatomic,strong) ActInfo *focus;
@property (nonatomic,strong) ActInfo *icon;
@property (nonatomic,strong) ActInfo *headline;
@property (nonatomic,strong) ActInfo *brand;
@property (nonatomic,strong) ActInfo *scene;
@property (nonatomic,strong) ActInfo *category;
+ (void)loadHeadData:(CompleteBlock)complete;

@end

@interface ActInfo : NSObject
@property (nonatomic,strong) NSString *sort;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *head_img;
@property (nonatomic,strong) NSArray<ActRow *> *act_rows;

@end

@interface ActRow : NSObject
@property (nonatomic,strong) Activity *activity;
@property (nonatomic,strong) HeadlineDetail *headline_detail;
@property (nonatomic,strong) CategoryDetail *category_detail;

@end

@interface HeadlineDetail : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;

@end

@interface CategoryDetail : NSObject
@property (nonatomic,strong) NSString *category_id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSArray<Goods *> *goods;
@property (nonatomic,strong) NSString *category_color;

@end


@interface Activity : NSObject
@property (nonatomic,copy) NSString *aid;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *topimg;
@property (nonatomic,copy) NSString *jptype;
@property (nonatomic,copy) NSString *trackid;
@property (nonatomic,copy) NSString *mimg;
@property (nonatomic,strong) ExtParams *ext_params;


@end

@interface ExtParams : NSObject
@property (nonatomic,copy) NSString *cityid;
@property (nonatomic,copy) NSString *bigids;
@property (nonatomic,copy) NSString *activitygroup;
@end

