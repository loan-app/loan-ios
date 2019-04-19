//
//  BaseNetWorkMacros.h
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#ifndef BaseNetWorkMacros_h
#define BaseNetWorkMacros_h

#ifdef DEBUG
//测试环境
#define kHTTPUrl @""
#define kHTTPH5 @""
#define kMoxieApiKey @""
#else
//正式环境
#define kHTTPUrl @""
#define kHTTPH5 @""
#define kMoxieApiKey @""
#endif
#endif /* BaseNetWorkMacros_h */
