//
//  PermissionRequestViewController.swift
//  Stalarm
//
//  Created by Andrean Lay on 01/05/21.
//

import UIKit

class PermissionRequestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func allowNotificationTapped(_ sender: UIButton) {
        SceneManager.shared.firstLaunched = true
        NotificationManager.shared.requestNotificationPermission() {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "ToMainSegue", sender: self)
            }
        }
    }
    
}
