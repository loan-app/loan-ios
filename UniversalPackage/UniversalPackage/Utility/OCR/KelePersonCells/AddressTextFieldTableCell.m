//
//  AddressTextFieldTableCell.m
//  BorrowMoney
//
//  Created by Single_Nobel on 2017/8/17.
//  Copyright © 2017年 Single_Nobel. All rights reserved.
//

#import "AddressTextFieldTableCell.h"

@implementation AddressTextFieldTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.addressTestField];
        [self.addressTestField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(BntLength(16));
            make.top.equalTo(self.contentView).offset(BntAltitude(17));
            make.width.offset(BntLength(kWidth - BntLength(32)));
            make.height.offset(BntAltitude(16));
        }];
        [PublicTool addLineWithView:self.contentView beginPoint:CGPointMake(0, BntAltitude(50)) andEndPoint:CGPointMake(kWidth, BntAltitude(50)) lineColor:kLineColor lineHeight:1.0];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (UITextField *)addressTestField {
    if (!_addressTestField) {
        _addressTestField = [[UITextField alloc] initWithFrame:CGRectZero];
        [_addressTestField configAttributedPlaceHolderWithTextField:_addressTestField placeholderColor:fontColor textFont:Font(kFont) attributedString:@"请填写详细地址"];
        _addressTestField.textColor = ksixsixColor;
    }
    return _addressTestField;
}



@end
