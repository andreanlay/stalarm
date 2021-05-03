//
//  StopAlarmActivityViewController.swift
//  Stalarm
//
//  Created by Andrean Lay on 01/05/21.
//

import UIKit

class StopAlarmActivityViewController: UIViewController {
    @IBOutlet weak var walkDurationLabel: UILabel!
    @IBOutlet weak var activityCountdownLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    
    private var activityRecognizer: ActivityRecognizer!
    
    var duration: Int16!
    
    private var timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupActivityMonitor()
    }
    
    private func setupActivityMonitor() {
        let mins = duration / 60
        let secs = duration - mins * 60
        self.walkDurationLabel.text = "Let's walk for \(Double(duration) / 60) mins!"
        self.activityCountdownLabel.text = "\(String(format: "%02d", mins)) : \(String(format: "%02d", secs))"
        
        activityRecognizer = ActivityRecognizer() { doingActivity in
            self.updateDetectedActivity(doingActivity: doingActivity)
        }

    }
    
    private func updateDetectedActivity(doingActivity: Bool) {
        if doingActivity {
            self.activityLabel.text = "Activity detected"
            if !timer.isValid {
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            }
        } else {
            self.activityLabel.text = "No activity detected, get moving!"
            timer.invalidate()
        }
    }
    
    @objc private func updateTime() {
        duration -= 1
        
        let mins = duration / 60
        let secs = duration - mins * 60
        self.activityCountdownLabel.text = "\(String(format: "%02d", mins)) : \(String(format: "%02d", secs))"
        
        if duration == 0 {
            timer.invalidate()
            self.activityRecognizer.activityManager.stopActivityUpdates()
            self.activityLabel.text = "Finished. Have a nice day!"
            
            AudioManager.shared.playSoundEffect(for: "Bell")
            
            finishButton.isHidden = false
        }
    }
    
    @IBAction func finishTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ToMainSegue", sender: self)
    }
}
