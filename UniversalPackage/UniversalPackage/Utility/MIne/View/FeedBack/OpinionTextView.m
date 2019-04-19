//
//  OpinionTextView.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/5/31.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//
#import "OpinionTextView.h"
@interface OpinionTextView ()

@end

@implementation OpinionTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllSubViews];
        [self setUpAutoLayout];
    }
    return self;
}



#pragma mark - setUpUI

- (void)setUpAutoLayout {
    [self.oponionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(BntLength(20));
        make.top.equalTo(self).offset(BntAltitude(13));
        make.right.equalTo(self).offset(BntLength(-20));
        make.height.mas_offset(BntAltitude(200));
    }];
    [self.textNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(BntLength(-20));
        make.bottom.equalTo(self).offset(BntAltitude(-20));
        make.height.mas_offset(BntAltitude(17));
    }];    
}

#pragma mark - addSubViews

- (void)addAllSubViews {
    [self addSubview:self.oponionTextView];
    [self addSubview:self.textNumLabel];
}

#pragma marl - 懒加载

- (LimitTextView *)oponionTextView {
    if (!_oponionTextView) {
        _oponionTextView = [[LimitTextView alloc] init];
        _oponionTextView.font = Font(kFont);
        _oponionTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        _oponionTextView.spellCheckingType = UITextSpellCheckingTypeNo;
        _oponionTextView.placeholder = @"请输入内容...";
        [_oponionTextView sizeToFit];
    }
    return _oponionTextView;
}

- (UILabel *)textNumLabel {
    if (!_textNumLabel) {
        _textNumLabel = [UILabel configWithFont:Font(kFont) TextColor:knineNineColor background:nil title:@"0/200"];
        _textNumLabel.textAlignment = 2;
        [_textNumLabel sizeToFit];
    }
    return _textNumLabel;
}




@end
