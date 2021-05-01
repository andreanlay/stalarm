//
//  AlarmTableViewCell.swift
//  Stalarm
//
//  Created by Andrean Lay on 01/05/21.
//

import UIKit

class AlarmCell: UITableViewCell {
    @IBOutlet weak var alarmNameLabel: UILabel!
    @IBOutlet weak var alarmDetail: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
