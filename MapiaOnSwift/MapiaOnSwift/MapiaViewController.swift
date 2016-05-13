//
//  MapiaViewController.swift
//  MapiaOnSwift
//
//  Created by Sasha Minikin on 5/12/16.
//  Copyright © 2016 Sasha Prokhorenko. All rights reserved.
//

import UIKit
import MapKit

class MapiaViewController: UIViewController, MKMapViewDelegate {
  
  // MARK: - Properties
  
  @IBOutlet weak var mapView: MKMapView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.delegate = self
    
    reloadTileOverlay()

  }
  
  func reloadTileOverlay() {
    
    let tileOverlay = MapiaTileOverlay(URLTemplate: "http://mt0.google.com/vt/x={x}&y={y}&z={z}")
    tileOverlay.canReplaceMapContent = true
    
    if tileOverlay == true {
      mapView.removeOverlay(tileOverlay)
    }
    
    mapView.addOverlay(tileOverlay)
  }

  
  // MARK: MKMapViewDelegate
  
  func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
    
    guard let tileOverlay = overlay as? MKTileOverlay else {
      return MKOverlayRenderer()
    }
    
    return MKTileOverlayRenderer(tileOverlay: tileOverlay)
  }
  
}