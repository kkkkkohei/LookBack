//
//  Time.swift
//  LifeDiary
//
//  Created by kohei morioka on 2021/05/20.
//

import Foundation
import SwiftUI


struct TimeAry {
    // 月日をまとめる構造体
    struct Dates: Identifiable {
        var id = UUID() 
        let month: String
        let day: String
        let color: Color
    }


    func DateMaker() -> Array<Dates>{
        // Dateのフォーマット
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMM-d", options: 0, locale: Locale(identifier: "en_JP"))

        // 1日ずつ進めて配列に追加
        // var items = [String]()

        // 現在日時を取得
        let calendar = Calendar(identifier: .gregorian)
        let date = Date()
        var dateList: [Dates] = []
        
        // 色の入れ物
        var color: Color

        // 2週間前までの日時を取得
        for i in 1...14 {
            
            let value = i-15
            
            let modifiedDate = calendar.date(byAdding: .day, value: value, to: date)!
            
            // フォーマットを整える
            let dateStr = dateFormatter.string(from: modifiedDate)
            let dateArray: [String] = dateStr.components(separatedBy: " ")
            
            // 色の設定
            if dateArray[0] == "Jun"{
                color = .red
            } else if dateArray[0] == "Feb" {
                color = .blue
            } else if dateArray[0] == "Mar" {
                color = .pink
            } else if dateArray[0] == "Apr" {
                color = .green
            } else if dateArray[0] == "May" {
                color = Color("naeiro")
            } else if dateArray[0] == "Jun" {
                color = .purple
            } else if dateArray[0] == "Jul" {
                color = .blue
            } else if dateArray[0] == "Aug" {
                color = .orange
            } else if dateArray[0] == "Sep" {
                color = Color("murasaki")
            } else if dateArray[0] == "Oct" {
                color = Color("meisyoku")
            } else if dateArray[0] == "Nov" {
                color = Color("ginsusudake")
            } else {
                color = .yellow
            }
            
            //Datesのリストにしてまとめる
            let dates = Dates(month: dateArray[0], day: dateArray[1], color: color)
            dateList.append(dates)
        }
        dateList = dateList.reversed()
        return dateList
    }
}

