//
//  OpinionView.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/5/31.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "OpinionView.h"

@interface OpinionView ()<UITextViewDelegate>
@property (nonatomic, strong) UIButton * sendBtn;

@end

@implementation OpinionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllSubViews];
        [self setUpAutoLayout];
    }
    return self;
}

#pragma mark - 提交

- (void)opinionViewBtnAction:(UIButton *)sender {
    if (_opinionBlock) {
        _opinionBlock();
    }
}




#pragma mark - setUpUI

- (void)setUpAutoLayout {
    [self.yiJianTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(BntLength(0));
        make.top.equalTo(self).offset(BntAltitude(0));
        make.right.equalTo(self).offset(BntAltitude(0));
        make.height.mas_offset(BntAltitude(200));
    }];
}

#pragma mark - addSubViews

- (void)addAllSubViews {
    [self addSubview:self.yiJianTextView];
}

#pragma marl - 懒加载

- (OpinionTextView *)yiJianTextView {
    if (!_yiJianTextView) {
        _yiJianTextView = [[OpinionTextView alloc] init];
        _yiJianTextView.backgroundColor = kWhiteColor;
        _yiJianTextView.oponionTextView.delegate = self;
    }
    return _yiJianTextView;
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([[textView textInputMode] primaryLanguage]==nil||[[[textView textInputMode] primaryLanguage]isEqualToString:@"emoji"]) {
        return NO;
    }
    if([text isEqualToString:@"<"] || [text isEqualToString:@">"]){
        NSString *messageStr = @"不能包含‘<’或‘>’字符";
        [MBProgressHUD bnt_showMessage:messageStr delay:kMubDelayTime];
        return NO;
    }
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange =NSMakeRange(startOffset, endOffset - startOffset);
        if (offsetRange.location < 200) {
            return YES;
        }else{
            return NO;
        }
    }
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = 200 - comcatstr.length;
    if (caninputlen >= 0){
        return YES;
    }else{
        NSInteger len = text.length + caninputlen;
        NSRange rg = {0,MAX(len,0)};
        if (rg.length >0){
            NSString *s =@"";
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];
            }else{
                __block NSInteger idx =0;
                __block NSString  *trimString =@"";
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring,NSRange substringRange,NSRange enclosingRange,BOOL* stop) {
                                          if (idx >= rg.length) {
                                              *stop =YES;
                                              return ;
                                          }
                                          trimString = [trimString stringByAppendingString:substring];
                                          idx++;
                                      }];
                s = trimString;
            }
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
           _yiJianTextView.textNumLabel.text = [NSString stringWithFormat:@"%d/%ld",0,(long)200];
        }
        return NO;
    }
}

#pragma mark -显示当前可输入字数/总字数

- (void)textViewDidChange:(UITextView *)textView{
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    if (selectedRange && pos) {
        return;
    }
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum >200){
        NSString *s = [nsTextContent substringToIndex:200];
        [textView setText:s];
    }
    _yiJianTextView.textNumLabel.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,existTextNum),200];
    if (existTextNum == 0) {
        _sendBtn.backgroundColor = k333Color;
        _sendBtn.userInteractionEnabled = NO;
    }else {
        _sendBtn.backgroundColor = kyellowColor;
        _sendBtn.userInteractionEnabled = YES;
    }
}




@end
