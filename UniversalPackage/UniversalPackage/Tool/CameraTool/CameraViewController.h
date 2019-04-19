//
//  CameraViewController.h
//  RabbitConyYok
//
//  Created by Single_Nobel on 2018/7/26.
//  Copyright © 2018 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CameraDelegate<NSObject>
-(void)confirmUserImage:(UIImage *)image;
@end
@interface CameraViewController : UIViewController
@property(assign,nonatomic)id<CameraDelegate>delegate;
@end
