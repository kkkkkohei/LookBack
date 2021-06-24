//
//  LifeDiaryApp.swift
//  LifeDiary
//
//  Created by kohei morioka on 2021/05/19.
//

import SwiftUI

@main
struct LifeDiaryApp: App {
    var body: some Scene {
        let calendar = Calendar(identifier: .gregorian)
        let time = calendar.startOfDay(for: Date())
        WindowGroup {
            ContentView(dailyList: [dailyStruct(work: "sleep", color: .blue, date: time)],
                        dayArray: [[ChartData(text: "oha", color: .blue, time: 2000, percent: CGFloat(10), value: 0)]])
        }
    }
}
