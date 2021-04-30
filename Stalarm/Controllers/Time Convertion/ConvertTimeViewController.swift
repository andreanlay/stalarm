//
//  EventListViewController.swift
//  Stalarm
//
//  Created by Andrean Lay on 28/04/21.
//

import UIKit

class ConvertTimeViewController: MainViewController {
    @IBOutlet weak var fromTimezoneField: UITextField!
    @IBOutlet weak var toTimezoneField: UITextField!
    @IBOutlet weak var sourceDatePicker: UIDatePicker!
    @IBOutlet weak var targetDatePicker: UIDatePicker!
    
    private var selectedFromTimezone = "UTC / GMT"
    private var selectedToTimezone = "UTC / GMT"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTimezonePicker()
    }

    private func createPickerView(withTag tag: Int) -> (UIPickerView, UIToolbar) {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.tintColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
        toolbar.sizeToFit()
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(timezonePickerCancelTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(timezonePickerDoneTapped))
        toolbar.setItems([cancel, spacer, done], animated: true)
        
        done.tag = tag
        picker.tag = tag
        
        return (picker, toolbar)
    }
    
    private func setupTimezonePicker() {
        let fromPicker = createPickerView(withTag: 0)
        fromTimezoneField.inputView = fromPicker.0
        fromTimezoneField.inputAccessoryView = fromPicker.1
        
        let toPicker = createPickerView(withTag: 1)
        toTimezoneField.inputView = toPicker.0
        toTimezoneField.inputAccessoryView = toPicker.1

    }
    
    @objc private func timezonePickerCancelTapped() {
        fromTimezoneField.endEditing(true)
    }
    
    @objc private func timezonePickerDoneTapped(sender: UIBarButtonItem) {
        if sender.tag == 0 {
            fromTimezoneField.text = selectedFromTimezone
        } else {
            toTimezoneField.text = selectedToTimezone
        }
        
        fromTimezoneField.endEditing(true)
        toTimezoneField.endEditing(true)
    }
    
    private func convertDateToString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy h:mm a"
        
        return formatter.string(from: date)
    }
    
    @IBAction func convertTapped(_ sender: Any) {
        let initTz = Constants.TimezonesDictionary[selectedFromTimezone]!
        let targetTz = Constants.TimezonesDictionary[selectedToTimezone]!

        var calendar = Calendar.current
        calendar.timeZone = initTz
        let result = calendar.convertTimeZone(to: targetTz, from: sourceDatePicker.date) ?? sourceDatePicker.date
        targetDatePicker.date = result

        let formattedSourceDate = convertDateToString(for: sourceDatePicker.date)
        let formattedTargetDate = convertDateToString(for: targetDatePicker.date)
        CoreDataManager.shared.addConvertionHistory(sourceDate: formattedSourceDate, sourceTZ: selectedFromTimezone, targetTZ: selectedToTimezone, resultDate: formattedTargetDate)
    }
    
    @IBAction func swapTapped(_ sender: UIButton) {
        swap(&fromTimezoneField.text, &toTimezoneField.text)
        swap(&sourceDatePicker.date, &targetDatePicker.date)
        swap(&selectedFromTimezone, &selectedToTimezone)
    }
}

extension ConvertTimeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.Timezones.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.Timezones[row].0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            selectedFromTimezone = Constants.Timezones[row].0
        } else {
            selectedToTimezone = Constants.Timezones[row].0
        }
    }
}
