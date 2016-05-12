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
  
  let earthRadius = 6378137.0

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
    
    
    let image = UIImage(named:"")
    let imageData = UIImagePNGRepresentation(image!)
    
    result(imageData, nil)
    
  }
  
  // MARK: - Helper methods
  
  
  
  
  
}