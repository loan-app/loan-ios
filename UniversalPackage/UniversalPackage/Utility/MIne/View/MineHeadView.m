//
//  MineHeadView.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "MineHeadView.h"

@implementation MineHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = k595Color;
        [self addSubview:self.headImgView];
        [self addSubview:self.phoneLab];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headClick:)];
        [self addGestureRecognizer:tap];
        [self setUpConstraints];
    }
    return self;
}
-(void)headClick:(UITapGestureRecognizer *)sender{
    if (self.hdelegate && [self.hdelegate respondsToSelector:@selector(clickWithHeadView:)]) {
        [self.hdelegate clickWithHeadView:sender];
    }
}
-(void)setUpConstraints{
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.width.height.mas_equalTo(70);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
    }];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImgView.mas_right).offset(16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(200);
        make.bottom.equalTo(self.mas_bottom).offset(-46);
    }];
}
-(UIImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc]init];
        _headImgView.image = kImageName(@"avatar");
    }
    return _headImgView;
}
-(UILabel *)phoneLab{
    if (!_phoneLab) {
        _phoneLab = [[UILabel alloc]init];
        _phoneLab.textAlignment = NSTextAlignmentLeft;
        _phoneLab.font = Font(20);
        _phoneLab.text = @"点击登录";
    }
    return _phoneLab;
}

@end
