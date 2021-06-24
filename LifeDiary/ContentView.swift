//
//  ContentView.swift
//  LifeDiary
//
//  Created by kohei morioka on 2021/05/19.
//

import SwiftUI

struct ContentView: View {
    
    
    let calendar = Calendar(identifier: .gregorian)
    //スケジュールsheetトリガー
    @State private var showSchedule = false
    // テキストフィールドへの入力値
    @State var inputPlan = ""
    // リストの初期値
    @State private var works = [
        workStruct(work: "Sleeping", color: .purple),
        workStruct(work: "Working", color: .blue),
        workStruct(work: "Playing", color: .pink)
    ]
    // 選択した色
    @State var colorSelect = Color.blue
    
    // 日毎の行動記録
    @State var dailyList: [dailyStruct]
    @State var dayArray: [[ChartData]]
    
    // リストのスワイプ削除
    func rowRemove(offsets: IndexSet) {
        works.remove(atOffsets: offsets)
        // 削除後の配列を保存
        saveWorkItems(items: works)
    }
    
    // UI部分
    var body: some View {
        VStack {
            // 実行中動作の表示
            Text(dailyList.last!.work)
                .font(.largeTitle)
                .fontWeight(.regular)
                .foregroundColor(dailyList.last!.color)
                .multilineTextAlignment(.leading)
                .padding()
            
            // 実行動作の経過時間を表示
            let timeInterval = Date().timeIntervalSince(dailyList.last!.date)
            let time = Int(timeInterval)
            
            Text("\(time / 3600 % 24)hour \(time / 60 % 60)min")
            
            ZStack{
                // プラン追加用のテキフィー
                // onCommit: 改行で動作する
                TextField("Add Plan", text: $inputPlan, onCommit: {
                    works.append(workStruct(work: inputPlan, color: colorSelect))
                    // 追加後の配列を保存
                    saveWorkItems(items: works)
                    inputPlan = ""
                })
                .frame(height: 40)
                ColorPicker("", selection: $colorSelect)
            }
            
            List {
                ForEach(works) { work in
                    Button(action: {
                        // 日を跨いでいた場合startDayを追加
                        if dailyList.last!.date < calendar.startOfDay(for: Date()) {
                            dailyList.append(dailyStruct(
                                                work: dailyList.last!.work,
                                                color: dailyList.last!.color,
                                                date: calendar.startOfDay(for: Date())))
                        }
                        
                        // リスト選択で実行動作更新&動作保存
                        // 選択したリストの情報をdailyStructに格納&保存
                        dailyList.append(dailyStruct(work: work.work, color: work.color, date: Date()))
                        saveDailyItems(items: dailyList)
                    }, label: {
                        Text(work.work)
                            .foregroundColor(work.color)
                    })
                }
                // 行削除操作時に呼び出す処理の指定
                .onDelete(perform: rowRemove)
            }
            
            // スケジュールsheetを呼ぶボタン
            Button(action: {
                //scheduleViewを表示する
                showSchedule.toggle()
            }) {
                Text("Check Dialy")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.pink)
                    .cornerRadius(10)
            }.padding()
            // スケジュール画面を表示
            .sheet(isPresented: self.$showSchedule, content: {
                ScheduleView(showSchedule: self.$showSchedule)
            })
        } // VStack終了
        // 画面起動時の動作
        .onAppear {
            // worksリストの読み込み
            self.works = [
                workStruct(work: "Sleeping", color: .purple),
                workStruct(work: "Working", color: .blue),
                workStruct(work: "Playing", color: .pink)
            ]
            if roadWorkItems()!.count != 0 {
                self.works = roadWorkItems()!
            }
            
            // dailyリストの読み込み
            self.dailyList =  [dailyStruct(work: "sleep", color: .purple, date: calendar.startOfDay(for: Date()))]
            if roadDailyItems()?.count != 0 {
                dailyList = roadDailyItems()!
            }
            dailyList = CheckTime(daily: dailyList)
            print("デイリーリスト: \(dailyList)")
            
            ScheduleMaker()
            
            // dayArrayの読み込み
            self.dayArray = [[ChartData(text: "none", color: .blue, time: 2000, percent: CGFloat(10), value: 0)]]
            if roadDayArrayItems()?.count != 0{
                dayArray = roadDayArrayItems()!
            }
            print("出力データ: \(dayArray)")
            // print("内蔵データ: \(roadDayArrayItems()!)")
        }
    }
}



// Codableカスタムクラス実装
// https://qiita.com/yyokii/items/d97ea34fc0b417130049
struct workStruct: Identifiable, Codable {
    var id = UUID()
    let work: String
    let color: Color
}

// Charts作成用構造体
struct dailyStruct : Identifiable, Codable{
    var id = UUID()
    let work: String
    let color: Color
    let date: Date
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = Calendar(identifier: .gregorian)
        let time = calendar.startOfDay(for: Date())
        
        ContentView(
            dailyList: [dailyStruct(work: "sleep", color: .blue, date: time)],
            dayArray: [[ChartData(text: "oha", color: .blue, time: 2000, percent: CGFloat(10), value: 0)]])
    }
}
