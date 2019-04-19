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
@implementation secondprogressView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kRGB(240, 240, 240);
        [self test];
        [self addSubview:self.tableview];
        [self addSubview:self.confirmBtn];

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
    if (orderObj) {
        _orderObj = orderObj;
        if ([orderObj.orderStatus integerValue] ==3) {
            self.titleArr = @[@"待还款",@"最迟还款日",@"距离还款日还剩"];
        }else if ([orderObj.orderStatus integerValue] ==4){
            self.titleArr = @[@"待还款",@"最迟还款日",@"您已逾期"];
        }
        NSString *sday =[NSString stringWithFormat:@"%@", orderObj.shouldRepay];
        NSString *rday =[NSString stringWithFormat:@"%@", orderObj.remainDays];
        NSString *lday =[NSString stringWithFormat:@"%@",orderObj.lastRepayTime];

        if (isValidStr(sday) && isValidStr(rday) && isValidStr(lday)) {
            self.detailArr = @[[NSString stringWithFormat:@"%@", orderObj.shouldRepay],orderObj.lastRepayTime,[NSString stringWithFormat:@"%@", orderObj.remainDays]];
            [self.tableview reloadData];
        }else{
            NSLog(@"======== nil");
        }
    }
}
//-(UIView *)backView{
//    if (!_backView) {
//        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 180)];
//        _backView addSubview:se
//    }
//    return _backView;
//}
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
-(void)test{
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(-1, 220)];//开始点
    
    [path addQuadCurveToPoint:CGPointMake(kWidth+1, 220) controlPoint:CGPointMake(kWidth/2, 220+100)];
    
    path.lineWidth = 2.0;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineCapRound; //终点处理
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.strokeColor = [UIColor clearColor].CGColor;
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOpacity = 0.2;
    layer.shadowOffset = CGSizeMake(0, 5);
    [self.layer addSublayer:layer];
    
}
@end





