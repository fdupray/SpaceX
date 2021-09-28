//
//  SectionHeader.swift
//  SpaceX
//
//  Created by Frederick Dupray on 28/09/2021.
//

import Foundation
import SwiftUI

struct SectionHeader: View {
    
    let title: String
    
    var body: some View {
        
        HStack {
            
            Text(title.uppercased())
                .spaceXFont(.subtitle)
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding()
        .background(Color.black.opacity(0.8))
    }
}
