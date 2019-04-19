//
//  BaseUserDefaultMacros.h
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#ifndef BaseUserDefaultMacros_h
#define BaseUserDefaultMacros_h

//必须本地存储
#define kUserDefaultTelNumber @"telNumber"
#define kUserDefaultToken @"token"
#define kUserDefaultUserId @"userId"

//判断登录
#define kisToken [BaseTool isExistToken]
#define kGetMobilePhone [BaseTool getUserMobile]

#define keleManagerTool [BaseTool sharedBaseTool]


#endif /* BaseUserDefaultMacros_h */
