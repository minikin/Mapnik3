//
//  MapnikTileOverlay.h
//  MapiaOnSwift
//
//  Created by Sasha Minikin on 5/12/16.
//  Copyright © 2016 Sasha Prokhorenko. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapnikTileOverlay: MKTileOverlay

@property (strong, nonatomic) NSString *style;

//-(id)initWithStyle: (NSURL*)styleFile;
-(NSData*)renderTileForPath:(MKTileOverlayPath)path;

@end
