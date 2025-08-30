//
//  Created by Gianluca Orpello.
//  Copyright © 2025 Unicorn Donkeys. All rights reserved.
//


import SwiftUI

struct ImageDisplayView: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .padding(5.0)
            .border(Color.primary)
            .padding(5.0)
    }
}
