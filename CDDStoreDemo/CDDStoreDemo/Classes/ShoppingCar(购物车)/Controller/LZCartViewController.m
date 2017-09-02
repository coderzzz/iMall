//
//  LZCartViewController.m
//  LZCartViewController
//


#import "LZCartViewController.h"
#import "LZCartTableViewCell.h"
#import "DCRecommendItem.h"
#import "OrderDetailViewController.h"

@interface LZCartViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (strong,nonatomic)NSMutableArray *dataArray;
@property (strong,nonatomic)NSMutableArray *selectedArray;
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)UIButton *allSellectedButton;
@property (strong,nonatomic)UILabel *totlePriceLabel;
@end

@implementation LZCartViewController

#pragma mark - viewController life cicle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupCartView];
   
}


#pragma mark -- 自定义底部视图 
- (void)setupCartView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-DCBottomTabH);
        make.height.offset(50);
    
    }];
    

    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [backgroundView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(backgroundView);
        make.right.equalTo(backgroundView);
        make.top.equalTo(backgroundView);
        make.height.offset(0.5);
        
    }];
    
    //全选按钮
    UIButton *selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = PFR14Font;
    [selectAll setTitle:@"  全选" forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"空心圆"] forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"选中圆"] forState:UIControlStateSelected];
    [selectAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:selectAll];
    self.allSellectedButton = selectAll;
    [selectAll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(backgroundView).offset(DCMargin);
        make.centerY.mas_equalTo(backgroundView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        
    }];
    
    
    
    //结算按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = HEXCOLOR(0xffad00);
    [btn setTitle:@"结算" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goToPayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(backgroundView).offset(0);
        make.centerY.mas_equalTo(backgroundView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 50));
        
    }];
    
    
    
    //合计
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor redColor];
    [backgroundView addSubview:label];
    label.attributedText = [self LZSetString:@"¥0.00"];
    self.totlePriceLabel = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(btn.mas_left).offset(-DCMargin);
        make.centerY.mas_equalTo(backgroundView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200, 50));
        
    }];
    
    
    UITableView *table = [UITableView new];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = DCBGColor;
    [self.view addSubview:table];
    self.myTableView = table;
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
        make.height.offset(ScreenH - 50 - DCBottomTabH - DCTopNavH);
        make.width.offset(ScreenW);
        make.bottom.mas_equalTo(backgroundView.mas_top);
        
    }];
    
    [table reloadData];
}

- (NSMutableAttributedString*)LZSetString:(NSString*)string {
    
    NSString *text = [NSString stringWithFormat:@"合计:%@",string];
    NSMutableAttributedString *LZString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"合计:"];
    [LZString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    [LZString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:rang];
    return LZString;
}

#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZCartReusableCell"];
    if (cell == nil) {
        cell = [[LZCartTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"LZCartReusableCell"];
    }

//    DCRecommendItem *model = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell numberAddWithBlock:^(NSInteger number) {
      
        
        
    }];
    
    [cell numberCutWithBlock:^(NSInteger number) {
        
       
    }];
    
    [cell cellSelectedWithBlock:^(BOOL select) {
        
        
    }];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
           
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }

}

#pragma mark --- 全选按钮点击事件
- (void)selectAllBtnClick:(UIButton*)button {
    button.selected = !button.selected;
    
//    //点击全选时,把之前已选择的全部删除
//    for (LZGoodsModel *model in self.selectedArray) {
//        model.select = NO;
//    }
//    
//    [self.selectedArray removeAllObjects];
//    
//    if (button.selected) {
//        
//        for (LZShopModel *shop in self.dataArray) {
//            shop.select = YES;
//            for (LZGoodsModel *model in shop.goodsArray) {
//                model.select = YES;
//                [self.selectedArray addObject:model];
//            }
//        }
//        
//    } else {
//        for (LZShopModel *shop in self.dataArray) {
//            shop.select = NO;
//        }
//    }
//    
//    [self.myTableView reloadData];
//    [self countPrice];
}
#pragma mark --- 确认选择,提交订单按钮点击事件
- (void)goToPayButtonClick:(UIButton*)button {
//    if (self.selectedArray.count > 0) {
//        for (LZGoodsModel *model in self.selectedArray) {
//            NSLog(@"选择的商品>>%@>>>%ld",model,(long)model.count);
//        }
//    } else {
//        NSLog(@"你还没有选择任何商品");
//    }
    
    OrderDetailViewController *vc = [OrderDetailViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 初始化数组
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataArray;
}

- (NSMutableArray *)selectedArray {
    if (_selectedArray == nil) {
        _selectedArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _selectedArray;
}


@end
