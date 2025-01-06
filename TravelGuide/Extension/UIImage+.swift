//
//  UIImage+.swift
//  TravelGuide
//
//  Created by BAE on 1/6/25.
//

import UIKit

extension UIImage {
    static func symbolWithTint(_ name: String, _ color: UIColor) -> UIImage {
        UIImage(systemName: name)?.withTintColor(color, renderingMode: .alwaysOriginal) ?? UIImage()
    }
    
    static func symbolWithTint(_ name: star, _ color: UIColor) -> UIImage {
        UIImage(systemName: name.rawValue)?.withTintColor(color, renderingMode: .alwaysOriginal) ?? UIImage()
    }

    
}

enum star: String {
    case zero = "star"
    case half = "star.leadinghalf.filled"
    case fill = "star.fill"
}
