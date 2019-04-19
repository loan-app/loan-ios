//
//  firstCell.m
//  HotLoanYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "firstCell.h"

@implementation firstCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self  =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.singImgView];
        [self addSubview:self.lineView];
        [self addSubview:self.titleLab];
        [self addSubview:self.suptimeLab];
        [self addSubview:self.scripLab];
        [self setConstraints];
        
    }
    return self;
}
-(void)setConstraints{
    [self.singImgView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(18);
        make.top.equalTo(0);
        make.width.height.equalTo(10);
    }];
    [self.lineView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(22.5);
        make.top.equalTo(5);
        make.width.equalTo(1);
        make.height.equalTo(75);
    }];
    [self.titleLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(40);
        make.top.equalTo(0);
        make.width.equalTo(120);
        make.height.equalTo(20);
    }];
    [self.suptimeLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.right).offset(-180);
        make.top.equalTo(0);
        make.width.equalTo(160);
        make.height.equalTo(20);
    }];
    [self.scripLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(35);
        make.top.equalTo(self.titleLab.bottom).offset(10);
        make.width.equalTo(kWidth-85);
        make.height.equalTo(50);
    }];
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = Font(kiphoneXfont);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}
-(UILabel *)suptimeLab{
    if (!_suptimeLab) {
        _suptimeLab = [[UILabel alloc]init];
        _suptimeLab.textAlignment =NSTextAlignmentRight;
        _suptimeLab.font = Font(kiphoneXfont);
    }
    return _suptimeLab;
}
-(UILabel *)scripLab {
    if (!_scripLab) {
        _scripLab = [[UILabel alloc]init];
        _scripLab.numberOfLines = 0;
        _scripLab.font = Font(kiphoneXfont);
    }
    return _scripLab;
}
-(UIImageView *)singImgView{
    if (!_singImgView) {
        _singImgView = [[UIImageView alloc]init];
        _singImgView.layer.cornerRadius = 5;
        _singImgView.backgroundColor =kd8d8Color;
    }
    return _singImgView;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor =kd8d8Color;
    }
    return _lineView;
}

-(void)setEventObj:(Event *)eventObj{
    if (eventObj) {
        self.titleLab.text = eventObj.event;
        self.scripLab.text = eventObj.eventDescribe;
        self.suptimeLab.text = eventObj.eventTime;
    }
}
-(void)setLength:(NSInteger)length{
    if (length) {
        _length = length;
    }
}
-(void)setRow:(NSInteger)row{
    if (row) {
        _row =row;
        UIColor *color;
        if (row != _length) {
            self.singImgView.backgroundColor = kd8d8Color;
            self.lineView.hidden = NO;
            color =kC4C4C4Color;
        }else{
            color = k333Color;
            self.singImgView.backgroundColor = k7ED321;
            self.lineView.hidden = YES;
        }
        
        self.titleLab.textColor = color;
        self.suptimeLab.textColor = color;
        self.scripLab.textColor = color;
    }
}

@end
