//
//  OrderDetailViewController.m
//  CDDStoreDemo
//
//  Created by sam on 2017/9/2.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "AddressCell.h"
#import "ProductCell.h"
#import "PayCell.h"
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *tableHeadView;
@property (weak, nonatomic) IBOutlet UILabel *waitPayLab;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLab;


@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setTableHeaderView:self.tableHeadView];
    
    UINib *adNib = [UINib nibWithNibName:@"AddressCell" bundle:nil];
    [self.tableView registerNib:adNib forCellReuseIdentifier:@"address"];
    
    
    UINib *pNib = [UINib nibWithNibName:@"ProductCell" bundle:nil];
    [self.tableView registerNib:pNib forCellReuseIdentifier:@"product"];
    
    UINib *payNib = [UINib nibWithNibName:@"PayCell" bundle:nil];
    [self.tableView registerNib:payNib forCellReuseIdentifier:@"pay"];
    
}
- (IBAction)cancel:(id)sender {
}
- (IBAction)pay:(id)sender {
}

#pragma mark UITableViewDelegate
#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
    
        return 1;
    }
    else if (section == 1){
        
        return 3;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        AddressCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"address"];
        return cell;
    }
    else if (indexPath.section == 1){
        
        ProductCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"product"];
        return cell;
    }else{
        
        PayCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"pay"];
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 115;
    }else if(indexPath.section == 1){
        return 80;
    }
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *lab = [UILabel new];
    lab.font = [UIFont systemFontOfSize:15];
    lab.textColor = [UIColor darkGrayColor];
    lab.backgroundColor =RGB(239, 239, 239);
    if (section == 1) {
        lab.text = @"  商品列表";
    }else if (section == 2){
        lab.text = @"  支付方式";
    }
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10;
    }else{
        return 40;
    }
}



@end
