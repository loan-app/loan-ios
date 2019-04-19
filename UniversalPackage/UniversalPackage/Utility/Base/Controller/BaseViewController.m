//
//  BaseViewController.m
//  ViewDemo
//
//  Created by Single_Nobel on 2018/8/3.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

#import "BaseViewController.h"
#import "UIButton+YokButton.h"
#import "AppDelegate.h"

@interface BaseViewController ()
@end
@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;

    [self setupNavUI];
    // Do any additional setup after loading the view.
}
- (void)clickWithLeftBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickWithRightBtn:(UIButton *)sender {
    
}

-(void)setupNavUI{
    [self.view addSubview:self.BaseNavgationBar];
}
-(UIView *)baseHeadView{
    if (!_baseHeadView) {
        _baseHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth,  kHeight+kNavBarHeight)];
    }
    return _baseHeadView;
}
-(BaseNavgationBar *)BaseNavgationBar{
    @WeakObj(self);
    if(!_BaseNavgationBar){
        _BaseNavgationBar = [BaseNavgationBar shareBaseNagationBar];
        if (self.navigationController.viewControllers.count!=1) {
            self.BaseNavgationBar.leftBtn.hidden =NO;
        }else{
            self.BaseNavgationBar.leftBtn.hidden =YES;
        }
        _BaseNavgationBar.leftClickBack = ^{
            if (selfWeak.navigationController.viewControllers.count>1) {
                NSString *start = [kuserdefaults objectForKey:@"starup"];
                if ([start isEqualToString:@"start"]) {
                    [kuserdefaults removeObjectForKey:@"starup"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [((AppDelegate *)[UIApplication sharedApplication].delegate) enterApp];
                    });
                    
                }else{
                    [selfWeak.navigationController popViewControllerAnimated:YES];
                }
            }
        };
    }
    return _BaseNavgationBar;
}

- (void)creatLineWith:(UIView *)view withFrame:(CGRect )frame{
    UIView *hengXian = [UIView new];
    hengXian.backgroundColor = kRGB(245, 245, 245);
    [view addSubview:hengXian];
    hengXian.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
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
