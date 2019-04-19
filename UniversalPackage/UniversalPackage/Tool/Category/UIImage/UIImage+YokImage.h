//
//  UIImage+YokImage.h
//  CameraDemo
//
//  Created by Single_Nobel on 2018/8/1.
//  Copyright © 2018年 Single_Nobel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YokImage)
/**
 *压缩图片到指定的物理大小
 */
+(UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;
//返回图片数据流
+(NSData *)compressWithImage:(UIImage *)image MaxLength:(NSUInteger)maxLength;
/**
 * 头像图片
 */
+ (UIImage *)circleImageWithname:(NSString *)name borderWidth:(CGFloat)borderWidth
                     borderColor:(UIColor *)borderColor;

+ (UIImage *)imageWithSourceImage:(NSString *)sourceImageName ;
/**
 * 指定图片宽度,自适应图片高度
 */
- (UIImage *)sourceImage:(UIImage *)sourceImage targetWidth:(CGFloat)targetWidth ;
/**
 *  根据图片url获取网络图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL;

/**
 *  图片旋转
 */
+(UIImage *)fixOrientation:(UIImage *)aImage;
@end
