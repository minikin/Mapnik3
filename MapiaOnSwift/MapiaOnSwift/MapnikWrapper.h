//
//  MapnikWrapper.h
//  MapiaOnSwift
//
//  Created by Sasha Minikin on 5/10/16.
//  Copyright © 2016 Sasha Prokhorenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MapnikWrapper : NSObject

// Mapnik to UIImage

+ (UIImage *)imageWithMapnik:(double)X Y:(double)Y;
//-(id)initWithStyle: (NSURL*)styleFile;

@end
