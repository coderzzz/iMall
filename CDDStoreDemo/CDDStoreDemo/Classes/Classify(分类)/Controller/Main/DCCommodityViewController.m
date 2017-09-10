//
//  DCCommodityViewController.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
#define tableViewH  100

#import "DCCommodityViewController.h"

// Controllers
#import "DCGoodDetailViewController.h"
// Models
#import "DCClassMianItem.h"
#import "DCCalssSubItem.h"
#import "DCClassGoodsItem.h"
#import "DCFeatureItem.h"
#import "DCFeatureList.h"
#import "DCFeatureTitleItem.h"
// Views
#import "DCNavSearchBarView.h"
#import "DCClassCategoryCell.h"
#import "DCGoodsSortCell.h"
#import "DCBrandSortCell.h"
#import "DCBrandsSortHeadView.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface DCCommodityViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* collectionViw */
@property (strong , nonatomic)UICollectionView *collectionView;

/* 左边数据 */
@property (strong , nonatomic)NSMutableArray<DCClassGoodsItem *> *titleItem;

@property (strong, nonatomic) DCClassGoodsItem *caItem;
@end

static NSString *const DCClassCategoryCellID = @"DCClassCategoryCell";
static NSString *const DCBrandsSortHeadViewID = @"DCBrandsSortHeadView";
static NSString *const DCGoodsSortCellID = @"DCGoodsSortCell";
static NSString *const DCBrandSortCellID = @"DCBrandSortCell";

@implementation DCCommodityViewController

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.frame = CGRectMake(0, 20, tableViewH, ScreenH  - DCBottomTabH -20);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[DCClassCategoryCell class] forCellReuseIdentifier:DCClassCategoryCellID];
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 3; //X
        layout.minimumLineSpacing = 5;  //Y
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(tableViewH, 20, ScreenW - tableViewH, ScreenH - DCBottomTabH - 20);
        //注册Cell
        [_collectionView registerClass:[DCGoodsSortCell class] forCellWithReuseIdentifier:DCGoodsSortCellID];
        [_collectionView registerClass:[DCBrandSortCell class] forCellWithReuseIdentifier:DCBrandSortCellID];
        //注册Header
        [_collectionView registerClass:[DCBrandsSortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCBrandsSortHeadViewID];
    }
    return _collectionView;
}


#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.barTintColor == RGBA(231, 23, 37, 1.0))return;
    self.navigationController.navigationBar.barTintColor = RGBA(231, 23, 37, 1.0);
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpTab];
    
    [self setUpData];
}

#pragma mark - initizlize
- (void)setUpTab
{
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self firstLoad];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        [self loadMore];
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 加载数据
- (void)setUpData
{
    
    [BAIRUITECH_NetWorkManager FinanceLiveShow_LZLGetLiveNoticeContentType:nil withSuccessBlock:^(NSDictionary *object) {
        
        
        
        
//        if([object[@"error"]intValue] == 0){
        
            
            _titleItem = [DCClassGoodsItem mj_objectArrayWithKeyValuesArray:object];
            [_tableView reloadData];
            [self selectSortWithRow:0];
        
//        }else{
//            
//            
//        }
        
        
    } withFailureBlock:^(NSError *error) {
        

        
        //        YJLog(@"error %@",error);
        
        
    }];
    
    
}

- (void)selectSortWithRow:(NSInteger)row{
    
    self.caItem = _titleItem[row];
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    if (self.caItem.mainItem.count>0) {
        
        [self.collectionView reloadData];
        return;
    }
    
    [self firstLoad];
    
    

    
}

- (void)firstLoad{
    
    self.caItem.pageIndex = 1;
    self.caItem.mainItem = [NSMutableArray array];
    
    [self setUpGoodsData];
}

- (void)loadMore{
    
    self.caItem.pageIndex += 1;
    [self setUpGoodsData];
    
}


- (void)setUpGoodsData
{
    
    
    [BAIRUITECH_NetWorkManager FinanceLiveShow_LZLGetListByTypeId:@{@"cate_id":self.caItem.id,@"pageNumber":@(self.caItem.pageIndex)} withSuccessBlock:^(NSDictionary *object) {
        
        
        
        
        //        if([object[@"error"]intValue] == 0){
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [self.caItem.mainItem addObjectsFromArray:[DCGoodItem mj_objectArrayWithKeyValuesArray:object[@"list"]]];
        [self.collectionView reloadData];
    
        
        //        }else{
        //
        //
        //        }
        
        
    } withFailureBlock:^(NSError *error) {
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
        //        YJLog(@"error %@",error);
        
        
    }];
    
}


#pragma mark - 设置导航条
- (void)setUpNav
{
    
//    DCNavSearchBarView *searchBarVc = [[DCNavSearchBarView alloc] init];
//    searchBarVc.placeholdLabel.text = @"快速查找商品";
//    searchBarVc.frame = CGRectMake(20, 25, ScreenW - 40, 35);
//    searchBarVc.voiceButtonClickBlock = ^{
//        NSLog(@"语音点击回调");
//    };
//    searchBarVc.searchViewBlock = ^{
//        NSLog(@"搜索");
//    };
//    
//    self.navigationItem.titleView = searchBarVc;
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCClassCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:DCClassCategoryCellID forIndexPath:indexPath];
    cell.titleItem = _titleItem[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    _mainItem = [DCClassMianItem mj_objectArrayWithFilename:_titleItem[indexPath.row].fileName];
    [self selectSortWithRow:indexPath.row];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return self.caItem.mainItem.count;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
//    if ([_mainItem[_mainItem.count - 1].title isEqualToString:@"热门品牌"]) {
//        if (indexPath.section == _mainItem.count - 1) {//品牌
//            DCBrandSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCBrandSortCellID forIndexPath:indexPath];
//            cell.subItem = _mainItem[indexPath.section].goods[indexPath.row];
//            gridcell = cell;
//        }
//        else {//商品
//            DCGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsSortCellID forIndexPath:indexPath];
//            cell.subItem = _mainItem[indexPath.section].goods[indexPath.row];
//            gridcell = cell;
//        }
//    }else{//商品
        DCGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsSortCellID forIndexPath:indexPath];
        cell.subItem = self.caItem.mainItem[indexPath.row];
        gridcell = cell;
//    }

    return gridcell;
}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//    UICollectionReusableView *reusableview = nil;
////    if (kind == UICollectionElementKindSectionHeader){
////        
////        DCBrandsSortHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCBrandsSortHeadViewID forIndexPath:indexPath];
////        headerView.headTitle = _mainItem[indexPath.section];
////        reusableview = headerView;
////    }
//    return reusableview;
//}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//        if ([_mainItem[_mainItem.count - 1].title isEqualToString:@"热门品牌"]) {
//            if (indexPath.section == _mainItem.count - 1) {//品牌
//                return CGSizeMake((ScreenW - tableViewH - 6)/3, 60);
//            }else{//商品
//                return CGSizeMake((ScreenW - tableViewH - 6)/3, (ScreenW - tableViewH - 6)/3 + 20);
//            }
//        }else{
            return CGSizeMake((ScreenW - tableViewH - 6)/3, (ScreenW - tableViewH - 6)/3 + 20);
//        }
//    return CGSizeZero;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeMake(ScreenW, 25);
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了个第%zd分组第%zd几个Item",indexPath.section,indexPath.row);
    
    DCGoodItem *good = self.caItem.mainItem[indexPath.row];
    DCUserInfo *info = UserInfoData;
    [BAIRUITECH_NetWorkManager FinanceLiveShow_LZLGetRankType:@{@"uuid":good.uuid,@"token":info.token} withSuccessBlock:^(NSDictionary *object) {
        
        
        
        
        //        if([object[@"error"]intValue] == 0){
        NSMutableArray *list = [NSMutableArray array];
        for (NSDictionary *dic in object[@"spec_info"]) {
            
            NSArray *featurelist = dic[@"spec"];
            for (NSDictionary *spec in featurelist) {
                if (![list containsObject:spec]) {
                    [list addObject:spec];
                }
                
            }
//            [list addObjectsFromArray:featurelist];
        }
        
        NSMutableDictionary *featureCa = [NSMutableDictionary dictionary];
        for (NSDictionary *spec in list) {
            
            NSString *specN = spec[@"spec_name"];
            
            if ([[featureCa allKeys] containsObject:specN]) {
                
                NSMutableArray *cas = featureCa[specN];
                [cas addObject:[DCFeatureList mj_objectWithKeyValues:spec]];
            }
            else{
                
                NSMutableArray *cas = [NSMutableArray array];
                [cas addObject:[DCFeatureList mj_objectWithKeyValues:spec]];
                [featureCa setObject:cas forKey:specN];
            }
        }
        
        NSMutableArray *datas = [NSMutableArray array];
        
        for (NSString *specN in featureCa.allKeys) {
            
            DCFeatureItem *feature = [DCFeatureItem new];
            feature.list =featureCa[specN];
            DCFeatureTitleItem *title = [DCFeatureTitleItem new];
            title.attrname = specN;
            feature.attr = title;
            [datas addObject:feature];
        }
        
        DCGoodDetailViewController *dcVc = [[DCGoodDetailViewController alloc] init];
        DCGoodItem *gooditem =self.caItem.mainItem[indexPath.row];
        gooditem.is_collection = object[@"is_collection"];
        gooditem.spec_info = object[@"spec_info"];
        dcVc.goodItem = gooditem;
        dcVc.features = [datas mutableCopy];
        [self.navigationController pushViewController:dcVc animated:YES];

        
        
        
//        [self.caItem.mainItem addObjectsFromArray:[DCGoodItem mj_objectArrayWithKeyValuesArray:object[@"list"]]];
//        [self.collectionView reloadData];
        
        
        //        }else{
        //
        //
        //        }
        
        
    } withFailureBlock:^(NSError *error) {
        
        //        YJLog(@"error %@",error);
        
        
    }];
    
    
    
}

#pragma 设置StatusBar为白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
