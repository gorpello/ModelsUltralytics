//
//  Created by Gianluca Orpello.
//  Copyright © 2025 Unicorn Donkeys. All rights reserved.
//

import Foundation

extension CGFloat {
    var roundTwo: String {
        return String(format: "%.2f", self)
    }
}

extension Double {
    var roundTwo: String {
        return String(format: "%.2f", self)
    }
}

extension CGRect {
    func asString() -> String {
        return "origin: (\(self.origin.x.roundTwo), \(self.origin.y.roundTwo))" +
        "size: (\(self.size.width.roundTwo) x \(self.size.height.roundTwo))"
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Int, format: NumberFormatter.Style) {
        let formatter = NumberFormatter()
        formatter.numberStyle = format
        
        if let result = formatter.string(from: value as NSNumber) {
            appendLiteral(result)
        }
    }
}
