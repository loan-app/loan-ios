//
//  PersonMessageTableCell.m
//  BorrowMoney
//
//  Created by Single_Nobel on 2017/8/16.
//  Copyright © 2017年 Single_Nobel. All rights reserved.
//

#import "PersonMessageTableCell.h"

@interface PersonMessageTableCell ()
@property (nonatomic, strong) UIImageView * arrowsImg;
@end

@implementation PersonMessageTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllSubViews];
        [self setUpMyLayout];
        [PublicTool addLineWithView:self.contentView beginPoint:CGPointMake(0, BntAltitude(50)) andEndPoint:CGPointMake(kWidth, BntAltitude(50)) lineColor:kLineColor lineHeight:1.0];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - addAllSubViews

- (void)addAllSubViews {
    [self.contentView addSubview:self.leftPersonLabel];
    [self.contentView addSubview:self.resultLabel];
    [self.contentView addSubview:self.arrowsImg];
}

#pragma mark - Layout

- (void)setUpMyLayout {
    [self.leftPersonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(BntLength(16));
        make.top.equalTo(self.contentView).offset(BntAltitude(18));
        make.height.offset(BntAltitude(14));
    }];
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(BntLength(-34));
        make.top.equalTo(self).offset(BntAltitude(17));
        make.height.offset(BntAltitude(14));
    }];
    [self.arrowsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(BntLength(-16));
        make.top.equalTo(self.contentView).offset(BntAltitude(17));
        make.width.offset(BntLength(8));
        make.height.offset(BntAltitude(13));
    }];
}


#pragma mark -  懒加载

- (UILabel *)leftPersonLabel {
    if (!_leftPersonLabel) {
        _leftPersonLabel = [UILabel configWithFont:Font(kFont) TextColor:ksixsixColor background:nil title:@""];
        [_leftPersonLabel sizeToFit];
    }
    return _leftPersonLabel;
}

- (UILabel *)resultLabel {
    if (!_resultLabel) {
        _resultLabel = [UILabel configWithFont:Font(kFont) TextColor:ksixsixColor background:nil title:@""];
        [_resultLabel sizeToFit];
    }
    return _resultLabel;
}


- (UIImageView *)arrowsImg {
    if (!_arrowsImg) {
        _arrowsImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _arrowsImg.image = kImageName(@"icon-jinru");
    }
    return _arrowsImg;
}







@end
