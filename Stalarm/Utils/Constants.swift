//
//  Constants.swift
//  Stalarm
//
//  Created by Andrean Lay on 29/04/21.
//

import Foundation

struct Constants {
    static let Timezones = [
        ("UTC-12:00", TimeZone(secondsFromGMT: -43200)),
        ("UTC-11:00 / ST", TimeZone(secondsFromGMT: -39600)),
        ("UTC-10:00 / HT", TimeZone(secondsFromGMT: -36000)),
        ("UTC-09:30", TimeZone(identifier: "Pacific/Marquesas")),
        ("UTC-09:00 / AKT", TimeZone(secondsFromGMT: -32400)),
        ("UTC-08:00 / PT", TimeZone(secondsFromGMT: -28800)),
        ("UTC-07:00 / MT", TimeZone(secondsFromGMT: -25200)),
        ("UTC-06:00 / CT", TimeZone(secondsFromGMT: -21600)),
        ("UTC-05:00 / ET", TimeZone(secondsFromGMT: -18000)),
        ("UTC-04:00 / AST", TimeZone(secondsFromGMT: -14400)),
        ("UTC-03:30 / PMST", TimeZone(identifier: "America/St_Johns")),
        ("UTC-03:00 / ART", TimeZone(secondsFromGMT: -10800)),
        ("UTC-02:00", TimeZone(secondsFromGMT: -7200)),
        ("UTC-01:00", TimeZone(secondsFromGMT: -3600)),
        ("UTC / GMT", TimeZone(secondsFromGMT: 0)),
        ("UTC+01:00 / CET", TimeZone(secondsFromGMT: 3600)),
        ("UTC+02:00 / EET", TimeZone(secondsFromGMT: 7200)),
        ("UTC+03:00", TimeZone(secondsFromGMT: 10800)),
        ("UTC+03:30", TimeZone(identifier: "Asia/Tehran")),
        ("UTC+04:00", TimeZone(secondsFromGMT: 14400)),
        ("UTC+04:30", TimeZone(identifier: "Asia/Kabul")),
        ("UTC+05:00", TimeZone(secondsFromGMT: 18000)),
        ("UTC+05:30", TimeZone(identifier: "Asia/Colombo")),
        ("UTC+05:45", TimeZone(identifier: "Asia/Kathmandu")),
        ("UTC+06:00", TimeZone(secondsFromGMT: 21600)),
        ("UTC+06:30", TimeZone(identifier: "Asia/Yangon")),
        ("UTC+07:00 / CXT", TimeZone(secondsFromGMT: 25200)),
        ("UTC+08:00 / AWST", TimeZone(secondsFromGMT: 28800)),
        ("UTC+08:45 / CWT", TimeZone(identifier: "Australia/Eucla")),
        ("UTC+09:00", TimeZone(secondsFromGMT: 32400)),
        ("UTC+09:30", TimeZone(identifier: "Australia/Adelaide")),
        ("UTC+10:00 / ChT", TimeZone(secondsFromGMT: 36000)),
        ("UTC+10:30", TimeZone(identifier: "Australia/Lord_Howe")),
        ("UTC+11:00", TimeZone(secondsFromGMT: 39600)),
        ("UTC+12:00", TimeZone(secondsFromGMT: 43200)),
        ("UTC+12:45", TimeZone(identifier: "Pacific/Chatham")),
        ("UTC+13:00", TimeZone(secondsFromGMT: 46800)),
        ("UTC+14:00", TimeZone(secondsFromGMT: 50400)),
    ]
    
    static let TimezonesDictionary = Timezones.reduce(into: [:]) { $0[$1.0] = $1.1 }
}
