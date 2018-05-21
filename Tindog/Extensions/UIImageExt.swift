//
//  UIImageExt.swift
//  Tindog
//
//  Created by Carlos Petit on 20-05-18.
//  Copyright © 2018 Carlos Petit. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func rounded(){
        self.layer.cornerRadius = self.bounds.size.height / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
    }
    
}
