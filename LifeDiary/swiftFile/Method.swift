import Foundation
import SwiftUI

//　起動時にリストのメンテナンス #1
// 最新時刻から日が飛んでいた場合、更新処理
func CheckTime(daily: [dailyStruct]) -> [dailyStruct] {
    // アプリ開いた時の時間を測ってstartOfDay => now
    let calendar = Calendar(identifier: .gregorian)
    let now = calendar.startOfDay(for: Date())
    
    
    var daily = daily
    let day = daily.last!
    var time = day.date
    // while処理
    while true {
        // 前時刻 >= nowであれば
        if time >= now {
            // print("time: \(time)")
            // print("now: \(now)")
            // print(Date())
            // ループ終了
            break
        } else { // else(別日だったとき)
            // 前時刻 +1day -> startOfDay　をリストにアペンド(dailyStruct)
            time = calendar.startOfDay(for: time.addingTimeInterval(60 * 60 * 24))
            daily.append(dailyStruct(work: day.work, color: day.color, date: time))
        }
    }
    saveDailyItems(items: daily)
    return daily
    // print("内蔵データ: \(daily)")
}

// 起動時に整理 sheetの起動と同時に実行 #2
func ScheduleMaker() {
    // 日毎の仮リスト
    var List: [ChartData] = []
    var dayArray = roadDayArrayItems()!
    var dailyList = roadDailyItems()!
    
    let calendar = Calendar(identifier: .gregorian)
    var time1: Date = dailyList[0].date // 開始時
    var time2: Date // 終了時 i+1
    var time: Float
    
    // リスト一個ずつ精査
    for i in 0..<(dailyList.count - 1){
        time2 = dailyList[i+1].date
        print("time1: \(time1)")
        print("time2: \(time2)")
        
        // 日が違うかどうかで条件わけ
        // 当日の時
        if time1 >= calendar.startOfDay(for: Date()) {
            // 処理を行なったリストまで削除して
            if i != 0 {
                dailyList.removeSubrange(0...(i-1))
            }
            saveDailyItems(items: dailyList)
            saveDayArrayItems(items: dayArray)
            print("セーブ")
            // 処理を抜ける
            break
            
            // 同日の時
        } else if calendar.startOfDay(for: time1) == calendar.startOfDay(for: time2) {
            print("い")
            // 時間差を計算して一日秒で割ってパーセントへ
            time = Float(time2.timeIntervalSince(time1))
            // 30min未満であれば飛ばす
            if time >= 1800 {
                print("タイム: \(time)")
                List.append(ChartData(text: dailyList[i].work, color: dailyList[i].color, time: Int(time), percent: CGFloat(time / 86400 * 100), value: 0))
                print("パーセント:\(time/86400 * 100)")
                time1 = time2
            }
            
            // 別日の時
        } else {
            print("う")
            // 時間差を計算して一日秒で割ってパーセントへ
            time = Float(time2.timeIntervalSince(time1))
            List.append(ChartData(text: dailyList[i].work, color: dailyList[i].color, time: Int(time), percent: CGFloat(time / 86400 * 100), value: 0))
            // value値の設定
            var value : CGFloat = 0
            
            for i in 0..<List.count {
                value += List[i].percent
                List[i].value = value
            }
            // 日毎リストへ
            dayArray.insert(List, at: 0)
            if dayArray.count > 14 {
                dayArray.removeLast()
            }
            List = []
            time1 = time2
        }
    }
    print("デイアレイ: \(dayArray)")
    
}




// Codable構造体セーブ work関連
func saveWorkItems(items: [workStruct]) {
    let data = items.map { try! JSONEncoder().encode($0) }
    UserDefaults.standard.set(data as [Any], forKey: "working")
}

// Codable構造体ロード
func roadWorkItems() -> [workStruct]? {
    guard let items = UserDefaults.standard.array(forKey: "working") as? [Data] else { return [workStruct]() }
    
    let decodedItems = items.map { try! JSONDecoder().decode(workStruct.self, from: $0) }
    return decodedItems
}

// Codable構造体セーブ　daily関連
func saveDailyItems(items: [dailyStruct]) {
    let data = items.map { try! JSONEncoder().encode($0) }
    UserDefaults.standard.set(data as [Any], forKey: "daylist")
}

// Codable構造体ロード
func roadDailyItems() -> [dailyStruct]? {
    guard let items = UserDefaults.standard.array(forKey: "daylist") as? [Data] else { return [dailyStruct]() }
    
    let decodedItems = items.map { try! JSONDecoder().decode(dailyStruct.self, from: $0) }
    return decodedItems
}

// Codable構造体セーブ　daily関連
func saveDayArrayItems(items: [[ChartData]]) {
    let data = items.map { try! JSONEncoder().encode($0) }
    UserDefaults.standard.set(data as [Any], forKey: "dayArray")
}

// Codable構造体ロード
func roadDayArrayItems() -> [[ChartData]]? {
    guard let items = UserDefaults.standard.array(forKey: "dayArray") as? [Data] else { return [[ChartData]]() }
    
    let decodedItems = items.map { try! JSONDecoder().decode([ChartData].self, from: $0) }
    return decodedItems
}


/*
 struct ChartData {
 var id = UUID()
 var text : String
 var color : Color
 var percent : CGFloat
 var value : CGFloat
 
 }
 
 struct dailyStruct : Identifiable, Codable{
 var id = UUID()
 let work: String
 let color: Color
 let date: Date
 }
 */
