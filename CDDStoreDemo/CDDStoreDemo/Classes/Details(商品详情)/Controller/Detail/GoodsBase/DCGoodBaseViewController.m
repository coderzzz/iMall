//
//  DCGoodBaseViewController.m
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodBaseViewController.h"

// Controllers
#import "DCFootprintGoodsViewController.h"
#import "DCShareToViewController.h"
#import "DCToolsViewController.h"
#import "DCFeatureSelectionViewController.h"
#import "DCFillinOrderViewController.h"
// Models

// Views
#import "DCLIRLButton.h"
#import "DCDetailLikeHeadView.h"
#import "DCDetailShufflingHeadView.h" //头部轮播
#import "DCDetailGoodReferralCell.h"  //商品标题价格介绍
#import "DCDetailShowTypeCell.h"      //种类
#import "DCShowTypeOneCell.h"
#import "DCShowTypeTwoCell.h"
#import "DCShowTypeThreeCell.h"
#import "DCShowTypeFourCell.h"
#import "DCDetailServicetCell.h"      //服务
#import "DCDetailLikeCell.h"          //猜你喜欢
#import "DCDetailOverFooterView.h"    //尾部结束
#import "DCDetailPartCommentCell.h"   //部分评论
#import "DCDeatilCustomHeadView.h"    //自定义头部
// Vendors
#import "AddressPickerView.h"
#import <WebKit/WebKit.h>
#import <MJRefresh.h>
#import <MJExtension.h>
// Categories
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"
// Others

@interface DCGoodBaseViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,WKNavigationDelegate>

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UICollectionView *collectionView;

/* 选择地址弹框 */
@property (strong , nonatomic)AddressPickerView *adPickerView;
/* 已选组Cell */
@property (weak ,nonatomic)DCShowTypeOneCell *cell;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;
/* 通知 */
@property (weak ,nonatomic) id dcObj;

@property (assign, nonatomic) BOOL selected;

@end

//header
static NSString *DCDetailShufflingHeadViewID = @"DCDetailShufflingHeadView";
static NSString *DCDeatilCustomHeadViewID = @"DCDeatilCustomHeadView";
static NSString *DCDetailLikeHeadViewID = @"DCDetailLikeHeadView";
//cell
static NSString *DCDetailGoodReferralCellID = @"DCDetailGoodReferralCell";

static NSString *DCShowTypeOneCellID = @"DCShowTypeOneCell";
static NSString *DCShowTypeTwoCellID = @"DCShowTypeTwoCell";
static NSString *DCShowTypeThreeCellID = @"DCShowTypeThreeCell";
static NSString *DCShowTypeFourCellID = @"DCShowTypeFourCell";

static NSString *DCDetailServicetCellID = @"DCDetailServicetCell";
static NSString *DCDetailLikeCellID = @"DCDetailLikeCell";
static NSString *DCDetailPartCommentCellID = @"DCDetailPartCommentCell";
//footer
static NSString *DCDetailOverFooterViewID = @"DCDetailOverFooterView";


static NSInteger lastNum_;
static NSArray *lastSeleArray_;

@implementation DCGoodBaseViewController

#pragma mark - LazyLoad
- (UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.contentSize = CGSizeMake(ScreenW, (ScreenH - 50) * 2);
        _scrollerView.pagingEnabled = YES;
        _scrollerView.scrollEnabled = NO;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 0; //Y
        layout.minimumInteritemSpacing = 0; //X
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, DCTopNavH, ScreenW, ScreenH - DCTopNavH - 50);
        _collectionView.showsVerticalScrollIndicator = NO;
        [self.scrollerView addSubview:_collectionView];
        
        //注册header
        [_collectionView registerClass:[DCDetailShufflingHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCDetailShufflingHeadViewID];
        [_collectionView registerClass:[DCDeatilCustomHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCDeatilCustomHeadViewID];
        [_collectionView registerClass:[DCDetailLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCDetailLikeHeadViewID];
        
        //注册Cell
        [_collectionView registerClass:[DCDetailGoodReferralCell class] forCellWithReuseIdentifier:DCDetailGoodReferralCellID];
        [_collectionView registerClass:[DCShowTypeOneCell class] forCellWithReuseIdentifier:DCShowTypeOneCellID];
        [_collectionView registerClass:[DCShowTypeTwoCell class] forCellWithReuseIdentifier:DCShowTypeTwoCellID];
        [_collectionView registerClass:[DCShowTypeThreeCell class] forCellWithReuseIdentifier:DCShowTypeThreeCellID];
        [_collectionView registerClass:[DCShowTypeFourCell class] forCellWithReuseIdentifier:DCShowTypeFourCellID];
        [_collectionView registerClass:[DCDetailLikeCell class] forCellWithReuseIdentifier:DCDetailLikeCellID];
        [_collectionView registerClass:[DCDetailPartCommentCell class] forCellWithReuseIdentifier:DCDetailPartCommentCellID];
        [_collectionView registerClass:[DCDetailServicetCell class] forCellWithReuseIdentifier:DCDetailServicetCellID];
        //注册Footer
        [_collectionView registerClass:[DCDetailOverFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCDetailOverFooterViewID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //间隔
        
    }
    return _collectionView;
}



#pragma mark - LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    
    [self setUpViewScroller];
    
//    [self setUpGoodsWKWebView];
    
//    [self setUpSuspendView];
    
    [self acceptanceNote];
}

#pragma mark - initialize
- (void)setUpInit
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = DCBGColor;
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.backgroundColor = self.view.backgroundColor;

    //初始化
    lastSeleArray_ = [NSMutableArray array];
    lastNum_ = 0;
}

#pragma mark - 接受通知
- (void)acceptanceNote
{

    //加入购物车或点击直接购买通知
    _dcObj = [[NSNotificationCenter defaultCenter]addObserverForName:@"ClikAddOrBuy" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        DCFeatureSelectionViewController *dcFeaVc = [DCFeatureSelectionViewController new];
        dcFeaVc.goodItem = _goodItem;
        dcFeaVc.featureAttr = _features;
         [self setUpAlterViewControllerWith:dcFeaVc WithDistance:ScreenH * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
        
//        __weak typeof(self)weakSelf = self;
//        dcFeaVc.userChooseBlock = ^(NSMutableArray *seleArray, NSInteger num, NSInteger tag) { //第一次更新选择的属性
//            NSString *result = [NSString stringWithFormat:@"%@ %zd件",[seleArray componentsJoinedByString:@"，"],num];
//            NSLog(@"%@",result);
//            
//            weakSelf.selected = YES;
//            NSLog(@"加入购物车");
//        };
//        
//        if (weakSelf.selected) {
//            
//            if ([note.userInfo[@"buttonTag"] isEqualToString:@"2"]) { //加入购物车
//                
//                NSLog(@"加入购物车");
//                
//            }else if ([note.userInfo[@"buttonTag"] isEqualToString:@"3"]){//立即购买
//
//                DCFillinOrderViewController *dcFillVc = [DCFillinOrderViewController new];
//                [weakSelf.navigationController pushViewController:dcFillVc animated:YES];
//            }
//            
//        }else{
//            
////            dcFeaVc.goodImageView = _goodImageView;
//            [self setUpAlterViewControllerWith:dcFeaVc WithDistance:ScreenH * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
//        }

    }];
}

#pragma mark - 悬浮按钮
- (void)setUpSuspendView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 100, 40, 40);
}

#pragma mark - 记载图文详情
- (void)setUpGoodsWKWebView
{
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://weibo.com/u/5605532343"]];
//    [self.webView loadRequest:request];
//    
//    //下拉返回商品详情View
//    UIView *topHitView = [[UIView alloc] init];
//    topHitView.frame = CGRectMake(0, -35, ScreenW, 35);
//    DCLIRLButton *topHitButton = [DCLIRLButton buttonWithType:UIButtonTypeCustom];
//    topHitButton.imageView.transform = CGAffineTransformRotate(topHitButton.imageView.transform, M_PI); //旋转
//    [topHitButton setImage:[UIImage imageNamed:@"Details_Btn_Up"] forState:UIControlStateNormal];
//    [topHitButton setTitle:@"下拉返回商品详情" forState:UIControlStateNormal];
//    topHitButton.titleLabel.font = PFR12Font;
//    [topHitButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [topHitView addSubview:topHitButton];
//    topHitButton.frame = topHitView.bounds;
//    
//    [self.webView.scrollView addSubview:topHitView];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    if (section == 0) {
        
        return  2;
    }
    else if (section == 1){
        
        NSArray *imgs = [_goodItem.detail_imgs componentsSeparatedByString:@","];
        return imgs.count;
    }
    return 2;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
//    DCUserInfo *userInfo = UserInfoData;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DCDetailGoodReferralCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCDetailGoodReferralCellID forIndexPath:indexPath];
            cell.goodOldPriceLabel.text= @"200";
            cell.goodCountLabel.text = [NSString stringWithFormat:@"累计销量：%@件",_goodItem.total_stock];
            cell.goodTitleLabel.text = _goodItem.title;
            cell.goodPriceLabel.text = [NSString stringWithFormat:@"¥ %@",_goodItem.price];
            cell.goodSubtitleLabel.text = _goodItem.detail;
            gridcell = cell;
        }else if (indexPath.row == 1){
            DCShowTypeFourCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCShowTypeFourCellID forIndexPath:indexPath];

            gridcell = cell;
        }

    }else if (indexPath.section == 1  ){
        
            DCShowTypeOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCShowTypeOneCellID forIndexPath:indexPath];
            NSArray *imgs = [_goodItem.detail_imgs componentsSeparatedByString:@","];
            cell.url = imgs[indexPath.row];
            gridcell = cell;
       
//     }else if (indexPath.section == 3){
//        DCDetailServicetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCDetailServicetCellID forIndexPath:indexPath];
//        NSArray *btnTitles = @[@"以旧换新",@"可选增值服务"];
//        NSArray *btnImages = @[@"detail_xiangqingye_yijiuhuanxin",@"ptgd_icon_zengzhifuwu"];
//        NSArray *titles = @[@"以旧换新再送好礼",@"为商品保价护航"];
//        [cell.serviceButton setTitle:btnTitles[indexPath.row] forState:UIControlStateNormal];
//        [cell.serviceButton setImage:[UIImage imageNamed:btnImages[indexPath.row]] forState:UIControlStateNormal];
//        cell.serviceLabel.text = titles[indexPath.row];
//        if (indexPath.row == 0) {//分割线
//            [DCSpeedy dc_setUpLongLineWith:cell WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4] WithHightRatio:0.6];
//        }
//        gridcell = cell;
//    }else if (indexPath.section == 4){
//        DCDetailPartCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCDetailPartCommentCellID forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor orangeColor];
//        gridcell = cell;
    }else{
        DCDetailLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCDetailLikeCellID forIndexPath:indexPath];
        gridcell = cell;
    }
    
    return gridcell;
}
//
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            DCDetailShufflingHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCDetailShufflingHeadViewID forIndexPath:indexPath];
            NSArray *ary = [_goodItem.main_imgs componentsSeparatedByString:@","];
            headerView.shufflingArray = ary;
            reusableview = headerView;
    
        }else if (indexPath.section == 1){
            DCDeatilCustomHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCDeatilCustomHeadViewID forIndexPath:indexPath];
            reusableview = headerView;
        }else if (indexPath.section == 2){
            DCDetailLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCDetailLikeHeadViewID forIndexPath:indexPath];
            reusableview = headerView;
        }
    }

    
    return reusableview;
//        }else if (indexPath.section == 5){
//            DCDeatilCustomHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCDeatilCustomHeadViewID forIndexPath:indexPath];
//            reusableview = headerView;
//        }
//    }else if (kind == UICollectionElementKindSectionFooter){
//        if (indexPath.section == 5) {
//            DCDetailOverFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCDetailOverFooterViewID forIndexPath:indexPath];
//            reusableview = footerView;
//        }else{
//            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
//            footerView.backgroundColor = DCBGColor;
//            reusableview = footerView;
//        }
//    }
//    return reusableview;
//    
//    ;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { //商品详情
        return (indexPath.row == 0) ? CGSizeMake(ScreenW, [DCSpeedy dc_calculateTextSizeWithText:_goodItem.title WithTextFont:16 WithMaxW:ScreenW - DCMargin * 6].height + [DCSpeedy dc_calculateTextSizeWithText:_goodItem.price WithTextFont:20 WithMaxW:ScreenW - DCMargin * 6].height + [DCSpeedy dc_calculateTextSizeWithText:_goodItem.detail WithTextFont:12 WithMaxW:ScreenW - DCMargin * 6].height + DCMargin * 4) : CGSizeMake(ScreenW, 30);
//    }else if (indexPath.section == 1){//商品属性选择
//        return CGSizeMake(ScreenW, 60);
//    }else if (indexPath.section == 2){//商品快递信息
//        return CGSizeMake(ScreenW, 60);
//    }else if (indexPath.section == 3){//商品保价
//        return CGSizeMake(ScreenW / 2, 60);
//    }else if (indexPath.section == 4){//商品评价部分展示
//        return CGSizeMake(ScreenW, 270);
        
    }else if (indexPath.section == 1){//商品图片
        
        NSArray *imgs = [_goodItem.detail_imgs componentsSeparatedByString:@","];
        NSString *imgUrl = imgs[indexPath.row];
        CGSize size;
        UIImage *image= [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:imgUrl];
        if (image) {
            size = image.size;
        }
        else{
            
            size = [UIImage getImageSizeWithURL:[NSURL URLWithString:imgUrl]];
        }
        CGFloat height = ScreenW * size.height/size.width;
        
        
        return CGSizeMake(ScreenW, height);
    }else if (indexPath.section == 2){//商品猜你喜欢
        return CGSizeMake(ScreenW/2, 150);
    }else{
        return CGSizeZero;
    }
}


#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (section == 0) ?  CGSizeMake(ScreenW, ScreenH * 0.55) : ( section == 1 || section == 2) ? CGSizeMake(ScreenW, 30) : CGSizeZero;
}

#pragma mark - foot宽高
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return (section == 5) ? CGSizeMake(ScreenW, 35) : CGSizeMake(ScreenW, DCMargin);
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
//        [self scrollToDetailsPage]; //滚动到详情页面
    }else if (indexPath.section == 2 && indexPath.row == 0) {
//        [self chageUserAdress]; //跟换地址
    }else if (indexPath.section == 1){ //属性选择
       
    }
}


#pragma mark - 视图滚动
- (void)setUpViewScroller{
//    __weak typeof(self)weakSelf = self;
//    self.collectionView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
//        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//            !weakSelf.changeTitleBlock ? : weakSelf.changeTitleBlock(YES);
//            weakSelf.scrollerView.contentOffset = CGPointMake(0, ScreenH);
//        } completion:^(BOOL finished) {
//            [weakSelf.collectionView.mj_footer endRefreshing];
//        }];
//    }];
    
//    self.webView.scrollView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        [UIView animateWithDuration:0.8 animations:^{
//            !weakSelf.changeTitleBlock ? : weakSelf.changeTitleBlock(NO);
//            weakSelf.scrollerView.contentOffset = CGPointMake(0, 0);
//        } completion:^(BOOL finished) {
//            [weakSelf.webView.scrollView.mj_header endRefreshing];
//        }];
//        
//    }];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;
}

#pragma mark - 点击事件
//#pragma mark - 更换地址
//- (void)chageUserAdress
//{
//    _adPickerView = [AddressPickerView shareInstance];
//    [_adPickerView showAddressPickView];
//    [self.view addSubview:_adPickerView];
//    
//    __weak typeof(self)weakSelf = self;
//    _adPickerView.block = ^(NSString *province,NSString *city,NSString *district) {
//        DCUserInfo *userInfo = UserInfoData;
//        NSString *newAdress = [NSString stringWithFormat:@"%@ %@ %@",province,city,district];
//        if ([userInfo.defaultAddress isEqualToString:newAdress]) {
//            return;
//        }
//        userInfo.defaultAddress = newAdress;
//        [userInfo save];
//        [weakSelf.collectionView reloadData];
//    };
//}

#pragma mark - 滚动到详情页面
//- (void)scrollToDetailsPage
//{
//    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"scrollToDetailsPage" object:nil];
//    });
//}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    if (self.scrollerView.contentOffset.y > ScreenH) {
        [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    }else{
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.scrollerView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [weakSelf.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        }];
    }
    !_changeTitleBlock ? : _changeTitleBlock(NO);
}

#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable
{
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    [self xw_presentViewController:vc withAnimator:animator];
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
}

#pragma 退出界面
- (void)selfAlterViewback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:_dcObj];
}

@end
