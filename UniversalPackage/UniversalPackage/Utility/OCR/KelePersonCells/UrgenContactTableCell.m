//
//  UrgenContactTableCell.m
//  BorrowMoney
//
//  Created by Single_Nobel on 2017/3/28.
//  Copyright © 2017年 Single_Nobel. All rights reserved.
//

#import "UrgenContactTableCell.h"

@interface UrgenContactTableCell ()
@property (nonatomic, strong) UILabel * urgencyLabel;
@property (nonatomic, strong) UIImageView * urgenContactImg;
@end

@implementation UrgenContactTableCell

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
    [self.urgencyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(BntLength(16));
        make.top.equalTo(self.contentView).offset(BntAltitude(18));
        make.height.mas_offset(BntAltitude(14));
    }];
    [self.personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).mas_offset(BntLength(-34));
        make.top.equalTo(self.contentView).offset(BntAltitude(18));
        make.height.mas_offset(BntAltitude(14));
    }];
    [self.urgenContactImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(BntLength(-16));
        make.top.equalTo(self.contentView).offset(BntAltitude(17));
        make.width.offset(BntLength(8));
        make.height.offset(BntAltitude(13));
    }];
}

#pragma mark - addSubView

- (void)addAllSubviews {
    [self.contentView addSubview:self.urgencyLabel];
    [self.contentView addSubview:self.personLabel];
    [self.contentView addSubview:self.urgenContactImg];
}


#pragma mark - 懒加载

- (UILabel *)urgencyLabel {
    if (!_urgencyLabel) {
        _urgencyLabel = [UILabel configWithFont:Font(kFont) TextColor:ksixsixColor background:nil title:@"联系人"];
        [_urgencyLabel sizeToFit];
    }
    return _urgencyLabel;
}

- (UILabel *)personLabel {
    if (!_personLabel) {
        _personLabel = [UILabel configWithFont:Font(kFont) TextColor:ksixsixColor background:nil title:@""];
        [_personLabel sizeToFit];
    }
    return _personLabel;
}

- (UIImageView *)urgenContactImg {
    if (!_urgenContactImg) {
        _urgenContactImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _urgenContactImg.image = kImageName(@"icon-jinru");
    }
    return _urgenContactImg;
}



@end
