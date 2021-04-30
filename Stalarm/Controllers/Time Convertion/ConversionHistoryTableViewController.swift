//
//  ConvertionHistoryTableViewController.swift
//  Stalarm
//
//  Created by Andrean Lay on 29/04/21.
//

import UIKit

class ConversionHistoryCell: UITableViewCell {
    @IBOutlet weak var sourceTimeLabel: UILabel!
    @IBOutlet weak var sourceTZ: UILabel!
    @IBOutlet weak var resultTimeLabel: UILabel!
    @IBOutlet weak var resultTZ: UILabel!
}

class ConversionHistoryTableViewController: UITableViewController {
    var histories = [ConversionHistory]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.tableFooterView = UIView()
        self.fetchHistories()
    }
    
    private func fetchHistories() {
        histories = CoreDataManager.shared.fetchAllConversionHistory()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return histories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConvertionHistoryCell") as! ConversionHistoryCell
        
        let history = histories[indexPath.row]
        cell.sourceTimeLabel.text = history.sourceDate
        cell.sourceTZ.text = history.sourceTimeZone
        cell.resultTimeLabel.text = history.resultDate
        cell.resultTZ.text = history.targetTimeZone
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _,_,_ in
            CoreDataManager.shared.deleteConversionHistory(history: self.histories[indexPath.row])
            self.fetchHistories()
            self.tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension ConversionHistoryTableViewController: ConversionDataDelegate {
    func newDataAdded() {
        self.fetchHistories()
        self.tableView.reloadData()
    }
}
