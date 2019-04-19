//
//  FooterBankView.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/6/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "FooterBankView.h"

@interface FooterBankView ()
@property (nonatomic, strong) UIImageView * bankLeftImg;
@property (nonatomic, strong) UILabel     * bankRightLabel;
@end

@implementation FooterBankView


- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self addAllSubViews];
        [self configWithUI];
    }
    return self;
}


- (void)addAllSubViews {
    [self addSubview:self.bankLeftImg];
    [self addSubview:self.bankRightLabel];
}


- (void)configWithUI {
    [self.bankLeftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(BntLength(134));
        make.top.equalTo(self).offset(BntAltitude(56));
        make.width.offset(BntLength(14));
        make.height.offset(BntAltitude(16));
    }];
    [self.bankRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankLeftImg.mas_right).offset(BntLength(8));
        make.top.equalTo(self).offset(BntAltitude(58));
        make.height.offset(BntAltitude(12));
    }];
}




- (UIImageView *)bankLeftImg {
    if (!_bankLeftImg) {
        _bankLeftImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bankLeftImg.image = kImageName(@"ic_safe");
    }
    return _bankLeftImg;
}


- (UILabel *)bankRightLabel {
    if (!_bankRightLabel) {
        _bankRightLabel = [UILabel configWithFont:Font(12) TextColor:knineNineColor background:nil title:@"银行级数据加密"];
        [_bankRightLabel sizeToFit];
    }
    return _bankRightLabel;
}







@end
