//
//  AudioManager.swift
//  Stalarm
//
//  Created by Andrean Lay on 03/05/21.
//

import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    
    let musicList = [
        "alarmStopped": Bundle.main.url(forResource: "SuccessStopAlarm", withExtension: "wav"),
    ]
    
    var player = AVAudioPlayer()
    
    func playSoundEffect(for name: String) {
        do {
            player = try AVAudioPlayer(contentsOf: musicList[name]!!)
            player.play()
        } catch {
            fatalError("Cannot play music for \(name)")
        }
    }
}
