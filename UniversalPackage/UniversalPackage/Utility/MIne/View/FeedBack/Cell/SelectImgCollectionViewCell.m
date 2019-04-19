//
//  SelectImgCollectionViewCell.m
//  BorrowMoney
//
//  Created by Single_Nobel on 2017/6/13.
//  Copyright © 2017年 Single_Nobel. All rights reserved.
//

#import "SelectImgCollectionViewCell.h"

@implementation SelectImgCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self addAllSubViews];
        [self setConfigLayoutUpUI];
    }
    return self;
}

#pragma mark - addAllSubviews

- (void)addAllSubViews {
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.deleteBtn];
}

#pragma mark - setUpUI

- (void)setConfigLayoutUpUI {
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_offset(BntLength(60));
        make.height.mas_offset(BntAltitude(60));
    }];
}

#pragma mark - 懒加载

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.clipsToBounds = YES;
    }
    return _imgView;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"ic_delete"] forState:UIControlStateNormal];
        _deleteBtn.frame = CGRectMake(self.frame.size.width - 20, 0, BntLength(20), BntAltitude(20));
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -10);
        _deleteBtn.alpha = 0.6;
    }
    return _deleteBtn;
}




- (void)setAsset:(id)asset {
    _asset = asset;
}

- (void)setRow:(NSInteger)row {
    _row = row;
    _deleteBtn.tag = row;
}

@end
