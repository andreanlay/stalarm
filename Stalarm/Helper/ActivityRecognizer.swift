//
//  ActivityRecognizer.swift
//  Stalarm
//
//  Created by Andrean Lay on 03/05/21.
//

import CoreMotion
import CoreML
import AVFoundation

class ActivityRecognizer {
    var activityManager: CMMotionActivityManager!
    
    var doingActivity: (_ activity: Bool) -> Void
    
    init(doingActivity: @escaping (_ activity: Bool) -> Void) {
        self.doingActivity = doingActivity

        self.activityManager = CMMotionActivityManager()
        self.activityManager.startActivityUpdates(to: .main) { activity in
            if (activity?.stationary)! {
                doingActivity(false)
            } else {
                doingActivity(true)
            }
        }
    }
}
