//
//  contactCell.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/23.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "contactCell.h"

@implementation contactCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLab];
        [self addSubview:self.phoneLab];
    }
    return self;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kWidth-40, 20)];
        _titleLab.font = Font(14);
    }
    return _titleLab;
}
-(UILabel *)phoneLab{
    if (!_phoneLab) {
        _phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLab.frame)+5, kWidth-40, 15)];
        _phoneLab.font = Font(12);
   }
    return _phoneLab;
}
-(void)setNumObj:(numModel *)numObj{
    if (numObj) {
        _numObj = numObj;
        _titleLab.text = numObj.n;
        _phoneLab.text = numObj.p;
    }
}
@end
