//
//  TestViewController.swift
//  MapiaOnSwift
//
//  Created by Sasha Minikin on 5/10/16.
//  Copyright © 2016 Sasha Prokhorenko. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      let mapImage = MapnikWrapper.imageWithMapnik(640, y: 1136)
      let imageView = UIImageView(image: mapImage)
      self.view.addSubview(imageView)
      
    }
}
