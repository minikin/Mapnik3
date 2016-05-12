//
//  MapnikTileOverlay.m
//  MapiaOnSwift
//
//  Created by Sasha Minikin on 5/12/16.
//  Copyright © 2016 Sasha Prokhorenko. All rights reserved.
//

#import "MapnikTileOverlay.h"
#include <math.h>

#define degreesToRadians(x)  (x * M_PI / 180)
#define radiansToDegrees(x)  (x * 180 / M_PI)

@implementation MapnikTileOverlay

//-(id)initWithStyle: (NSURL*)styleFile {
//  
//  self = [self init];
//  
//  if (self) {
//    
//    NSError *error;
//    NSString *styleContent = [NSString stringWithContentsOfURL:styleFile encoding:NSUTF8StringEncoding error:&error];
//    self.style = [styleContent stringByReplacingOccurrencesOfString:@"RESOURCE_PATH" withString:[NSBundle mainBundle].resourcePath];
//  }
//  
//  return self;
//  
//}

-(NSData*)renderTileForPath:(MKTileOverlayPath)path {
  
  try {
    
    mapnik::image_rgba8 im(self.tileSize.width, self.tileSize.height);
    
    mapnik::Map m(im.width(),im.height());
    
    NSString *style_path = [[NSBundle mainBundle] pathForResource:@"style" ofType:@"xml"];
    
    NSString *style = [NSString stringWithContentsOfFile:style_path encoding:NSUTF8StringEncoding error:nil];
    style = [style stringByReplacingOccurrencesOfString:@"RESOURCE_PATH" withString:[NSBundle mainBundle].resourcePath];
    
    mapnik::load_map_string(m, std::string(style.UTF8String));
        
    m.zoom_to_box([self convertPathTo2dBox:path]);
    
    mapnik::agg_renderer <mapnik::image_rgba8> ren(m,im);
    ren.apply();
    
    size_t im_size = im.width() * im.height();
    size_t bitsPerComponent = 8;
    size_t bitsPerPixel = 32;
    size_t bytesPerRow = 4 * im.width();
    
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, im.bytes(), im_size, NULL);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    CGImageRef iref = CGImageCreate(im.width(), im.height(),
                                    bitsPerComponent, bitsPerPixel, bytesPerRow,
                                    colorSpaceRef, bitmapInfo, provider,
                                    NULL, YES, renderingIntent);
    
    CGContextRef context = CGBitmapContextCreate(im.bytes(), im.width(), im.height(),
                                                 bitsPerComponent, bytesPerRow, colorSpaceRef, bitmapInfo);
    
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, im.width(), im.height()), iref);
    
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
    
    return  UIImagePNGRepresentation(image);
    
    
  } catch (std::exception const& ex) {
    
    NSLog(@"error: %s",ex.what());
    
    return nil;
  }
  
}


-(mapnik::box2d<double>)convertPathTo2dBox:(MKTileOverlayPath)path{
  
  CLLocationDegrees topLatitude = convertTileYPathToLatitude(path.y, path.z);
  CLLocationDegrees belowLatitude = convertTileYPathToLatitude(path.y + 1, path.z);
  
  CLLocationDegrees westLongitude = convertTileXPathToLongitude(path.x, path.z);
  CLLocationDegrees rightLongitude = convertTileXPathToLongitude(path.x + 1, path.z);
  
  return mapnik::box2d<double>(westLongitude, belowLatitude, rightLongitude, topLatitude);
  
}

static CLLocationDegrees convertTileXPathToLongitude(NSInteger xPath, NSInteger zPath) {
  return (xPath / pow(2.0, zPath) * 360.0 - 180.0);
}

static CLLocationDegrees convertTileYPathToLatitude(NSInteger yPath, NSInteger zPath) {
  return radiansToDegrees(atan(sinh(M_PI - (2.0 * M_PI * yPath) / pow(2.0, zPath))));
}

@end