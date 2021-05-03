//
//  MusicTableVIewController.swift
//  Stalarm
//
//  Created by Andrean Lay on 03/05/21.
//

import UIKit

class MusicCell: UITableViewCell {
    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var checkmarkImage: UIImageView!
}

class MusicTableViewController: UITableViewController {
    var delegate: MusicDataDelegate?
    var selectedMusic = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavBar()
    }
    
    private func setupNavBar() {
        title = "Alarm Sound"
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        cancel.tintColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        done.tintColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
        
        self.navigationItem.leftBarButtonItem = cancel
        self.navigationItem.rightBarButtonItem = done
    }
    
    @objc private func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func doneTapped() {
        AudioManager.shared.player.stop()
        
        self.delegate?.passData(musicName: selectedMusic)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.AlarmSounds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell") as! MusicCell
        
        let musicName = Constants.AlarmSounds[indexPath.row]
        cell.musicName.text = musicName
        if musicName == selectedMusic {
            cell.checkmarkImage.isHidden = false
        } else {
            cell.checkmarkImage.isHidden = true
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMusic = Constants.AlarmSounds[indexPath.row]
        AudioManager.shared.playSoundEffect(for: selectedMusic)
        self.tableView.reloadData()
    }
}
