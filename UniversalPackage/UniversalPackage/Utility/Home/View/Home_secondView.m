//
//  Home_secondView.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "Home_secondView.h"

@implementation Home_secondView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = kRGB(240, 240, 240);
        [self setUpConstraints];
    }
    return self;
}
-(void)setupUI{
    [self  test];
    [self addSubview:self.topView];
    [self addSubview:self.selectBtn];
}
-(void)setUpConstraints{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.equalTo(self.mas_width);
        make.height.mas_equalTo(self.frame.size.height/2);
        
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.width.height.mas_equalTo(50);
        make.centerX.equalTo(self.mas_centerX);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
        make.centerX.equalTo(self.mas_centerX);

    }];
    [self.suptitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset(20);
        make.width.mas_equalTo(self.frame.size.width - 60);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(40);
    }];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(-20);
        make.centerX.equalTo(self.mas_centerX);
        make.height.width.mas_equalTo(100);
        self->_selectBtn.layer.cornerRadius =50;

    }];
    
}
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.layer.cornerRadius = 5;
        _topView.backgroundColor = kWhiteColor;
        [_topView addSubview:self.imageView];
        [_topView addSubview:self.titleLab];
        [_topView addSubview:self.suptitleLab];
    }
    return _topView;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = kImageName(@"pic_pass");

    }
    return _imageView;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font =Font(17);
        _titleLab.textColor = k333Color;
    }
    return _titleLab;
}
-(UILabel *)suptitleLab{
    if (!_suptitleLab) {
        _suptitleLab = [[UILabel alloc]init];
        _suptitleLab.numberOfLines =0;
        _suptitleLab.font = Font(13);
        _suptitleLab.textColor  =ksixsixColor;
        _suptitleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _suptitleLab;
}
-(UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc]init];
        _selectBtn.backgroundColor = k595Color;
        [_selectBtn setTitle:@"去挑选" forState:UIControlStateNormal];
        [_selectBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
-(void)selectClick{
    if (self.selectBack) {
        self.selectBack(_orderObj.url);
    }
}

-(void)setOrderObj:(Order *)orderObj{
    if (orderObj) {
        _orderObj = orderObj;
//        NSArray *arr = [CeserJsonParser parseArray:orderObj.loanBeforeList usingModel:[Event class]];
                NSArray *arr = [NSArray yy_modelArrayWithClass:[Event class] json:orderObj.loanBeforeList];
        
        Event *eventObj =  arr[1];
        self.titleLab.text = eventObj.event;
        self.suptitleLab.text = eventObj.eventDescribe;
    }
}

-(void)test{
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(-1, self.frame.size.height/2-1)];//开始点
    
    [path addQuadCurveToPoint:CGPointMake(kWidth+1, self.frame.size.height/2-1) controlPoint:CGPointMake(kWidth/2, self.frame.size.height/2-1+100)];
    
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
@end






