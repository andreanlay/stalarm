//
//  SceneManager.swift
//  Stalarm
//
//  Created by Andrean Lay on 01/05/21.
//

import Foundation

class SceneManager {
    static let shared = SceneManager()
    
    var firstLaunched: Bool {
        get {
            UserDefaults.standard.bool(forKey: "firstLaunch")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "firstLaunch")
        }
    }
}
