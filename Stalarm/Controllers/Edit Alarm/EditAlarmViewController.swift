//
//  EditAlarmViewController.swift
//  Stalarm
//
//  Created by Andrean Lay on 04/05/21.
//

import UIKit

class EditAlarmViewController: UIViewController {
    var alarm: Alarm?
    var delegate: EventDataDelegate?
    
    @IBOutlet weak var alarmName: UITextField!
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var repeatDayStack: UIStackView!
    @IBOutlet weak var musicNameField: UITextField!
    @IBOutlet weak var activityDurationLabel: UILabel!
    @IBOutlet weak var activityDurationStepper: UIStepper!
    
    private var repeatDay = [
        ("SUN", false),
        ("MON", false),
        ("TUE", false),
        ("WED", false),
        ("THU", false),
        ("FRI", false),
        ("SAT", false)
    ]
    private var notificationIdentifer: String?
    private var currentActivityDuration: Double?
    private var alarmMusic: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavBar()
        self.setupAlarmData()
    }
    
    private func setupNavBar() {
        title = "Edit Alarm"
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        cancel.tintColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
        let save = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        save.tintColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = cancel
        self.navigationItem.rightBarButtonItem = save
    }
    
    private func setupAlarmData() {
        self.alarmName.text = alarm?.name
        self.alarmDatePicker.date = (alarm?.time)!
        self.musicNameField.text = alarm?.music
        self.alarmMusic = alarm?.music
        
        let activityDuration = Double(alarm!.walkDuration) / 60
        self.activityDurationLabel.text = "\(activityDuration) min"
        activityDurationStepper.value = activityDuration
        self.currentActivityDuration = activityDuration
        
        for day in (alarm?.repeatDay)! {
            let dayTag = Constants.DayToCalendarInt[day]! - 1
            repeatDay[dayTag].1 = true
            
            for view in repeatDayStack.subviews {
                if view.tag == dayTag {
                    view.backgroundColor = #colorLiteral(red: 0.5098039216, green: 0.4470588235, blue: 0.8431372549, alpha: 1)
                    break
                }
            }
        }
    }
    
    @objc private func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveTapped() {
        NotificationManager.shared.cancelNotifications(for: alarm!)
        
        var processedRepeatDay = [String]()
        
        repeatDay.forEach({ data in
            if data.1 {
                processedRepeatDay.append(data.0)
            }
        })
        
        CoreDataManager.shared.editAlarm(alarm: alarm!, name: alarmName.text!, time: alarmDatePicker.date, repeatDay: processedRepeatDay, music: alarmMusic!, walkDuration: Int16(currentActivityDuration! * 60))
        NotificationManager.shared.scheduleRepeatedNotification(title: alarmName.text!, for: processedRepeatDay, on: alarmDatePicker.date, stopDuration: Int16(currentActivityDuration! * 60), musicName: alarmMusic!)
        
        self.delegate?.newDataAdded()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func musicNameTapped(_ sender: UITextField) {
        let storyboard = UIStoryboard(name: "MusicListTable", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MusicListVC") as! MusicTableViewController
        
        vc.delegate = self
        vc.selectedMusic = alarmMusic!
        
        let navController = UINavigationController(rootViewController: vc)
        present(navController, animated: true, completion: nil)
        sender.endEditing(true)
    }
    
    @IBAction func activityDurationChanged(_ sender: UIStepper) {
        currentActivityDuration = sender.value
        activityDurationLabel.text = "\(String(describing: currentActivityDuration)) min"
    }
    
    @IBAction func repeatDayTapped(sender: UIButton) {
        repeatDay[sender.tag].1.toggle()
        
        if repeatDay[sender.tag].1 {
            sender.backgroundColor = #colorLiteral(red: 0.5098039216, green: 0.4470588235, blue: 0.8431372549, alpha: 1)
        } else {
            sender.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
        }
    }
}

extension EditAlarmViewController: MusicDataDelegate {
    func passData(musicName: String) {
        self.alarmMusic = musicName
        self.musicNameField.text = musicName
    }
}
