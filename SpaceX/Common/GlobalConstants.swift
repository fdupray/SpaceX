//
//  GlobalConstants.swift
//  SpaceX
//
//  Created by Frederick Dupray on 28/09/2021.
//

import Foundation
import SwiftUI

struct SpaceXFont: ViewModifier {
    
    enum TextType {
        case title
        case subtitle
        case body
    }
    
    let textType: TextType
    
    func body(content: Content) -> some View {
        
        switch textType {
        case .title:
            content
                .font(.system(size: 18, weight: .bold, design: .monospaced))
        case .subtitle:
            content
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
        case .body:
            content
                .font(.system(size: 14))
        }
    }
}

extension Text {
    
    func spaceXFont(_ textType: SpaceXFont.TextType) -> some View {
        modifier(SpaceXFont(textType: textType))
    }
}


