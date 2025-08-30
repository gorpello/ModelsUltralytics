//
//  Created by Gianluca Orpello.
//  Copyright © 2025 Unicorn Donkeys. All rights reserved.
//  


import Foundation

struct DetectedObject: Hashable {
  var label: String
  var confidence: Float
  var boundingBox: CGRect
}
