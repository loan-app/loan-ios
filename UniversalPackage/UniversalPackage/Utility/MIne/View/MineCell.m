//
//  MineCell.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = kWhiteColor;
        [self addSubview:self.titleLab];
        [self addSubview:self.nameLab];
    }
    return self;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
    }
    return _titleLab;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 50, 100, 16)];
        _nameLab.textAlignment  = NSTextAlignmentLeft;
        _nameLab.font = Font(kiphoneXfont);
        _nameLab.textColor = K999Color;
    }
    return _nameLab;
}
-(void)setDataArr:(NSArray *)dataArr{
    if (dataArr) {
        _titleLab.text = dataArr[0];
        _nameLab.text = dataArr[1];
    }
}
@end
