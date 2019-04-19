//
//  BaseNavgationBar.m
//  ViewDemo
//
//  Created by Single_Nobel on 2018/8/3.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//
#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#import "BaseNavgationBar.h"
#import "UIButton+YokButton.h"
@implementation BaseNavgationBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}
+(instancetype)shareBaseNagationBar{
    BaseNavgationBar *basenavBar = [[BaseNavgationBar alloc]initWithFrame:CGRectMake(0,0,CGRectGetWidth([UIScreen mainScreen].bounds), 44+ CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))];
    NSLog(@"%f",basenavBar.frame.size.height);
    basenavBar.backgroundColor = kWhiteColor;
    return basenavBar;
}
-(void)setupView{
    
    [self.layer addSublayer:self.linelayer];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.titleLabel];
    self.rightBtn.hidden = YES;
}
-(CALayer *)linelayer{
    if (!_linelayer) {
        _linelayer = [CALayer layer];
        _linelayer.frame = CGRectMake(0, self.frame.size.height -1, self.frame.size.width, 1);
        _linelayer.backgroundColor = kF5F5F5Color.CGColor;
    }
    return _linelayer;
}
-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 11+CGRectGetHeight([UIApplication sharedApplication].statusBarFrame), 13, 21)];
        [_leftBtn setEnlargedEdgeWithTop:11 right:10 bottom:12 left:9];
        [_leftBtn setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-60, 11+CGRectGetHeight([UIApplication sharedApplication].statusBarFrame), 47 , 21)];
        [_rightBtn setTitle:@"确认" forState:UIControlStateNormal];
        _rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightBtn setEnlargedEdgeWithTop:11 right:10 bottom:12 left:9];
    }
    return _rightBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds)-240)/2, 11+CGRectGetHeight([UIApplication sharedApplication].statusBarFrame), 240, 20)];
        [_titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(void)setTitle:(NSString *)title{
    if(title){
        self.titleLabel.text =title;
    }
}
-(void)setRightImage:(NSString *)rightImage{
    if (rightImage) {
        [self.rightBtn setTitle:@"" forState:UIControlStateNormal];
        self.NavRightBtnHidden =NO;
        [self.rightBtn setImage:kImageName(rightImage) forState:UIControlStateNormal];
    }
}
-(void)leftBtnClick:(UIButton *)sender{
    if (self.leftClickBack) {
        self.leftClickBack();
    }
}
-(void)rightClick:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickWithRightBtn:)]){
        [self.delegate clickWithRightBtn:sender];
    }
}
-(void)setRbtntitle:(NSString *)Rbtntitle{
    [self.rightBtn setTitle:Rbtntitle forState:UIControlStateNormal];
}
-(void)setNavRightBtnHidden:(BOOL)NavRightBtnHidden{
    self.rightBtn.hidden = NavRightBtnHidden;
}
-(void)setRightBtnEnabled:(BOOL)RightBtnEnabled{
    self.rightBtn.enabled = RightBtnEnabled;
}
-(void)setLineHidden:(BOOL)lineHidden{
    self.linelayer.hidden = lineHidden;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
