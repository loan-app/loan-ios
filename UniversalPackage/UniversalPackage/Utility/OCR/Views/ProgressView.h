//
//  ProgressView.h
//  UniversalPackage
//
//  Created by cyc on 2019/10/31.
//  Copyright © 2019 Levin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressView : UIView

//设置第几步
- (void)setProgress:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
