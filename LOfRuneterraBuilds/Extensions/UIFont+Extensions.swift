//
//  UIFont+Extensions.swift
//  LOfRuneterraBuilds
//
//  Created by Guilherme Tavares Shimamoto on 10/02/20.
//  Copyright © 2020 Júlio John Tavares Ramos. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    /*Returns scaled custom font or system font if invalid font name*/
    static func scaledFont(for fontName: String, size: CGFloat) -> UIFont {
        let customFont = UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
        return UIFontMetrics.default.scaledFont(for: customFont)
    }
}
