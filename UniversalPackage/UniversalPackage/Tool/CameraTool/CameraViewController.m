//
//  CameraViewController.m
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/7/26.
//  Copyright © 2018 Single_Nobel. All rights reserved.
//
#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface CameraViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property(nonatomic)AVCaptureDevice *device;
//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property(nonatomic)AVCaptureDeviceInput *input;
//当启动摄像头开始捕获输入
@property(nonatomic)AVCaptureMetadataOutput *output;
@property (nonatomic)AVCaptureStillImageOutput *ImageOutPut;
//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property(nonatomic)AVCaptureSession *session;
//图像预览层，实时显示捕获的图像
@property(nonatomic)AVCaptureVideoPreviewLayer *previewLayer;

@property (strong,nonatomic)UIView *headToolView;
@property (strong,nonatomic)UIView *footTaooView;
@property (strong,nonatomic)UIButton *PhotoButton;
@property (strong,nonatomic)UIButton *retakeBtn;
@property (strong,nonatomic)UIButton *cancelBtn;
@property (strong,nonatomic)UIButton *confirmbtn;
@property (strong,nonatomic)UIView *focusView;
@property (strong,nonatomic)UIImageView *imageView;
@property (nonatomic)UIImage *image;

@property (nonatomic)BOOL canCa;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _canCa = [self canUserCamear];
    if (_canCa) {
        [self customCamera];
        [self setUpUI];
    }else{
        return;
    }
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //隐藏电池栏
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)setUpUI{
//    [self.view addSubview:self.headToolView];
    [self.view addSubview:self.footTaooView];
    
    _focusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    _focusView.layer.borderWidth = 1.0;
    _focusView.layer.borderColor =[UIColor greenColor].CGColor;
    _focusView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_focusView];
    _focusView.hidden = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(focusGesture:)];
    [self.view addGestureRecognizer:tapGesture];
}
//初始化
- (void)customCamera{
    self.view.backgroundColor = [UIColor whiteColor];
    //使用AVMediaTypeVideo 指明self.device代表视频，默认使用后置摄像头进行初始化 这里初始化前置摄像头
    self.device = [self cameraWithPosition:AVCaptureDevicePositionFront];
    //使用设备初始化输入
    self.input = [[AVCaptureDeviceInput alloc]initWithDevice:self.device error:nil];
    //生成输出对象
    self.output = [[AVCaptureMetadataOutput alloc]init];
    self.ImageOutPut = [[AVCaptureStillImageOutput alloc] init];
    //生成会话，用来结合输入输出
    self.session = [[AVCaptureSession alloc]init];
    if ([self.session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        self.session.sessionPreset = AVCaptureSessionPreset1280x720;
    }
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.ImageOutPut]) {
        [self.session addOutput:self.ImageOutPut];
    }
    //使用self.session，初始化预览层，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    self.previewLayer.frame = CGRectMake(0,0 , kWidth, kWidth*16/9);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    
    //开始启动
    [self.session startRunning];
    if ([_device lockForConfiguration:nil]) {
        if ([_device isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [_device setFlashMode:AVCaptureFlashModeAuto];
        }
        //自动白平衡
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        [_device unlockForConfiguration];
    }
}
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ) return device;
    return nil;
}
#pragma mark - 检查相机权限
- (BOOL)canUserCamear{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请打开相机权限" message:@"设置-隐私-相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alertView.tag = 100;
        [alertView show];
        return NO;
    }
    else{
        return YES;
    }
    return YES;
}
- (void)focusGesture:(UITapGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:gesture.view];
    [self focusAtPoint:point];
}
- (void)focusAtPoint:(CGPoint)point{
    CGSize size = self.view.bounds.size;
    CGPoint focusPoint = CGPointMake( point.y /size.height ,1-point.x/size.width );
    NSError *error;
    if ([self.device lockForConfiguration:&error]) {
        
        if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [self.device setFocusPointOfInterest:focusPoint];
            [self.device setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        
        if ([self.device isExposureModeSupported:AVCaptureExposureModeAutoExpose ]) {
            [self.device setExposurePointOfInterest:focusPoint];
            [self.device setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        
        [self.device unlockForConfiguration];
        _focusView.center = point;
        _focusView.hidden = NO;
        kWeakSelf(self);
        [UIView animateWithDuration:0.3 animations:^{
            weakself.focusView.transform = CGAffineTransformMakeScale(1.25, 1.25);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
               weakself.focusView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                weakself.focusView.hidden = YES;
            }];
        }];
    }
}
#pragma mark - 截取照片
-(void)shutterCamera{
    AVCaptureConnection * videoConnection = [self.ImageOutPut connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        return;
    }
    self.headToolView.hidden = NO;
    self.footTaooView.hidden = YES;
    kWeakSelf(self);
    [self.ImageOutPut captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        self.image = [UIImage imageWithData:imageData];
        [self.session stopRunning];
        self.imageView = [[UIImageView alloc]initWithFrame:self.previewLayer.frame];
        [self.view insertSubview:weakself.imageView belowSubview:weakself .headToolView];
        NSLog(@"image size = %@",NSStringFromCGSize(self.image.size));
         self.imageView.image = self.image;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self confirmUserPhoto];
//            [UIImage imageNamed:<#(nonnull NSString *)#>]
        });
    }];
}
-(void)retakePhoto{
    [self.imageView removeFromSuperview];
    self.headToolView.hidden = YES;
    self.footTaooView.hidden = NO;
    [self.session startRunning];
}
-(void)cancelPhoto{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)confirmUserPhoto{
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmUserImage:)]) {
        [self.delegate confirmUserImage:self.image];
    }
    [self cancelPhoto];
}
-(UIView *)headToolView{
    if (!_headToolView) {
        _headToolView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight-80, kWidth, 80)];
        _headToolView.backgroundColor = [UIColor blackColor];
        _headToolView.hidden =YES;
        [_headToolView addSubview:self.retakeBtn];
        [_headToolView addSubview:self.confirmbtn];

    }
    return _headToolView;
}
-(UIView *)footTaooView{
    if (!_footTaooView) {
        _footTaooView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight-80, kWidth, 80)];
        _footTaooView.backgroundColor = [UIColor blackColor];
 
        [_footTaooView addSubview:self.PhotoButton];
        [_footTaooView addSubview:self.cancelBtn];
    }
    return _footTaooView;
}
-(UIButton *)confirmbtn{
    if (!_confirmbtn) {
        _confirmbtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth-100, 20, 60, 40)];
        [_confirmbtn setTitle:@"使用" forState:UIControlStateNormal];
        [_confirmbtn addTarget:self action:@selector(confirmUserPhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmbtn;
}
-(UIButton *)retakeBtn{
    if (!_retakeBtn) {
        _retakeBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 20, 60, 40)];
        [_retakeBtn setTitle:@"重拍" forState:UIControlStateNormal];
        [_retakeBtn addTarget:self action:@selector(retakePhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retakeBtn;
}
-(UIButton *)PhotoButton{
    if (!_PhotoButton) {
        _PhotoButton = [[UIButton alloc]initWithFrame:CGRectMake((kWidth-60)/2,10 , 60, 60)];
        [_PhotoButton setImage:[UIImage imageNamed:@"photograph"] forState: UIControlStateNormal];
        [_PhotoButton addTarget:self action:@selector(shutterCamera) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PhotoButton;
}
-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 20, 60, 40)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelPhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && alertView.tag == 100) {
        
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }
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
