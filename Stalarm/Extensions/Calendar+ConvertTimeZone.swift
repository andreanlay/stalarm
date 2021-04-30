//
//  Calendar+ConvertTimeZone.swift
//  Stalarm
//
//  Created by Andrean Lay on 29/04/21.
//

import UIKit

extension Calendar {
    func convertTimeZone(to timeZone: TimeZone, from date: Date) -> Date? {
        var components = dateComponents(in: timeZone, from: date)
        components.timeZone = self.timeZone
        return self.date(from: components)
    }
}
