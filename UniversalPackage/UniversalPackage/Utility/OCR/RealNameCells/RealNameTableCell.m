//
//  RealNameTableCell.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/6/6.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "RealNameTableCell.h"


@interface RealNameTableCell ()
@property (nonatomic, strong) UILabel * realNameLbl;
@end

@implementation RealNameTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllSubViews];
        [self configureWithUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)addAllSubViews {
    [self.contentView addSubview:self.realNameLbl];
    [self.contentView addSubview:self.frontRealImg];
    [self.contentView addSubview:self.behindRealImg];
}

- (void)configureWithUI {
    [self.realNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(BntLength(20));
        make.top.equalTo(self.contentView).offset(BntAltitude(11));
        make.height.offset(BntAltitude(21));
    }];
    [self.frontRealImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(BntLength(20));
        make.top.equalTo(self.realNameLbl.mas_bottom).offset(BntAltitude(22));
        make.width.offset((kWidth - BntLength(45))/2);
        make.height.offset(BntAltitude(112));
    }];
    [self.behindRealImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.frontRealImg.mas_right).offset(BntLength(15));
        make.top.equalTo(self.realNameLbl.mas_bottom).offset(BntAltitude(22));
        make.width.offset((kWidth - BntLength(45))/2);
        make.height.offset(BntAltitude(112));
    }];
}

- (UILabel *)realNameLbl {
    if (!_realNameLbl) {
        _realNameLbl = [UILabel configWithFont:Font(kFont) TextColor:kblackColor background:nil title:@"身份证识别"];
        [_realNameLbl sizeToFit];
    }
    return _realNameLbl;
}


- (UIImageView *)frontRealImg {
    if (!_frontRealImg) {
        _frontRealImg = [[UIImageView alloc] init];
        _frontRealImg.image = kImageName(@"frontIdenty");
        _frontRealImg.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(frontRealName)];
        [_frontRealImg addGestureRecognizer:tap];
    }
    return _frontRealImg;
}

- (UIImageView *)behindRealImg {
    if (!_behindRealImg) {
        _behindRealImg = [[UIImageView alloc] initWithFrame:CGRectZero];
        _behindRealImg.image = kImageName(@"identify");
        _behindRealImg.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(idcardOCROnbehindImg)];
        [_behindRealImg addGestureRecognizer:tap];
    }
    return _behindRealImg;
}

- (void)frontRealName {
    if (self.delegate && [self.delegate respondsToSelector:@selector(idcardOCROnlineFront)]) {
        [self.delegate idcardOCROnlineFront];
    }
}

- (void)idcardOCROnbehindImg {
    if (self.delegate && [self.delegate respondsToSelector:@selector(idcardOCROnlineBack)]) {
        [self.delegate idcardOCROnlineBack];
    }
}

-(BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}









@end
