//
//  BaseAlertViewController.h
//  RabbitConyYok
//
//  Created by SingleNobel on 2018/6/19.
//  Copyright © 2018年 SingleNobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseAlertAction : NSObject

@property (nonatomic, readonly) NSString *title;

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(BaseAlertAction *action))handler;

@end


@interface BaseAlertViewController : UIViewController

@property (nonatomic, readonly) NSArray<BaseAlertAction *> *actions;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSTextAlignment messageAlignment;

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message;
- (void)addAction:(BaseAlertAction *)action;

@end
