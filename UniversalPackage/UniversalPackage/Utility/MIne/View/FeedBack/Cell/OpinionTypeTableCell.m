//
//  OpinionTypeTableCell.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/5/31.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "OpinionTypeTableCell.h"

@interface OpinionTypeTableCell ()
@property (nonatomic, strong) UIButton * identifyProBtn;//认证问题
@property (nonatomic, strong) UIButton * applySubmitBtn;//申请提交
@property (nonatomic, strong) UIButton * reviewBtn;//审核放款
@property (nonatomic, strong) UIButton * feeProBtn;//费用问题
@property (nonatomic, strong) UIButton * paymentProBtn;//还款问题
@property (nonatomic, strong) UIButton * otherProBtn;//其他问题
@property (nonatomic, strong) UIButton * selectedOpinionBtn;

@end

@implementation OpinionTypeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllSubViews];
        [self setUpUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


#pragma mark - setUpUI

- (void)setUpUI {
    [self.identifyProBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(BntLength(20));
        make.top.equalTo(self.contentView).mas_offset(BntAltitude(15));
        make.height.mas_offset(BntAltitude(25));
        make.width.mas_offset(BntLength(100));
    }];
    [self.applySubmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.identifyProBtn.mas_right).mas_offset(BntLength(18));
        make.top.equalTo(self.contentView).mas_offset(BntAltitude(15));
        make.height.mas_offset(BntAltitude(25));
         make.width.equalTo(self.identifyProBtn.mas_width);
    }];
    [self.reviewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.applySubmitBtn.mas_right).mas_offset(BntLength(18));
        make.top.equalTo(self.contentView).mas_offset(BntAltitude(15));
        make.height.mas_offset(BntAltitude(25));
         make.width.equalTo(self.identifyProBtn.mas_width);
    }];
    [self.feeProBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(BntLength(20));
        make.bottom.equalTo(self.contentView).mas_offset(BntAltitude(-15));
        make.height.mas_offset(BntAltitude(25));
         make.width.equalTo(self.identifyProBtn.mas_width);
    }];
    [self.paymentProBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.feeProBtn.mas_right).mas_offset(BntLength(18));
       make.bottom.equalTo(self.contentView).mas_offset(BntAltitude(-15));
        make.height.mas_offset(BntAltitude(25));
        make.width.equalTo(self.identifyProBtn.mas_width);
    }];
    [self.otherProBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.paymentProBtn.mas_right).mas_offset(BntLength(20));
        make.bottom.equalTo(self.contentView).mas_offset(BntAltitude(-15));
        make.height.mas_offset(BntAltitude(25));
        make.width.equalTo(self.identifyProBtn.mas_width);
    }];
    
}


#pragma mark - AllSubViews

- (void)addAllSubViews {
    [self.contentView addSubview:self.identifyProBtn];
    [self.contentView addSubview:self.applySubmitBtn];
    [self.contentView addSubview:self.reviewBtn];
    [self.contentView addSubview:self.feeProBtn];
    [self.contentView addSubview:self.paymentProBtn];
    [self.contentView addSubview:self.otherProBtn];
}


#pragma mark - 懒加载

- (UIButton *)identifyProBtn {
    if (!_identifyProBtn) {
        _identifyProBtn = [UIButton configureOnNormalFont:Font(kFont) titleColor:ksixsixColor backGround:kefefefColor title:@"认证问题" cornerRadius:BntLength(25/2) borderWith:1.0 borderColor:kWhiteColor.CGColor];
        _identifyProBtn.tag = 1006;
        [_identifyProBtn addTarget:self action:@selector(OpinionSelectClickAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _identifyProBtn;
}


- (UIButton *)applySubmitBtn {
    if (!_applySubmitBtn) {
        _applySubmitBtn = [UIButton configureOnNormalFont:Font(kFont) titleColor:ksixsixColor backGround:kefefefColor title:@"申请提交" cornerRadius:BntLength(25/2) borderWith:1.0 borderColor:kWhiteColor.CGColor];
        _applySubmitBtn.tag = 1007;
        [_applySubmitBtn addTarget:self action:@selector(OpinionSelectClickAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _applySubmitBtn;
}

- (UIButton *)reviewBtn {
    if (!_reviewBtn) {
        _reviewBtn =  [UIButton configureOnNormalFont:Font(kFont) titleColor:ksixsixColor backGround:kefefefColor title:@"审核放款" cornerRadius:BntLength(25/2) borderWith:1.0 borderColor:kWhiteColor.CGColor];
        _reviewBtn.tag = 1008;
        [_reviewBtn addTarget:self action:@selector(OpinionSelectClickAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _reviewBtn;
}

- (UIButton *)feeProBtn {
    if (!_feeProBtn) {
        _feeProBtn =  [UIButton configureOnNormalFont:Font(kFont) titleColor:ksixsixColor backGround:kefefefColor title:@"费用问题" cornerRadius:BntLength(25/2) borderWith:1.0 borderColor:kWhiteColor.CGColor];
         _feeProBtn.tag = 1009;
        [_feeProBtn addTarget:self action:@selector(OpinionSelectClickAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _feeProBtn;
}

- (UIButton *)paymentProBtn {
    if (!_paymentProBtn) {
        _paymentProBtn =  [UIButton configureOnNormalFont:Font(kFont) titleColor:ksixsixColor backGround:kefefefColor title:@"还款问题" cornerRadius:BntLength(25/2) borderWith:1.0 borderColor:kWhiteColor.CGColor];
        _paymentProBtn.tag = 1010;
        [_paymentProBtn addTarget:self action:@selector(OpinionSelectClickAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _paymentProBtn;
}

- (UIButton *)otherProBtn {
    if (!_otherProBtn) {
        _otherProBtn =  [UIButton configureOnNormalFont:Font(kFont) titleColor:ksixsixColor backGround:kefefefColor title:@"其他问题" cornerRadius:BntLength(25/2) borderWith:1.0 borderColor:kWhiteColor.CGColor];
        _otherProBtn.tag = 1011;
        [_otherProBtn addTarget:self action:@selector(OpinionSelectClickAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _otherProBtn;
}


- (void)OpinionSelectClickAction:(UIButton *)btn {
    //单选
    if(_selectedOpinionBtn == btn) {
        //上次点击过的按钮，不做处理
        [btn setBackgroundColor:kefefefColor];
        [btn setTitleColor:ksixsixColor forState:UIControlStateNormal];
        
    } else{
        //本次点击的按钮设为红色
        [btn setBackgroundColor:kyellowColor];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        
        //将上次点击过的按钮设为黑色
        [_selectedOpinionBtn setBackgroundColor:kefefefColor];
        [_selectedOpinionBtn setTitleColor:ksixsixColor forState:UIControlStateNormal];
    }
    _selectedOpinionBtn = btn;
    if (self.delegate && [self.delegate respondsToSelector:@selector(opinionTypeWithTag:)]) {
        [self.delegate opinionTypeWithTag:btn.tag - 1000];
    }
}






@end
