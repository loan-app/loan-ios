//
//  StarupViewController.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/23.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "StarupViewController.h"
#import "AppDelegate.h"
#import "BaseTabBarViewController.h"
@interface StarupViewController ()
@property(strong,nonatomic)UIButton *enterBtn;
@property(strong,nonatomic)UIImageView *bcImageView;
@property (nonatomic ,strong) NSTimer *timer;    //   定时器
@property(copy,nonatomic)NSString *urlStr;
@property(assign,nonatomic)BOOL isjump;
@property(assign,nonatomic)int timeOut;
@end

@implementation StarupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bcImageView];
    [self.view addSubview:self.enterBtn];
    _isjump = YES;
    [self initData];
    // Do any additional setup after loading the view.
}
-(void)initData{
    kWeakSelf(self);
    [[NetworkUtils sharedInstance]getSatrtImageutilsSuccess:^(id response) {
        if ([BaseTool responseWithNetworkDealResponse:response]) {
            NSString *img = response[@"data"][@"startup"][@"imgurl"];
            weakself.urlStr = response[@"data"][@"startup"][@"url"];
            [kuserdefaults setObject:response[@"data"][@"home"][@"imgurl"] forKey:@"imgurl"];
            [kuserdefaults setObject:response[@"data"][@"home"][@"url"] forKey:@"url"];
            if (isValidStr(img)) {
                [self.bcImageView sd_setImageWithURL:kUrlfromStr(img) placeholderImage:kImageName(@"startup") options:SDWebImageRetryFailed];
            }else{
                NSString *imgName;
                if(iPhoneXSMax){
                    imgName = @"startupxmax";
                }else{
                    imgName  = iPhoneX ? @"startupx" : @"startup";
                }
                weakself.bcImageView.image = kImageName(imgName);
            }
        }
    } utilsFail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}
-(UIImageView *)bcImageView{
    if (!_bcImageView) {
        _bcImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [_bcImageView addGestureRecognizer:tap];
        NSString *imgName;
        if(iPhoneXSMax){
            imgName = @"startupxmax";
        }else{
            imgName  = iPhoneX ? @"startupx" : @"startup";
        }
        _bcImageView.image = kImageName(imgName);
        _bcImageView.userInteractionEnabled = YES;
    }
    return _bcImageView;
}
-(void)tapClick{
    [kuserdefaults setObject:@"start" forKey:@"starup"];
    if (isValidStr(_urlStr)) {
        _isjump = NO;
        KeleWebToolViewController *webVC = [[KeleWebToolViewController alloc]init];
        webVC.loadUrlString =_urlStr;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
-(UIButton *)enterBtn{
    if (!_enterBtn) {
        _enterBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth-70, 50, 55, 28)];
        _enterBtn.backgroundColor = [UIColor grayColor];
        [_enterBtn addTarget:self action:@selector(enterApp:) forControlEvents:UIControlEventTouchUpInside];
        _enterBtn.layer.cornerRadius = 5;
        [self countTimeDown:_enterBtn];
    }
    return _enterBtn;
}
-(void)countTimeDown:(UIButton *)btn{
    btn.titleLabel.font = Font(13);
    
    kWeakSelf(self);
    __block NSInteger second = 3;
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second == 0) {
                if (weakself.isjump) {
                    dispatch_cancel(timer);
                    [((AppDelegate *)[UIApplication sharedApplication].delegate) enterApp];
                }
                dispatch_cancel(timer);
            } else {
                int seconds = second % 4;
                weakself.timeOut = seconds;
                NSString * timeStr = [NSString stringWithFormat:@"跳过 %d",seconds];
                [btn setTitle:[NSString stringWithFormat:@"%@",timeStr] forState:UIControlStateNormal];
                second--;
            }
        });
    });
    dispatch_resume(timer);
    
}
-(void)enterApp:(UIButton *)sender{
    sender.enabled = NO;
    if (_timeOut <=1) {
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [((AppDelegate *)[UIApplication sharedApplication].delegate) enterApp];
        });
    }
    sender.enabled = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
