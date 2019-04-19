//
//  NoInputAccessoryView.h
//  BorrowMoney
//
//  Created by Single_Nobel on 2017/4/17.
//  Copyright © 2017年 Single_Nobel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <WebKit/WebKit.h>

#import <objc/runtime.h>

@interface NoInputAccessoryView : NSObject

+ (void)removeInputAccessoryViewFromWKWebView:(WKWebView *)webView;

@end
