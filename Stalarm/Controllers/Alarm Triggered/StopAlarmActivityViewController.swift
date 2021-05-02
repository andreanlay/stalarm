//
//  StopAlarmActivityViewController.swift
//  Stalarm
//
//  Created by Andrean Lay on 01/05/21.
//

import UIKit

class StopAlarmActivityViewController: UIViewController {
    @IBOutlet weak var walkDurationLabel: UILabel!
    
    var duration: Int16!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupActivityMonitor()
    }
    
    private func setupActivityMonitor() {
        self.walkDurationLabel.text = "Let's walk for \(Double(duration) / 60) mins!"

    }
    
}
