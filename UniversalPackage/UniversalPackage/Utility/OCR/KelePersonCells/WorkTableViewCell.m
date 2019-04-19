//
//  WorkTableViewCell.m
//  BorrowMoney
//
//  Created by Single_Nobel on 2017/8/17.
//  Copyright © 2017年 Single_Nobel. All rights reserved.
//

#import "WorkTableViewCell.h"

@interface WorkTableViewCell ()
@end

@implementation WorkTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.leftWorkabel];
        [self.leftWorkabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).mas_offset(BntLength(16));
            make.top.equalTo(self.contentView).mas_offset(BntAltitude(17));
            make.height.mas_offset(BntAltitude(14));
        }];
        [self.contentView addSubview:self.rightWorkFiled];
        [self.rightWorkFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).mas_offset(BntLength(130));
            make.right.equalTo(self.contentView).mas_offset(BntLength(-16));
            make.top.equalTo(self.contentView).mas_offset(BntAltitude(17));
            make.height.mas_offset(BntAltitude(14));
        }];
        [PublicTool addLineWithView:self.contentView beginPoint:CGPointMake(0, BntAltitude(50)) andEndPoint:CGPointMake(kWidth, BntAltitude(50)) lineColor:kLineColor lineHeight:1.0];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}



- (UITextField *)rightWorkFiled {
    if (!_rightWorkFiled) {
        _rightWorkFiled = [[UITextField alloc] initWithFrame:CGRectZero];
        [_rightWorkFiled configAttributedPlaceHolderWithTextField:_rightWorkFiled placeholderColor:fontColor textFont:Font(kFont) attributedString:@"请填写工作单位"];
        _rightWorkFiled.textColor = ksixsixColor;
        _rightWorkFiled.textAlignment = 2;
    }
    return _rightWorkFiled;
}




- (UILabel *)leftWorkabel {
    if (!_leftWorkabel) {
        _leftWorkabel = [UILabel configWithFont:Font(kFont) TextColor:ksixsixColor background:nil title:@"工作单位"];
        [_leftWorkabel sizeToFit];
    }
    return _leftWorkabel;
}




@end
