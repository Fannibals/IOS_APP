//
//  UIButtonExt.swift
//  GoalPost-app
//
//  Created by Ethan  on 29/1/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit

extension UIButton {
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.06017757207, green: 0.8626639843, blue: 0.1434130967, alpha: 1)
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)
    }
}
