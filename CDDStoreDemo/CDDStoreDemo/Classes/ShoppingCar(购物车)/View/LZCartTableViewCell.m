//
//  LZCartTableViewCell.m
//  LZCartViewController
//
//  Created by LQQ on 16/5/18.
//  Copyright © 2016年 LQQ. All rights reserved.
//  https://github.com/LQQZYY/CartDemo
//  http://blog.csdn.net/lqq200912408
//  QQ交流: 302934443

#import "LZCartTableViewCell.h"

//#import "LZCartModel.h"



@interface LZCartTableViewCell ()
{
    LZNumberChangedBlock numberAddBlock;
    LZNumberChangedBlock numberCutBlock;
    LZCellSelectedBlock cellSelectedBlock;
}
//选中按钮
@property (nonatomic,retain) UIButton *selectBtn;
//显示照片
@property (nonatomic,retain) UIImageView *lzImageView;
//商品名
@property (nonatomic,retain) UILabel *nameLabel;
//尺寸
@property (nonatomic,retain) UILabel *sizeLabel;
//时间
@property (nonatomic,retain) UILabel *dateLabel;
//价格
@property (nonatomic,retain) UILabel *priceLabel;
//数量
@property (nonatomic,retain)UILabel *numberLabel;

@end

@implementation LZCartTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupMainView];
    }
    return self;
}
#pragma mark - public method

- (void)numberAddWithBlock:(LZNumberChangedBlock)block {
    numberAddBlock = block;
}

- (void)numberCutWithBlock:(LZNumberChangedBlock)block {
    numberCutBlock = block;
}

- (void)cellSelectedWithBlock:(LZCellSelectedBlock)block {
    cellSelectedBlock = block;
}

#pragma mark - 按钮点击方法
- (void)selectBtnClick:(UIButton*)button {
    button.selected = !button.selected;
    _item.isSelect = button.selected;
    if (cellSelectedBlock) {
        cellSelectedBlock(button.selected);
    }
}

- (void)addBtnClick:(UIButton*)button {
    
    NSInteger count = [self.numberLabel.text integerValue];
    count++;
    
    if (numberAddBlock) {
        numberAddBlock(count);
    }
}

- (void)cutBtnClick:(UIButton*)button {
    NSInteger count = [self.numberLabel.text integerValue];
    count--;
    if(count < 0){
        return ;
    }

    if (numberCutBlock) {
        numberCutBlock(count);
    }
}
#pragma mark - 布局主视图
-(void)setupMainView {

    //白色背景
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.width.equalTo(self);
        make.bottom.equalTo(self).offset(-20);
    }];
    
    
    //选中按钮
    UIButton* selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setImage:[UIImage imageNamed:@"空心圆"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"选中圆"] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:selectBtn];
    self.selectBtn = selectBtn;
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(bgView).offset(DCMargin);
        make.centerY.mas_equalTo(bgView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(25, 25));
        
    }];

    
    //显示照片
    UIImageView* imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"default_pic_1"];
//    imageView.backgroundColor = [UIColor yellowColor];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:imageView];
    self.lzImageView = imageView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(selectBtn.mas_right).offset( 2 * DCMargin);
        make.centerY.mas_equalTo(bgView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80,80));
        
    }];
    
    
    //价格
    UILabel* priceLabel = [[UILabel alloc]init];
    priceLabel.text = @"20000";
    priceLabel.font = PFR16Font;
    priceLabel.textColor = [UIColor redColor];
    [bgView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(imageView.mas_right).offset( 2 * DCMargin);
        make.bottom.equalTo(imageView);
        make.height.offset(25);
    
        
    }];
    
    //商品名
    UILabel* nameLabel = [[UILabel alloc]init];
    nameLabel.font = PFR16Font;
    [bgView addSubview:nameLabel];
    nameLabel.text = @"111111";
    self.nameLabel = nameLabel;
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(imageView.mas_right).offset( 2 * DCMargin);
        make.right.equalTo(bgView).offset(-DCMargin);
        make.top.equalTo(imageView);
        make.height.offset(25);
        
    }];
    
    
    
    //数量加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    addBtn.frame = CGRectMake(bgView.width - 35, bgView.height - 35, 25, 25);
    [addBtn setImage:[UIImage imageNamed:@"加"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(bgView.mas_right).offset( -2 * DCMargin);
        make.bottom.equalTo(imageView);
        make.size.mas_equalTo(CGSizeMake(30,30));
        
    }];
    
    //数量显示
    UILabel* numberLabel = [[UILabel alloc]init];
//    numberLabel.frame = CGRectMake(addBtn.left - 30, addBtn.top, 30, 25);
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.text = @"1";
    numberLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:numberLabel];
    self.numberLabel = numberLabel;
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(addBtn.mas_left).offset(0);
        make.bottom.equalTo(imageView);
        make.size.mas_equalTo(CGSizeMake(30,30));
        
    }];
    
    //数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    cutBtn.frame = CGRectMake(numberLabel.left - 25, addBtn.top, 25, 25);
    [cutBtn setImage:[UIImage imageNamed:@"减"] forState:UIControlStateNormal];
    [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cutBtn];
    [cutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(numberLabel.mas_left).offset(0);
        make.bottom.equalTo(imageView);
        make.size.mas_equalTo(CGSizeMake(30,30));
        
    }];
}

- (void)setItem:(DCGoodItem *)item{
    
    _item = item;
    _selectBtn.selected = item.isSelect;
    [_lzImageView sd_setImageWithURL:[NSURL URLWithString:item.main_imgs] placeholderImage:nil];
    _nameLabel.text = item.title;
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[item.price floatValue]/100];
    _numberLabel.text = [NSString stringWithFormat:@"%d",item.count];
    
}

@end
