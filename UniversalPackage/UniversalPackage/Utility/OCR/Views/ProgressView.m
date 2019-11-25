//
//  ProgressView.m
//  UniversalPackage
//
//  Created by cyc on 2019/10/31.
//  Copyright © 2019 Levin. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView ()

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIView *IDPoint;
@property (nonatomic, strong) UILabel *IDTitle;

@property (nonatomic, strong) UIView *contactPoint;
@property (nonatomic, strong) UILabel *contactTitle;

@property (nonatomic, strong) UIView *baseMsgPoint;
@property (nonatomic, strong) UILabel *baseMsgTitle;

@end

@implementation ProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(42);
        make.trailing.mas_equalTo(- 42);
        make.top.mas_equalTo(28);
        make.height.mas_equalTo(6);
    }];
    
    [self addSubview:self.IDPoint];
    [self.IDPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.line.mas_leading);
        make.centerY.mas_equalTo(self.line);
        make.width.height.mas_equalTo(20);
    }];
    [self addSubview:self.IDTitle];
    [self.IDTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.IDPoint);
        make.top.mas_equalTo(self.IDPoint.mas_bottom).with.offset(14);
    }];
    
    [self addSubview:self.contactPoint];
    [self.contactPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.line);
        make.centerY.mas_equalTo(self.line);
        make.width.height.mas_equalTo(12);
    }];
    [self addSubview:self.contactTitle];
    [self.contactTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.IDTitle);
        make.centerX.mas_equalTo(self.contactPoint);
    }];
    
    [self addSubview:self.baseMsgPoint];
    [self.baseMsgPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.line.mas_trailing);
        make.centerY.mas_equalTo(self.line);
        make.width.height.mas_equalTo(12);
    }];
    
    [self addSubview:self.baseMsgTitle];
    [self.baseMsgTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contactTitle);
        make.centerX.mas_equalTo(self.baseMsgPoint);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"#D7D3D3"];
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
}

- (UIView *)line {
    
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }
    return _line;
}

- (UIView *)IDPoint {
    
    if (!_IDPoint) {
        _IDPoint = [UIView new];
        _IDPoint.backgroundColor = [UIColor whiteColor];
        _IDPoint.layer.borderColor = [UIColor colorWithHexString:@"#91D5FF"].CGColor;
        _IDPoint.layer.cornerRadius = 10;
        _IDPoint.layer.borderWidth = 2;
    }
    return _IDPoint;
}

- (UIView *)contactPoint {
    
    if (!_contactPoint) {
        _contactPoint = [UIView new];
        _contactPoint.backgroundColor = [UIColor whiteColor];
        _contactPoint.layer.cornerRadius = 6;
        _contactPoint.layer.borderWidth = 2;
        _contactPoint.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
    }
    return _contactPoint;
}

- (UIView *)baseMsgPoint {
    
    if (!_baseMsgPoint) {
        _baseMsgPoint = [UIView new];
        _baseMsgPoint.backgroundColor = [UIColor whiteColor];
        _baseMsgPoint.layer.cornerRadius = 6;
        _baseMsgPoint.layer.borderWidth = 2;
        _baseMsgPoint.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.1].CGColor;
    }
    return _baseMsgPoint;
}

- (UILabel *)IDTitle {
    
    if (!_IDTitle) {
        _IDTitle = [UILabel new];
        _IDTitle.font = [UIFont systemFontOfSize:14];
        _IDTitle.textColor = [UIColor colorWithWhite:0 alpha:0.65];
        _IDTitle.text = @"身份信息";
    }
    return _IDTitle;
}

- (UILabel *)contactTitle {
    
    if (!_contactTitle) {
        _contactTitle = [UILabel new];
        _contactTitle.font = [UIFont systemFontOfSize:14];
        _contactTitle.textColor = [UIColor colorWithWhite:0 alpha:0.65];
        _contactTitle.text = @"联系人信息";
    }
    return _contactTitle;
}

- (UILabel *)baseMsgTitle {
    
    if (!_baseMsgTitle) {
        _baseMsgTitle = [UILabel new];
        _baseMsgTitle.font = [UIFont systemFontOfSize:14];
        _baseMsgTitle.textColor = [UIColor colorWithWhite:0 alpha:0.65];
        _baseMsgTitle.text = @"基本信息";
    }
    return _baseMsgTitle;
}

- (void)setProgress:(NSInteger)index {
    
    if (index == 2) {
        
        self.contactPoint.layer.cornerRadius = 10;
        self.contactPoint.layer.borderColor = [UIColor colorWithHexString:@"#91D5FF"].CGColor;
        [self.contactPoint updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(20);
        }];
    } else if (index == 3) {
        
        self.contactPoint.layer.cornerRadius = 10;
        self.contactPoint.layer.borderColor = [UIColor colorWithHexString:@"#91D5FF"].CGColor;
        [self.contactPoint updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(20);
        }];
        
        self.baseMsgPoint.layer.cornerRadius = 10;
        self.baseMsgPoint.layer.borderColor = [UIColor colorWithHexString:@"#91D5FF"].CGColor;
        [self.baseMsgPoint updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(20);
        }];
    }
}

@end
