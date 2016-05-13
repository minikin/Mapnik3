//
//  MapiaTileOverlay.swift
//  MapiaOnSwift
//
//  Created by Sasha Minikin on 5/12/16.
//  Copyright © 2016 Sasha Prokhorenko. All rights reserved.
//

import Foundation
import MapKit

class MapiaTileOverlay: MKTileOverlay {
  
  let session: NSURLSession = {
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    return NSURLSession(configuration: config)
  }()
  
  let earthRadius = 6378137.0
//  let cache = NSCache()
  let mapnik = MapnikTileOverlay.sharedMapnikTileOverlay()
  var queue = NSOperationQueue()
  
  override func loadTileAtPath(path: MKTileOverlayPath, result: (NSData?, NSError?) -> Void) {
    
//    let earthDiameter = earthRadius * M_PI
//    let earthCircumference = earthDiameter * M_PI
//    let maxRes = earthCircumference / 256
//    let originShift = earthCircumference / 2
//    
//    let total = 1 << path.z
//    let resolution = maxRes / Double(total)
    
//    let minx = Double((path.x * 256)) * resolution - originShift
//    let miny = Double(-((path.y) * 256)) * resolution + originShift
//    let maxx = Double(((path.x) * 256)) * resolution - originShift
//    let maxy = -(Double((path.y * 256)) * resolution - originShift)
    
//    let image = UIImage(named:"earth")
//    let imageData = UIImagePNGRepresentation(image!)

    queue = NSOperationQueue()
    queue.addOperationWithBlock { () -> Void in
      
      let imageData = self.mapnik.renderTileForPath(path)
      
      NSOperationQueue.mainQueue().addOperationWithBlock({
        result(imageData, nil)
      })
    
    }
  }
  
  
  // MARK: - Helpers
  
//  - (double) y2lat_m:(double) y {
//  return rad2deg(2 * atan(exp( (y / earth_radius ) )) - M_PI/2);
//  }
//  
//  - (double) x2lon_m:(double) x {
//  return rad2deg(x / earth_radius);
//  }
//
// NSLog(@"Tile - %f, %f, %f, %f", [self x2lon_m: minx], [self y2lat_m: miny], [self x2lon_m: maxx], [self y2lat_m: maxy]);
//  override func URLForTilePath(path: MKTileOverlayPath) -> NSURL {
//    return NSURL(string: String(format: "http://mt0.google.com/vt/x={x}&y={y}&z={z}", path.z, path.x, path.y))!
//  }
  
//  override func loadTileAtPath(path: MKTileOverlayPath, result: (NSData?, NSError?) -> Void) {
//    
//    let url = URLForTilePath(path)
//    let request = NSMutableURLRequest(URL: url, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 10.0)
//    request.HTTPMethod = "GET"
//    
//    if let cachedData = cache.objectForKey(url) as? NSData {
//      
//      result(cachedData, nil)
//      
//    } else {
//      
//      let task = session.dataTaskWithRequest(request, completionHandler: {
//        
//        (data, response, error) -> Void in
//        
//        if let data = data {
//          self.cache.setObject(data, forKey: url)
//        }
//        
//        result(data, error)
//        
//      })
//      
//      task.resume()
//    }
//  }
  
}