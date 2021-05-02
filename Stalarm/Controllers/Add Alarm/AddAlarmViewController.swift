//
//  AddAlarmViewController.swift
//  Stalarm
//
//  Created by Andrean Lay on 28/04/21.
//

import UIKit

class AddAlarmViewController: UIViewController {
    @IBOutlet weak var alarmNameField: UITextField!
    @IBOutlet weak var alarmTriggerTime: UIDatePicker!
    @IBOutlet weak var walkingMinutesLabel: UILabel!
    
    private var alarmMusic = ""
    private var walkingDuration = 0.5
    private var repeatDay = [
        ("SUN", false),
        ("MON", false),
        ("TUE", false),
        ("WED", false),
        ("THU", false),
        ("FRI", false),
        ("SAT", false)
    ]
    
    var delegate: EventDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Add Alarm"
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        cancel.tintColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
        let save = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        save.tintColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = cancel
        self.navigationItem.rightBarButtonItem = save
    }
    
    @objc private func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveTapped() {
        var processedRepeatDay = [String]()
        
        repeatDay.forEach({ data in
            if data.1 {
                processedRepeatDay.append(data.0)
            }
        })
        
        
        CoreDataManager.shared.addAlarm(name: alarmNameField.text!, time: alarmTriggerTime.date, repeatDay: processedRepeatDay, music: alarmMusic, walkDuration: Int16(walkingDuration * 60))
        
        NotificationManager.shared.scheduleRepeatedNotification(title: alarmNameField.text!, for: processedRepeatDay, on: alarmTriggerTime.date, stopDuration: Int16(walkingDuration * 60))
        
        delegate?.newDataAdded()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func repeatDayTapped(sender: UIButton) {
        repeatDay[sender.tag].1.toggle()
        
        if repeatDay[sender.tag].1 {
            sender.backgroundColor = #colorLiteral(red: 0.5098039216, green: 0.4470588235, blue: 0.8431372549, alpha: 1)
        } else {
            sender.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        }
    }
    
    @IBAction func walkingMinutesChanged(_ sender: UIStepper) {
        walkingDuration = sender.value
        walkingMinutesLabel.text = "\(walkingDuration) min"
    }
}
