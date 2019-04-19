//
//  NSDictionary+NotNil.h
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NotNil)

- (id)objectForKeyNotNull:(id)aKey;

- (id)objectForKeyDefaultEmpty:(id)aKey;

@end


@interface NSMutableDictionary (NotNil)

- (void)setObjectNotNil:(id)anObject forKey:(id)aKey;

@end
