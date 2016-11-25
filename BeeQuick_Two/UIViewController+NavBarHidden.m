//
//  UIViewController+scrollerHidden.m
//  自定义导航控制器
//
//  Created by HelloYeah on 16/3/12.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "UIViewController+NavBarHidden.h"
#import <objc/runtime.h>
#import "sys/sysctl.h"

@interface UIViewController ()
@property (nonatomic,strong) UIImage  * navBarBackgroundImage; //导航条的背景图片
/** 需要监听的view */
@property (nonatomic,weak) UIScrollView * keyScrollView;
/** 设置导航条上的标签是否需要跟随滚动变化透明度,默认不会跟随滚动变化透明度 */
@property (nonatomic,assign) HYHidenControlOptions  hy_hidenControlOptions;
/** ScrollView的Y轴偏移量大于scrolOffsetY的距离后,导航条的alpha为1 */
@property (nonatomic,assign) CGFloat scrolOffsetY;
@end

@implementation UIViewController (NavBarHidden)

#pragma mark - ************* 通过运行时动态添加存储属性 ******************
//定义关联的Key
static const char * key = "keyScrollView";
- (UIScrollView *)keyScrollView{
   
    return objc_getAssociatedObject(self, key);
}

- (void)setKeyScrollView:(UIScrollView *)keyScrollView{
    objc_setAssociatedObject(self, key, keyScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//定义关联的Key
static const char * navBarBackgroundImageKey = "navBarBackgroundImage";
- (UIImage *)navBarBackgroundImage{
    return objc_getAssociatedObject(self, navBarBackgroundImageKey);
}

- (void)setNavBarBackgroundImage:(UIImage *)navBarBackgroundImage{
    objc_setAssociatedObject(self, navBarBackgroundImageKey, navBarBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//定义关联的Key
static const char * scrolOffsetYKey = "offsetY";
- (CGFloat)scrolOffsetY{
    
    return [objc_getAssociatedObject(self, scrolOffsetYKey) floatValue];
}

- (void)setScrolOffsetY:(CGFloat)scrolOffsetY{
    
    if ([self doDeviceVersion] <= 5) {
        return;
    }
    objc_setAssociatedObject(self, scrolOffsetYKey, @(scrolOffsetY), OBJC_ASSOCIATION_ASSIGN);
}

//定义关联的Key
static const char * hy_hidenControlOptionsKey = "hy_hidenControlOptions";
- (NSInteger)hy_hidenControlOptions{
    
    return [objc_getAssociatedObject(self,hy_hidenControlOptionsKey) integerValue];
}
- (void)setHy_hidenControlOptions:(NSInteger)hy_hidenControlOptions{
    
    objc_setAssociatedObject(self, hy_hidenControlOptionsKey, @(hy_hidenControlOptions), OBJC_ASSOCIATION_ASSIGN);
}


#pragma mark - **************** 核心代码-对外接口功能实现代码 ******************

- (void)setInViewWillAppear{

    //设置背景图片
    [self.navigationController.navigationBar setBackgroundImage:self.navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    //清除边框，设置一张空的图片
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    self.keyScrollView.contentOffset = CGPointMake(0, self.keyScrollView.contentOffset.y - 1);
    self.keyScrollView.contentOffset = CGPointMake(0, self.keyScrollView.contentOffset.y + 1);
    
}

- (void)setInViewWillDisappear{

    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:1];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)setKeyScrollView:(UIScrollView *)keyScrollView scrolOffsetY:(CGFloat)scrolOffsetY options:(HYHidenControlOptions)options{
    
    self.keyScrollView = keyScrollView;
    self.hy_hidenControlOptions = options;
    self.scrolOffsetY = scrolOffsetY;
    [self.keyScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - *********************** 内部方法 **********************

static CGFloat alpha = 0;
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    CGFloat offsetY = ([self doDeviceVersion] <= 5) ? [UIScreen mainScreen].bounds.size.height:self.scrolOffsetY;
    CGPoint point = self.keyScrollView.contentOffset;
    alpha =  point.y/offsetY;
    alpha = (alpha <= 0)?0:alpha;
    alpha = (alpha >= 1)?1:alpha;
    //设置导航条上的标签是否跟着透明
    self.navigationItem.leftBarButtonItem.customView.alpha = self.hy_hidenControlOptions & 1?alpha:1;
    self.navigationItem.titleView.alpha = self.hy_hidenControlOptions >> 1 & 1 ?alpha:1;
    self.navigationItem.rightBarButtonItem.customView.alpha = self.hy_hidenControlOptions >> 2 & 1?alpha:1;
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:alpha];

}


- (NSString*) doDevicePlatform
{
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    return 	platform;
}

- (NSInteger)doDeviceVersion{

    //判断手机型号
    NSArray * arr = [[self doDevicePlatform] componentsSeparatedByString:@","];
    NSInteger deviceVersion = 0;
    if ([arr.firstObject containsString:@"iPhone"]) {
        
        deviceVersion  = [[arr.firstObject substringWithRange:(NSRange){6,1}] integerValue];
    }
    return deviceVersion;
}
@end
