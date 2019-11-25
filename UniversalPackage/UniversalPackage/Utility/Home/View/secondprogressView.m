//
//  secondprogressView.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "secondprogressView.h"
#import "secondCell.h"
static NSString *secondCellId = @"sceondcell";

@interface secondprogressView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIButton *detailButton;

@end

@implementation secondprogressView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(7);
            make.leading.mas_equalTo(15);
        }];
        [self addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(-16);
            make.top.mas_equalTo(5);
        }];
        [self addSubview:self.moneyLabel];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.titleLabel);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(12);
        }];
        [self addSubview:self.detailButton];
        [self.detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.dateLabel);
            make.top.mas_equalTo(self.dateLabel.mas_bottom).with.offset(19);
            make.width.mas_equalTo(131);
            make.height.mas_equalTo(35);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = kRGB(187, 187, 187);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(0);
            make.top.mas_equalTo(self.moneyLabel.mas_bottom).with.offset(35);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}
-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSArray array];
    }
    return _titleArr;
}
-(NSArray *)detailArr{
    if (!_detailArr) {
        _detailArr = [NSArray array];
    }
    return _detailArr;
}
-(void)setOrderObj:(Order *)orderObj{
    NSMutableAttributedString *attStr;
    if (orderObj) {
        _orderObj = orderObj;
        if ([orderObj.orderStatus integerValue] ==3) {
            self.titleArr = @[@"待还款",@"最迟还款日",@"距离还款日还剩"];
            NSString *tempStr = [NSString stringWithFormat:@"距离还款日还剩%@天",orderObj.remainDays];
            attStr = [[NSMutableAttributedString alloc] initWithString:tempStr];
            [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7, [NSString stringWithFormat:@"%@",orderObj.remainDays].length)];
        }else if ([orderObj.orderStatus integerValue] ==4){
            self.titleArr = @[@"待还款",@"最迟还款日",@"您已逾期"];
            NSString *tempStr = [NSString stringWithFormat:@"您已逾期%@天",orderObj.remainDays];
            attStr = [[NSMutableAttributedString alloc] initWithString:tempStr];
            [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4, [NSString stringWithFormat:@"%@",orderObj.remainDays].length)];
        }
        NSString *sday =[NSString stringWithFormat:@"%@", orderObj.shouldRepay];
        NSString *rday =[NSString stringWithFormat:@"%@", orderObj.remainDays];
        NSString *lday =[NSString stringWithFormat:@"%@",orderObj.lastRepayTime];

        if (isValidStr(sday) && isValidStr(rday) && isValidStr(lday)) {
            self.detailArr = @[[NSString stringWithFormat:@"%@", orderObj.shouldRepay],orderObj.lastRepayTime,[NSString stringWithFormat:@"%@", orderObj.remainDays]];
            self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",orderObj.shouldRepay];
            self.dateLabel.attributedText = attStr;
        }else{
            NSLog(@"======== nil");
        }
    }
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 220) style:UITableViewStylePlain];
        _tableview.layer.cornerRadius = 5;
        [_tableview registerClass:[secondCell class] forCellReuseIdentifier:secondCellId];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource  =self;
    }
    return _tableview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    secondCell *cell = [tableView dequeueReusableCellWithIdentifier:secondCellId forIndexPath:indexPath];
    cell.title = self.titleArr[indexPath.row];
    if (_detailArr.count>0) {
        cell.detail = self.detailArr[indexPath.row];
    }
    if ([_orderObj.orderStatus integerValue] ==4 ) {
        if (indexPath.row ==1 ) {
            cell.suptitleLab.textColor = k333Color;
        }else{
            cell.suptitleLab.textColor = [UIColor redColor];
        }
    }
    return cell;
}

-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake((kWidth-100)/2, CGRectGetMaxY(self.tableview.frame)-20, 100, 100)];
        _confirmBtn.layer.cornerRadius = 50;
        [_confirmBtn setTitle:@"立即还款" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = k595Color;
        [_confirmBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
-(void)confirmClick{
    if (self.repayBack) {
        self.repayBack(_orderObj.url);
    }
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textColor = kRGB(16, 16, 16);
        _titleLabel.text = @"本期应还（元）";
    }
    return _titleLabel;
}

- (UILabel *)dateLabel {
    
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont systemFontOfSize:14.f];
        _dateLabel.textColor = kRGB(16, 16, 16);
    }
    return _dateLabel;
}

- (UILabel *)moneyLabel {
    
    if (!_moneyLabel) {
        _moneyLabel = [UILabel new];
        _moneyLabel.font = [UIFont boldSystemFontOfSize:18.f];
        _moneyLabel.textColor = kRGB(16, 16, 16);
    }
    return _moneyLabel;
}

- (UIButton *)detailButton {
    if (!_detailButton) {
        _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailButton setTitle:@"查看详情" forState:normal];
        [_detailButton setTitleColor:kRGB(16, 16, 16) forState:normal];
        _detailButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _detailButton.layer.cornerRadius = 4;
        _detailButton.layer.borderColor = kRGB(187, 187, 187).CGColor;
        _detailButton.layer.borderWidth = 1.f;
        [_detailButton addTarget:self action:@selector(detailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailButton;
}

- (void)detailButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderDetail:)]) {
        [self.delegate orderDetail:self.orderObj];
    }
}

@end





