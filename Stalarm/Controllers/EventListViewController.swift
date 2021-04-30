//
//  ClockViewController.swift
//  Stalarm
//
//  Created by Andrean Lay on 28/04/21.
//

import UIKit

protocol EventDataDelegate {
    func newDataAdded()
}

class EventListViewController: MainViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customTabBarController = tabBarController as? MainTabBarController {
            customTabBarController.eventDelegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

extension EventListViewController: EventDataDelegate {
    func newDataAdded() {
        print("New data detected!")
    }
}
