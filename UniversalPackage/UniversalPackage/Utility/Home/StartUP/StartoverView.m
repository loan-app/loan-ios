//
//  StartoverView.m
//  KeleGuan
//
//  Created by Single_Nobel on 2018/7/19.
//  Copyright © 2018 Single_Nobel. All rights reserved.
//

#import "StartoverView.h"
@interface StartoverView()
@property(copy,nonatomic)void(^callback)(void);
@end
static StartoverView *starTool = nil;
static CGFloat WIDTH;
@implementation StartoverView
+(StartoverView *)sharInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        starTool = [[self alloc]init];
    });
    return starTool;
}
-(instancetype)init{
    if (self = [super init]) {
        [kWindow addSubview:self.backView];
        [self judgeUrlstr];
    }
    return self;
}
-(void)judgeUrlstr{
    if ( [[KeleDeviceInfoTool getDeviceNetWorkingStatus] isEqualToString:@"No Network"]){
        [kuserdefaults removeObjectForKey:@"imgurl"];
        [self.backView removeFromSuperview];
    }else{
        NSString *urlstr = [kuserdefaults objectForKey:@"imgurl"];
        _JumpurlStr = [kuserdefaults objectForKey:@"url"];
        [kuserdefaults removeObjectForKey:@"imgurl"];
        if (isValidStr(urlstr)) {
            [self reactFrameWithUrl:urlstr];
        }else{
            [self.backView removeFromSuperview];
        }
    }
    
}
-(void)reactFrameWithUrl:(NSString *)urlstr{
    CGFloat   width =  [UIImage getImageSizeWithURL:kUrlfromStr(urlstr)].width;
    CGFloat   height = [UIImage getImageSizeWithURL:kUrlfromStr(urlstr)].height;
    WIDTH = iPhone4s || iPhone5s ? 200 : 300;
    if (width>=WIDTH) {
        CGFloat newHeight =  WIDTH*height/width;
        [self.contentImageView setFrame:CGRectMake((kWidth-WIDTH)/2, (kHeight-newHeight)/2, WIDTH, newHeight)];
    }else{
        [self.contentImageView setFrame:CGRectMake((kWidth-width)/2, (kHeight-height)/2, width, height)];
    }
    CGFloat closeheight = iPhone4s || iPhone5s ? 55 :65;
    [self.closeImageView setFrame:CGRectMake(CGRectGetMaxX(self.contentImageView.frame)-30, CGRectGetMaxY(self.contentImageView.frame)-closeheight-self.contentImageView.frame.size.height, 30, 67)];
    self.contentImageView.layer.masksToBounds  =YES;
    [self.contentImageView sd_setImageWithURL:kUrlfromStr(urlstr) placeholderImage:kImageName(@"1") options:SDWebImageRetryFailed];
}
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        _backView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.6];
        [_backView addSubview:self.closeImageView];
        [_backView addSubview:self.contentImageView];
    }
    return _backView;
}
-(UIImageView *)closeImageView{
    if (!_closeImageView) {
        _closeImageView = [[UIImageView alloc]init];
        _closeImageView.userInteractionEnabled = YES;
        _closeImageView.image = kImageName(@"pop_ic_close");
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closePopView)];
        [_closeImageView addGestureRecognizer:tap];
    }
    return _closeImageView;
}
-(UIImageView *)contentImageView{
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc]init];
        _contentImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *clickTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpTowebView)];
        [_contentImageView addGestureRecognizer:clickTap];
    }
    return _contentImageView;
}
-(void)jumpTowebView{
    if (isValidStr(_JumpurlStr)) {
        [self.backView removeFromSuperview];
        KeleWebToolViewController *webVC = [[KeleWebToolViewController alloc]init];
        webVC.loadUrlString = _JumpurlStr;
        [[kAppDelegate getCurrentUIVC].navigationController pushViewController:webVC animated:YES];
    }
    
}
-(void)closePopView{
    [self.backView removeFromSuperview];
}
+(void)viewClickManger:(void (^)(void))callback{
    [StartoverView sharInstance].callback = callback;
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:@"popNotification" name:nil object:self];
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
