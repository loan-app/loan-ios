//
//  UrgencyTableViewCell.m
//  BorrowMoney
//
//  Created by Single_Nobel on 2017/3/28.
//  Copyright © 2017年 Single_Nobel. All rights reserved.
//

#import "UrgencyTableViewCell.h"

@interface UrgencyTableViewCell ()
@property (nonatomic, strong) UILabel * leftLabel;
@property (nonatomic, strong) UILabel * lineLabel;
@property (nonatomic, strong) UIImageView * haveToDoImg;
@end

@implementation UrgencyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllSubviews];
        [self setUpAutoLayout];
        [PublicTool addLineWithView:self.contentView beginPoint:CGPointMake(0, BntAltitude(50)) andEndPoint:CGPointMake(kWidth, BntAltitude(50)) lineColor:kLineColor lineHeight:1.0];

    }
    return self;
}

#pragma mark - setUpUI

- (void)setUpAutoLayout {
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(BntLength(16));
        make.top.equalTo(self.contentView).offset(BntAltitude(18));
        make.height.mas_offset(BntAltitude(14));
    }];
    [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(BntLength(-34));
        make.top.equalTo(self.contentView).offset(BntAltitude(18));
        make.height.mas_offset(BntAltitude(14));
    }];
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(BntLength(-34));
        make.top.equalTo(self.contentView).offset(BntAltitude(18));
        make.height.mas_offset(BntAltitude(14));
    }];
    [self.haveToDoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(BntLength(-16));
        make.top.equalTo(self.contentView).offset(BntAltitude(17));
        make.width.offset(BntLength(8));
        make.height.offset(BntAltitude(13));
    }];
}

#pragma mark - addSubView

- (void)addAllSubviews {
    [self.contentView addSubview:self.leftLabel];
    [self.contentView addSubview:self.selectLabel];
    [self.contentView addSubview:self.resultLabel];
    [self.contentView addSubview:self.haveToDoImg];
}


#pragma mark - 懒加载

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [UILabel configWithFont:Font(kFont) TextColor:ksixsixColor background:nil title:@"与本人关系"];
        [_leftLabel sizeToFit];
    }
    return _leftLabel;
}

- (UILabel *)selectLabel {
    if (!_selectLabel) {
        _selectLabel = [UILabel configWithFont:Font(kFont) TextColor:kContactSelectColor background:nil title:@"选择"];
        [_selectLabel sizeToFit];
    }
    return _selectLabel;
}

- (UILabel *)resultLabel {
    if (!_resultLabel) {
        _resultLabel = [UILabel configWithFont:Font(kFont) TextColor:ksixsixColor background:nil title:@""];
        [_resultLabel sizeToFit];
    }
    return _resultLabel;
}

- (UIImageView *)haveToDoImg {
    if (!_haveToDoImg) {
        _haveToDoImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _haveToDoImg.image = kImageName(@"icon-jinru");
    }
    return _haveToDoImg;
}






@end
