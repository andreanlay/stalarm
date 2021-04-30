//
//  RepeatDayButton.swift
//  Stalarm
//
//  Created by Andrean Lay on 30/04/21.
//

import UIKit

class RepeatDayButton: UIButton {

}

extension RepeatDayButton {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
