//
//  secondCell.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/20.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "secondCell.h"

@implementation secondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLab];
        [self addSubview:self.suptitleLab];
        self.textLabel.textColor = K999Color;
        [self setUpConstraints];
    }
    return self;
}
-(void)setUpConstraints{
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
        make.left.equalTo(self.mas_left).offset(30);
    }];
    [self.suptitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(self.mas_right).offset(-30);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
        
    }];
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font =Font(14);
        _titleLab.textColor = K999Color;
    }
    return _titleLab;
}
-(UILabel *)suptitleLab{
    if (!_suptitleLab) {
        _suptitleLab = [[UILabel alloc]init];
        _suptitleLab.textAlignment = NSTextAlignmentRight;
        _suptitleLab.font = Font(16);
    }
    return _suptitleLab;
}
-(void)setTitle:(NSString *)title{
    if (title) {
        _title = title;
        self.titleLab.text = title;
    }
}
-(void)setDetail:(NSString *)detail{
    if (detail) {
        self.suptitleLab.text = detail;
    }
}

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context,kRGB(245, 245, 245).CGColor);
    CGContextStrokeRect(context,CGRectMake(16, rect.size.height-1, rect.size.width-32,1));
}
@end
