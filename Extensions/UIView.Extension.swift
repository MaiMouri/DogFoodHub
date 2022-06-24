//
//  UIView.Extension.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/13.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
