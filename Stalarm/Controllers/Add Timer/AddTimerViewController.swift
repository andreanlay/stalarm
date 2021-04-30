//
//  AddTimerViewController.swift
//  Stalarm
//
//  Created by Andrean Lay on 30/04/21.
//

import UIKit

class AddTimerViewController: UIViewController {
    @IBOutlet weak var timerNameField: UITextField!
    @IBOutlet weak var timerMusicField: UITextField!
    @IBOutlet weak var timerDurationPicker: UIPickerView!
    
    var delegate: EventDataDelegate?
    
    private var durationData = [
        "hour": 0,
        "min": 0,
        "sec": 0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timerDurationPicker.delegate = self
        timerDurationPicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Add Timer"
        
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
        let duration = Int32(durationData["hour"]! * 3600 + durationData["min"]! * 60 + durationData["sec"]!)
        CoreDataManager.shared.addTimer(name: timerNameField.text!, duration: duration, music: timerMusicField.text!)
        delegate?.newDataAdded()
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddTimerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if durationData["hour"] == 24 {
            return 1
        }
        
        switch(component){
        case 0:
            return Constants.Hour.count
        case 1:
            return Constants.Minutes.count
        default:
            return Constants.Seconds.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if durationData["hour"] == 24 {
            if component == 1 {
                return "0 min"
            } else if component == 2 {
                return "0 sec"
            }
        }
        
        switch(component){
        case 0:
            return "\(Constants.Hour[row]) hours"
        case 1:
            return "\(Constants.Minutes[row]) min"
        default:
            return "\(Constants.Seconds[row]) sec"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            durationData["hour"] = Constants.Hour[row]
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
        } else if component == 1 {
            durationData["min"] = Constants.Minutes[row]
        } else {
            durationData["sec"] = Constants.Seconds[row]
        }
    }
}
