//
//  NameTableViewCell.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/6/6.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "NameTableViewCell.h"

@interface NameTableViewCell ()
@end

@implementation NameTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllSubViews];
        [self configureWithUI];
        [PublicTool addLineWithView:self.contentView beginPoint:CGPointMake(0, BntAltitude(60)) andEndPoint:CGPointMake(kWidth, BntAltitude(60)) lineColor:kLineColor lineHeight:1.0f];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(becomeEditor) name:@"editor" object:nil];
    }
    return self;
}
-(void)becomeEditor{
    if ([self.nameLeftLbl.text isEqualToString:@"姓名"]) {
        [self.nameTextField becomeFirstResponder];
    }else{
    }
}

- (void)addAllSubViews {
    [self.contentView addSubview:self.nameLeftLbl];
    [self.contentView addSubview:self.nameTextField];
}

- (void)configureWithUI {
    [self.nameLeftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(BntLength(20));
        make.top.equalTo(self.contentView).offset(BntAltitude(19));
        make.height.offset(BntAltitude(21));
    }];
}


- (UILabel *)nameLeftLbl {
    if (!_nameLeftLbl) {
        _nameLeftLbl = [UILabel configWithFont:Font(kFont) TextColor:kblackColor background:nil title:@""];
        [_nameLeftLbl sizeToFit];
    }
    return _nameLeftLbl;
}


- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(BntLength(130), BntAltitude(18), kWidth - BntLength(150), BntAltitude(22))];
        [_nameTextField configAttributedPlaceHolderWithTextField:_nameTextField placeholderColor:kfour8Color textFont:Font(kFont) attributedString:@""];
        _nameTextField.textAlignment = NSTextAlignmentRight;
    }
    return _nameTextField;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"editor" object:self];

}

@end
