//
//  WeakScriptMessageDelegate.h
//  BorrowMoney
//
//  Created by Single_Nobel on 2018/3/14.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, assign) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end
