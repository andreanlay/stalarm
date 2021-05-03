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
    @IBOutlet weak var tableTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var eventTable: UITableView!
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    private var alarmList = [Alarm]()
    private var timerList = [CountdownTimer]()
    private var timerTrigger = [Timer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customTabBarController = tabBarController as? MainTabBarController {
            customTabBarController.eventDelegate = self
        }
        
        self.setupSearchBar()
        self.setupSegmentedControl()
        self.setupInitialTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchData()
    }
    
    private func setupSearchBar() {
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        searchController.searchBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.searchController = searchController
    }
    
    private func setupSegmentedControl() {
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        tableTypeSegmentedControl.setTitleTextAttributes(titleTextAttributes, for:.normal)

        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        tableTypeSegmentedControl.setTitleTextAttributes(titleTextAttributes1, for:.selected)
    }
    
    private func setupInitialTableView() {
        self.eventTable.delegate = self
        self.eventTable.dataSource = self
        
        eventTable.register(UINib(nibName: "AlarmCell", bundle: nil), forCellReuseIdentifier: "AlarmCell")
        
        eventTable.tableFooterView = UIView()
    }
    
    private func fetchData() {
        alarmList = CoreDataManager.shared.fetchAllAlarm()
        
        timerList = CoreDataManager.shared.fetchAllTimer()
        var timers = [Timer]()
        for i in 0..<timerList.count {
            let timer = Timer(timeInterval: 1.0, target: self, selector: #selector((timerFired(timer:))), userInfo: ["tag": i], repeats: true)
            timers.append(timer)
        }
        timerTrigger = timers
        
        eventTable.reloadData()
    }
    
    @IBAction func SegmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            eventTable.register(UINib(nibName: "AlarmCell", bundle: nil), forCellReuseIdentifier: "AlarmCell")
        } else {
            eventTable.register(UINib(nibName: "TimerCell", bundle: nil), forCellReuseIdentifier: "TimerCell")
        }
        
        eventTable.reloadData()
    }
}

extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    private func convertDateToTimeString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        return formatter.string(from: date)
    }
    
    private func simplifyRepeatDay(for repeatDay: [String]) -> String {
        var result = ""
        
        if repeatDay.count == 7 {
            result = "Everyday"
        } else if repeatDay.sorted() == ["MON", "TUE", "WED", "THU", "FRI"].sorted() {
            result = "Weekdays"
        } else {
            for day in repeatDay {
                result.append(" \(day)")
            }
        }
        
        return result
    }
    
    private func convertSecondToNormal(for second: Int32) -> String {
        let hour = second / 3600
        let minutes = (second - hour*3600) / 60
        let seconds = second - (hour * 3600) - (minutes * 60)
        
        var result = ""
        if hour == 0 {
            result = "\(minutes) min \(seconds) sec"
        } else {
            result = "\(hour) hour \(minutes) min \(seconds) sec"
        }
        
        return result
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableTypeSegmentedControl.selectedSegmentIndex == 0 {
            return alarmList.count
        } else {
            return timerList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableTypeSegmentedControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell") as! AlarmCell
            
            let alarm = alarmList[indexPath.row]
            cell.alarmNameLabel.text = alarm.name
            cell.alarmDetail.text = "\(convertDateToTimeString(for: alarm.time!)) - \(simplifyRepeatDay(for: alarm.repeatDay!))"
            cell.alarmSwitch.isOn = alarm.active
            cell.alarmSwitch.addTarget(self, action: #selector(alarmSwitchTapped), for: .valueChanged)
            cell.alarmSwitch.tag = indexPath.row
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimerCell") as! TimerCell
            
            let timer = timerList[indexPath.row]
            cell.timerNameLabel.text = timer.name
            cell.timerCountdownLabel.text = convertSecondToNormal(for: timer.duration)
            cell.timerActionButton.tag = indexPath.row
            cell.timerActionButton.addTarget(self, action: #selector(timerActionTapped), for: .touchUpInside)
            
            if timer.active {
                cell.timerActionButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            } else {
                cell.timerActionButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
            cell.timerActionButton.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            if self.tableTypeSegmentedControl.selectedSegmentIndex == 0 {
                CoreDataManager.shared.deleteAlarm(alarm: self.alarmList[indexPath.row])
            } else {
                CoreDataManager.shared.deleteTimer(timer: self.timerList[indexPath.row])
            }
            self.fetchData()
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    @objc private func timerActionTapped(_ sender: UIButton) {
        let timer = timerList[sender.tag]
        CoreDataManager.shared.setTimerStatus(to: !timer.active, for: timer)
        if timer.active {
            RunLoop.current.add(timerTrigger[sender.tag], forMode: .common)
        } else {
            timerTrigger[sender.tag].invalidate()
            
            let timer = Timer(timeInterval: 1.0, target: self, selector: #selector((timerFired(timer:))), userInfo: ["tag": sender.tag], repeats: true)
            timerTrigger[sender.tag] = timer
        }
        eventTable.reloadData()
    }
    
    @objc private func alarmSwitchTapped(_ sender: UISwitch) {
        let alarm = alarmList[sender.tag]
        CoreDataManager.shared.setAlarmStatus(to: sender.isOn, for: alarm)
        
        if sender.isOn {
            NotificationManager.shared.scheduleRepeatedNotification(title: alarm.name!, for: alarm.repeatDay!, on: alarm.time!, stopDuration: alarm.walkDuration, musicName: alarm.music!)
        } else {
            NotificationManager.shared.cancelNotifications(for: alarm)
        }
    }
    
    @objc private func timerFired(timer: Timer) {
        let index = (timer.userInfo as? [String: Int])!["tag"]!
        timerList[index].duration -= 1
        let indexPath = IndexPath(row: index, section: 0)
        eventTable.reloadRows(at: [indexPath], with: .fade)
        
        if timerList[index].duration == 0 {
            AudioManager.shared.playSoundEffect(for: "Bell")
            timerTrigger[index].invalidate()
        }
    }
}

extension EventListViewController: EventDataDelegate {
    func newDataAdded() {
        self.fetchData()
        eventTable.reloadData()
    }
}
