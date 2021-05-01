//
//  TimerTableViewCell.swift
//  Stalarm
//
//  Created by Andrean Lay on 01/05/21.
//

import UIKit

class TimerCell: UITableViewCell {
    @IBOutlet weak var timerCountdownLabel: UILabel!
    @IBOutlet weak var timerNameLabel: UILabel!
    @IBOutlet weak var timerActionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
