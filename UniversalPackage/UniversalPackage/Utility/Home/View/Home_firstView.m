//
//  Home_firstView.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/17.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "Home_firstView.h"
static NSString *jumpUrl;
@implementation Home_firstView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = kRGB(240, 240, 240);
        [self setupContraints];

    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.topView];
    [self addSubview:self.confirmBtn];
    [self addSubview:self.buttomLab];
}
-(void)setupContraints{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.equalTo(self.mas_width);
        make.height.mas_equalTo(self.frame.size.height/2);
    }];
    [self.positionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(30);
        make.width.mas_equalTo(kWidth-60);
        make.height.mas_equalTo(20);
    }];
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.positionLab.mas_bottom).offset(12);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(42);
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLab.mas_bottom).offset(20);
        make.height.mas_equalTo(36);
        make.leading.mas_equalTo(22);
        make.trailing.mas_equalTo(-22);
        make.centerX.equalTo(self.mas_centerX);
        self.confirmBtn.layer.cornerRadius = 2;
    }];
    [self.buttomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.confirmBtn.mas_bottom).offset(55);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kWidth);
        make.height.mas_equalTo(12);
    }];
}
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]init];
        //[self test];

        _topView.backgroundColor =kWhiteColor;
        [_topView addSubview:self.positionLab];
        [_topView addSubview:self.moneyLab];
    }
    return _topView;
}
-(UILabel *)positionLab{
    if (!_positionLab) {
        _positionLab = [[UILabel alloc]init];
        _positionLab.font = Font(16);
        //_positionLab.text = @"可借额度(元)";
        _positionLab.text = @"小熊钱包";
        _positionLab.textAlignment = NSTextAlignmentCenter;
    }
    return _positionLab;
}
-(UILabel *)moneyLab{
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc]init];
        _moneyLab.font = Font(28);
        _moneyLab.textColor = [UIColor colorWithHexString:@"#FF9800"];
        _moneyLab.textAlignment = NSTextAlignmentCenter;
        _moneyLab.text = @"200~2w";
    }
    return _moneyLab;
}
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]init];
        [_confirmBtn setTitle:@"立即申请" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.backgroundColor =k595Color;
    }
    return _confirmBtn;
}
-(UILabel *)buttomLab{
    if (!_buttomLab) {
        _buttomLab = [[UILabel alloc]init];
//        _buttomLab.textAlignment = NSTextAlignmentCenter;
//        _buttomLab.text = @"本平台不向学生提供借款服务";
//        _buttomLab.font = Font(12);
//        _buttomLab.textColor = K999Color;
    }
    return _buttomLab;
}
-(void)confirmClick{
    if (self.confirmClickBack) {
        self.confirmClickBack(jumpUrl);
    }
}

-(void)setDataDic:(NSDictionary *)dataDic{
    _positionLab.text = dataDic[@"descTop"];
    _moneyLab.text =  [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"amount"]] ;
    [_confirmBtn setTitle:[dataDic objectForKey:@"descMid"] forState:UIControlStateNormal];
    jumpUrl = [dataDic objectForKey:@"url"];
}

-(void)test{
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(-1, self.frame.size.height/2-1)];//开始点
    
    [path addQuadCurveToPoint:CGPointMake(kWidth+1, self.frame.size.height/2-1) controlPoint:CGPointMake(kWidth/2-1, self.frame.size.height/2+100)];
    
    path.lineWidth = 2.0;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineCapRound; //终点处理
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.path = path.CGPath;
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.strokeColor = [UIColor clearColor].CGColor;
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOpacity = 0.2;
    layer.shadowOffset = CGSizeMake(0, 6);
    [self.layer addSublayer:layer];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
