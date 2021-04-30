//
//  MainTabBarViewController.swift
//  Stalarm
//
//  Created by Andrean Lay on 28/04/21.
//

import UIKit

class MainTabBarController: UITabBarController {
    private var raisedButton: UIButton!
    private var addTimerButton: UIButton!
    private var addAlarmButton: UIButton!
    
    var eventDelegate: EventDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addRaisedButton()
        self.setupAddAlarmButton()
        self.setupAddTimerButton()
    }
    
    private func addRaisedButton() {
        raisedButton = UIButton()
        raisedButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        raisedButton.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
        raisedButton.layer.cornerRadius = 30
        raisedButton.layer.masksToBounds = true
        raisedButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 75)
        raisedButton.setImage(UIImage(systemName: "plus"), for: .normal)
        raisedButton.tintColor = .white
        
        raisedButton.tag = -1
        raisedButton.addTarget(self, action: #selector(raisedButtonTapped), for: .touchUpInside)
        
        view.addSubview(raisedButton)
    }
    
    private func setupAddAlarmButton() {
        addAlarmButton = UIButton()
        addAlarmButton.frame.size = CGSize(width: 50, height: 50)
        addAlarmButton.center = self.raisedButton.center
        addAlarmButton.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
        addAlarmButton.layer.cornerRadius = 25
        addAlarmButton.layer.masksToBounds = true
        addAlarmButton.setImage(UIImage(systemName: "alarm"), for: .normal)
        addAlarmButton.tintColor = .white
        addAlarmButton.isHidden = true
        addAlarmButton.addTarget(self, action: #selector(addAlarmTapped), for: .touchUpInside)
        view.addSubview(addAlarmButton)
    }
    
    @objc private func addAlarmTapped() {
        let storyboard = UIStoryboard(name: "AddAlarm", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddAlarmVC") as! AddAlarmViewController

        vc.delegate = self.eventDelegate
        let navController = UINavigationController(rootViewController: vc)
        
        present(navController, animated: true, completion: nil)
    }
    
    private func setupAddTimerButton() {
        addTimerButton = UIButton()
        addTimerButton.frame.size = CGSize(width: 50, height: 50)
        addTimerButton.center = self.raisedButton.center
        addTimerButton.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
        addTimerButton.layer.cornerRadius = 25
        addTimerButton.layer.masksToBounds = true
        addTimerButton.setImage(UIImage(systemName: "timer"), for: .normal)
        addTimerButton.tintColor = .white
        addTimerButton.isHidden = true
        
        view.addSubview(addTimerButton)
    }
    
    @objc func raisedButtonTapped(_ sender: UIButton) {
        let state = sender.tag
        if state == -1 {
            self.addAlarmButton.isHidden = false
            self.addTimerButton.isHidden = false
            self.raisedButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        }
        
        for _ in 1...10 {
            UIView.animate(withDuration: 0.3, animations: {
                self.addAlarmButton.frame = CGRect(x: self.addAlarmButton.frame.minX + 5 * CGFloat(state), y: self.addAlarmButton.frame.minY + 5 * CGFloat(state), width: 50, height: 50)

                self.addTimerButton.frame = CGRect(x: self.addTimerButton.frame.minX - 5 * CGFloat(state), y: self.addTimerButton.frame.minY + 5 * CGFloat(state), width: 50, height: 50)
            }) { _ in
                if state == 1 {
                    self.addAlarmButton.isHidden = true
                    self.addTimerButton.isHidden = true
                    self.raisedButton.setImage(UIImage(systemName: "plus"), for: .normal)
                }
            }
        }
        
        sender.tag = (state == -1 ? 1 : -1)
    }
}
