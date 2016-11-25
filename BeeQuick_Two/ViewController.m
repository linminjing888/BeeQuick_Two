//
//  ViewController.m
//  BeeQuick_Two
//
//  Created by MinJing_Lin on 16/11/19.
//  Copyright © 2016年 MinJing_Lin. All rights reserved.
//

#import "ViewController.h"
#import "LMJRefreshHeader.h"
#import "HomeCell.h"
#import "HomeCategoryCell.h"
#import "Goods.h"
#import "HomeHeaderCell.h"
#import "HomeHeaderData.h"
#import "HomeHeaderView.h"
#import "WebViewController.h"
#import "UIViewController+NavBarHidden.h"
static const CGFloat HomeMargin = 10;
static NSString *homeCellId = @"HomeCellId";
static NSString *homeCategoryCellId = @"HomeCategoryCellId";
static NSString *footerCellId = @"FooterCellId";
static NSString *headerCellId = @"HeaderCellId";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray<Goods *> * freshHots;
@property (nonatomic,strong) HomeHeaderData *homeHeadData;
///头视图
@property (nonatomic,strong) HomeHeaderView *homeHeadView;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setInViewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self setInViewWillDisappear];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =COLOR_YELLOW;
    
    [self buildCollectionView];
    [self setUpData];
    [self addNotification];
    
    [self setKeyScrollView:self.collectionView scrolOffsetY:200 options:HYHidenControlOptionTitle | HYHidenControlOptionLeft];

}
-(void)setUpData
{
    WEAKSELf
    [HomeHeaderData loadHeadData:^(HomeHeaderData *homeHeadData, NSError *error) {
        weakSelf.homeHeadData =homeHeadData;
        self.homeHeadView = [[HomeHeaderView alloc]initWithHeadData:homeHeadData];
        self.homeHeadView.callback = ^(HeadViewItemType type,NSInteger tag){
            [weakSelf showActityDetail:type tag:tag];
        };
        [self.collectionView addSubview:self.homeHeadView];
        [weakSelf.collectionView reloadData];
    }];
    
    [GoodsData loadGoodsData:^(NSArray<Goods *> *freshHots, NSError *error) {
        weakSelf.freshHots = freshHots;
        [weakSelf.collectionView reloadData];
    }];
}
-(void)showActityDetail:(HeadViewItemType)type tag:(NSInteger)tag
{
    NSLog(@"%ld--%ld",type,tag);
//    ActInfo *actInfo = self.homeHeadData.act_info[type];
//    Activity *activity = actInfo.act_rows[tag].activity;
//    [self presentViewController:[[WebViewController alloc]initWithActivity:activity] animated:YES completion:nil];
}
-(void)buildCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 8;
    layout.minimumLineSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(0, HomeMargin, 0, HomeMargin);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = COLOR_BG;
    [self.collectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:homeCellId];
    [self.collectionView registerClass:[HomeCategoryCell class] forCellWithReuseIdentifier:homeCategoryCellId];
    [self.collectionView registerClass:[HomeFooterCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCellId];
    [self.collectionView registerClass:[HomeHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCellId];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(LSCREENH-64);
//        make.edges.equalTo(self.view);
    }];
    LMJRefreshHeader *header = [LMJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    header.gifView.frame = CGRectMake(0, 30, 100, 100);
    self.collectionView.mj_header = header;
}

-(void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeTableHeadViewHeightDidChange:) name:HomeTableHeadViewHeightDidChange object:nil];
}
- (void)homeTableHeadViewHeightDidChange:(NSNotification *)notification {
    CGFloat height = [(NSNumber *)notification.object floatValue];
    
    self.collectionView.mj_header.ignoredScrollViewContentInsetTop = height;
    self.homeHeadView.frame = CGRectMake(0, -height, LSCREENW, height);
    self.collectionView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    self.collectionView.contentOffset = CGPointMake(0, -height);
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0)
    {
        return self.homeHeadData.category.act_rows.count ;
    }else if(section == 1)
    {
        return self.freshHots.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        HomeCategoryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCategoryCellId forIndexPath:indexPath];
        cell.actRow = self.homeHeadData.category.act_rows[indexPath.row];
        return cell;
    }
    HomeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCellId forIndexPath:indexPath];
    cell.goods = self.freshHots[indexPath.row];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = CGSizeZero;
    if (indexPath.section==0)
    {
         itemSize = CGSizeMake(LSCREENW, 320);
    }else
    {
        itemSize = CGSizeMake((LSCREENW - HomeMargin * 2) * 0.5 - 4, 250);
    }
    return itemSize;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(LSCREENW, HomeMargin);
    }else if(section == 1){
        return CGSizeMake(LSCREENW, HomeMargin * 3);
    }
    return CGSizeZero;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return CGSizeMake(LSCREENW, HomeMargin * 5);
    }
    return CGSizeZero;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        HomeHeaderCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCellId forIndexPath:indexPath];
        if (indexPath.section == 0) {
            [cell showTitleLable:NO];
        }else{
            [cell showTitleLable:YES];
        }
        return cell;
    }
    HomeFooterCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCellId forIndexPath:indexPath];
    
    return cell;
}

-(void)headerRefresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.mj_header endRefreshing];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
