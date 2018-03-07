//
//  UIImage+Extension.m
//  Dlt
//
//  Created by Gavin on 17/5/26.
//  Copyright © 2017年 mr_chen. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

/**
 *  争对ios7以上的系统适配新的图片资源
 *
 *  @param imageName 图片名称
 *
 *  @return 新的图片
 */
+ (UIImage *)imageWithName:(NSString *)imageName
{
  UIImage *newImage = nil;
  BOOL iOS7 = [[UIDevice currentDevice].systemVersion doubleValue] >= 7.0;
  
  if (iOS7) {
    newImage = [UIImage imageNamed:[imageName stringByAppendingString:@"_os7"]];
  }
  if (newImage == nil) {
    newImage = [UIImage imageNamed:imageName];
  }
  return newImage;
  
}
+ (UIImage *)resizableImageWithName:(NSString *)imageName{
  UIImage *image = [UIImage imageNamed:imageName];
  // 获取原有图片的宽高的一半
  CGFloat w = image.size.width * 0.5;
  CGFloat h = image.size.height * 0.5;
  
  // 生成可以拉伸指定位置的图片
  UIImage *newImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
  
  return newImage;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdocumentation"
#pragma clang diagnostic ignored "-Wstrict-prototypes"
/**
 *  实现图片的缩小或者放大
 *
 *  @param image 原图
 *  @param size  大小范围
 *
 *  @return 新的图片
 */
#pragma clang diagnostic pop

-(UIImage *)scaleImageWithSize:(CGSize)size{
  
  UIGraphicsBeginImageContextWithOptions(size,NO,0);  //size 为CGSize类型，即你所需要的图片尺寸
  
  [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
  
  UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  
  UIGraphicsEndImageContext();
  
  return scaledImage;   //返回的就是已经改变的图片
}

- (UIImage *)scaleToScale:(float)scaleSize{ // .等比率缩放
  if (self) {
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width*scaleSize, self.size.height * scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
  }
  
  return nil;
}


@end
