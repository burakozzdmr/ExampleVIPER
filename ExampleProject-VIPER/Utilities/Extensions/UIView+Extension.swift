//
//  UIView+Extension.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 17.07.2026.
//

import UIKit

extension UIView {
    func addViews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
