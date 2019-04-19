//
//  NSDictionary+NotNil.h
// RabbitConyYok
//
//  Created by Single_Nobel on 2018/8/7.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//
#import "NSDictionary+NotNil.h"

@implementation NSDictionary (NotNil)

- (id)objectForKeyNotNull:(id)aKey
{
    id object = [self objectForKey:aKey];
    if (object) {
        if ([object isKindOfClass:[NSNull class]])
        {
            return nil;
        }
        else if ([object isKindOfClass:[NSNumber class]])
        {
            return [object stringValue];
        }
        else
        {
            return object;
        }
    }
    else
    {
        return nil;
    }
}

- (id)objectForKeyDefaultEmpty:(id)aKey
{
    id object = [self objectForKey:aKey];
    if (object)
    {
        if ([object isKindOfClass:[NSNull class]])
        {
            return @"";
        }
        else if ([object isKindOfClass:[NSNumber class]])
        {
            NSString *string = [object stringValue];
            if([[string lowercaseString] isEqualToString:@"true"])
            {
                string = @"1";
            }
            else if([[string lowercaseString] isEqualToString:@"false"])
            {
                string = @"0";
            }
            else if([[string lowercaseString] isEqualToString:@"yes"])
            {
                string = @"1";
            }
            else if([[string lowercaseString] isEqualToString:@"no"])
            {
                string = @"0";
            }
            
            return string;
        }
        else
        {
            return object;
        }
    }
    else
    {
        return @"";
    }
}

@end


@implementation NSMutableDictionary (NotNil)

- (void)setObjectNotNil:(id)anObject forKey:(id)aKey
{
    if(anObject != nil)
    {
        [self setObject:anObject forKey:aKey];
    }
}

@end
