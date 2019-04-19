
//  WeakScriptMessageDelegate.m
//  BorrowMoney
//
//  Created by Single_Nobel on 2018/3/14.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import "WeakScriptMessageDelegate.h"

@implementation WeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}


@end
