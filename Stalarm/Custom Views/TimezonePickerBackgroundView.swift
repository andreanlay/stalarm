//
//  TimezonePickerBackgroundView.swift
//  Stalarm
//
//  Created by Andrean Lay on 29/04/21.
//

import UIKit

class TimezonePickerBackgroundView: UIView {

}

extension TimezonePickerBackgroundView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
