//
//  NSObject+MapnikWrapper.m
//  MapiaOnSwift
//
//  Created by Sasha Minikin on 5/10/16.
//  Copyright © 2016 Sasha Prokhorenko. All rights reserved.
//

#import "MapnikWrapper.h"

@implementation MapnikWrapper

+ (UIImage *)imageWithMapnik:(double)X Y:(double)Y {
  
  try {
    
    // create the map);
    mapnik::Map map(X, Y);
    
    NSLog(@"%f X:", X);
    NSLog(@"%f Y:", Y);
    
    NSString *style_path = [[NSBundle mainBundle] pathForResource:@"style" ofType:@"xml"];
    
    NSString *style = [NSString stringWithContentsOfFile:style_path encoding:NSUTF8StringEncoding error:nil];
    style = [style stringByReplacingOccurrencesOfString:@"RESOURCE_PATH" withString:[NSBundle mainBundle].resourcePath];
    
    mapnik::load_map_string(map, std::string(style.UTF8String));
    
    map.zoom_to_box(mapnik::box2d<double>(mapnik::coord2d(30.5234 -0.1, 50.4501 - 0.1), mapnik::coord2d( 30.5234 +  0.1, 50.4501 + 0.1)));
    
    NSLog(@"%f", map.get_current_extent().miny());
    NSLog(@"%f", map.get_current_extent().minx());
    NSLog(@"%f", map.get_current_extent().maxy());
    NSLog(@"%f", map.get_current_extent().maxx());
    
    mapnik::image_rgba8 buf(map.width(),map.height());
    
    mapnik::agg_renderer <mapnik::image_rgba8> ren(map,buf);
    ren.apply();
    
    // convert mapnik image to UIImage - there must be a better way...
    // https://github.com/PaulSolt/UIImage-Conversion/blob/master/ImageHelper.m
    size_t buf_size = buf.width() * buf.height() * 4;
    size_t bitsPerComponent = 8;
    size_t bitsPerPixel = 32;
    size_t bytesPerRow = 4 * buf.width();
    
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buf.bytes(), buf_size, NULL);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    CGImageRef iref = CGImageCreate(buf.width(), buf.height(),
                                    bitsPerComponent, bitsPerPixel, bytesPerRow,
                                    colorSpaceRef, bitmapInfo, provider,
                                    NULL, YES, renderingIntent);
    
    CGContextRef context = CGBitmapContextCreate(buf.bytes(), buf.width(), buf.height(),
                                                 bitsPerComponent, bytesPerRow, colorSpaceRef, bitmapInfo);
    
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, buf.width(), buf.height()), iref);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    UIImage *image = nil;
    
    if([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
      float scale = [[UIScreen mainScreen] scale];
      image = [UIImage imageWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
    } else {
      image = [UIImage imageWithCGImage:imageRef];
    }
    
    // cleanup
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(iref);
    CGDataProviderRelease(provider);
    
    NSLog(@"resultImg width:%f, height:%f",image.size.width,image.size.height);
    
    return image;
    
  } catch (std::exception const& ex) {
    
    NSLog(@"error: %s",ex.what());
    
    return nil;
  }
  
}

@end
