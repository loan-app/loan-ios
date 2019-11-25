//
//  FaceViewController.m
//  KeleGuan
//
//  Created by Single_Nobel on 2018/7/18.
//  Copyright © 2018 Single_Nobel. All rights reserved.
//
#import "FaceViewController.h"
#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CarrierEnsureViewController.h"

@interface FaceViewController ()<CameraDelegate>
@property(strong,nonatomic)UIView *photoBackView;
@property(strong,nonatomic)UIView *lineView;
@property(strong,nonatomic)UIImageView *photoImage;
@property(strong,nonatomic)UIImageView *avatarImage;
@property(assign,nonatomic)NSNumber *liveStatus;
@property (nonatomic,strong)AVCaptureSession *session;
@property(strong,nonatomic)UILabel *facelabel;
@end

@implementation FaceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initData];
    // Do any additional setup after loading the view.
    kWeakSelf(self);
    self.BaseNavgationBar.leftClickBack = ^{
        [weakself.navigationController popToRootViewControllerAnimated:YES];
    };
}
-(void)initData{
    kWeakSelf(self);
    [[NetworkUtils sharedInstance]rewordRealNameutilSuccess:^(id response) {
            weakself.liveStatus = response[@"data"][@"liveStatus"];
        if ([weakself.liveStatus intValue] == 1) {
                weakself.photoImage.userInteractionEnabled = NO;
            }
        if (isValidStr(response[@"data"][@"imgFace"])) {
            if ([weakself.liveStatus intValue] == 0) {
                weakself.photoImage.image = kImageName(@"add");
            }else{
                [weakself.photoImage sd_setImageWithURL:kUrlfromStr(response[@"data"][@"imgFace"]) placeholderImage:kImageName(@"add") options:SDWebImageRetryFailed];
            }
        }

    } utilsFail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}
-(void)setupUI{
    [self.view addSubview:self.photoBackView];

}

-(void)clickBackWithBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIView *)photoBackView{
    if (!_photoBackView) {
        _photoBackView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHeight+9, kWidth, kHeight)];
        _photoBackView.backgroundColor = kWhiteColor;
        [_photoBackView addSubview:self.photoImage];
        [_photoBackView addSubview:self.facelabel];
        [_photoBackView addSubview:self.avatarImage];
        [_photoBackView addSubview:self.lineView];
    }
    return _photoBackView;
}
-(UIImageView *)photoImage{
    if (!_photoImage) {
        _photoImage = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth-102)/2, 17, 102, 146)];
        _photoImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickWithphoto:)];
        [_photoImage addGestureRecognizer:tap];
        _photoImage.image =kImageName(@"add");
    }
    return _photoImage;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.photoImage.frame)+20, kWidth, 1)];
        _lineView.backgroundColor = kRGB(245, 245, 245);
    }
    return _lineView;
}
-(UIImageView *)avatarImage{
    if (!_avatarImage) {
        _avatarImage  =[[UIImageView alloc]initWithFrame:CGRectMake((kWidth-102)/2, CGRectGetMaxY(self.photoImage.frame)+40, 102, 146) ];
        _avatarImage.image = kImageName(@"face");
    }
     return _avatarImage;
}
-(UILabel *)facelabel{
    if (!_facelabel) {
        _facelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 12+kNavBarHeight, 80, 21)];
        _facelabel.text = @"人脸识别";
    }
    return _facelabel;
}
-(void)clickWithphoto:(UITapGestureRecognizer *)sender{
    [self selectPhoto];
}
-(void)selectPhoto{
     CameraViewController *cameraVC = [[CameraViewController alloc]init];
     cameraVC.delegate =self;
     [self presentViewController:cameraVC animated:YES completion:nil];
}
-(void)confirmUserImage:(UIImage *)image{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self uploadImag:[UIImage scaleImage:[UIImage fixOrientation:image] toKb:100]];
    });
}
-(void)uploadImag:(UIImage *)image{
    [MBProgressHUD bnt_indeterminateWithMessage:@"人脸识别中" toView:self.view];
    [[NetworkUtils sharedInstance] uploadFaceImgWith:image utilsSuccess:^(id response) {
        if ([BaseTool  responseWithNetworkDealResponse:response]) {
            self.photoImage.image = [UIImage scaleImage:[UIImage fixOrientation:image] toKb:100];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //[self.navigationController popViewControllerAnimated:YES];
                CarrierEnsureViewController *carrierEnsureVC = [CarrierEnsureViewController new];
                [self.navigationController pushViewController:carrierEnsureVC animated:YES];
            });
        }else{
            [MBProgressHUD bnt_showMessage:response[kMessageStr] delay:2];
        }
    } utilsFail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
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
