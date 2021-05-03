//
//  AlarmTriggeredViewController.swift
//  Stalarm
//
//  Created by Andrean Lay on 01/05/21.
//

import UIKit

class AlarmTriggeredViewController: UIViewController {
    @IBOutlet weak var alarmNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var alarmTitle: String!
    var alarmStopDuration: Int16!
    
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupAlarmView()
    }
    
    private func setupAlarmView() {
        self.alarmNameLabel.text = alarmTitle
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        
        dateLabel.text = formatter.string(from: Date())
        
        formatter.dateFormat = "h:mm:ss a"
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.timeLabel.text = formatter.string(from: Date())
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StopActivitySegue" {
            if let vc = segue.destination as? StopAlarmActivityViewController {
                vc.duration = alarmStopDuration
            }
        }
    }
    
    @IBAction func snoozeTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func stopTapped(_ sender: UIButton) {
        timer.invalidate()
        performSegue(withIdentifier: "StopActivitySegue", sender: self)
    }
    
}
