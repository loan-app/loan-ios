//
//  OpinionTextViewTableCell.m
//  BorrowMoney
//
//  Created by Single_Nobel on 2017/6/15.
//  Copyright © 2017年 Single_Nobel. All rights reserved.
//

#import "OpinionTextViewTableCell.h"

@interface OpinionTextViewTableCell ()<UITextViewDelegate>
@end

@implementation OpinionTextViewTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addAllSubViews];
    }
    return self;
}



- (void)addAllSubViews {
    [self.contentView addSubview:self.opionView];
}

- (OpinionView *)opionView {
    if (!_opionView) {
        _opionView = [[OpinionView alloc] initWithFrame:CGRectMake(0, 0, kWidth, BntAltitude(200))];
    }
    return _opionView;
}



@end
