// ChartDataをこっちのボタンやらチャートやらに対応させる処理を考える


import SwiftUI

struct ScheduleView: View {
    
    @Binding var showSchedule:Bool
    let dates = TimeAry().DateMaker()
    @State var dayArray: [[ChartData]] = [[]]
    @State var dayArrayX: [ChartData] = [ChartData(text: "a",color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), time: 2000, percent: 8, value: 8),
                                         ChartData(text: "b",color: Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), time: 2000, percent: 15, value: 23),
                                         ChartData(text: "c",color: Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)), time: 2000, percent: 32, value: 55),
                                         ChartData(text: "d",color: Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)), time: 2000, percent: 45, value: 100)]
    
    // 選択された日付
    @State var selectDate = "Choose Date"
    @State var selectDateColor: Color = .green
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.showSchedule.toggle()
                    
                },label: {
                    Text("Close")
                        .font(.title3)
                })
                Spacer()
            }.padding([.top, .leading])
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach (dates.indices) { i in
                        Button(action: {
                            selectDate = "\(dates[i].month) \(dates[i].day)"
                            selectDateColor = dates[i].color
                            print("インデックス: \(i), カウント: \(dayArray.count)")
                            if i < dayArray.count {
                                dayArrayX = dayArray[i]
                            } else {
                                dayArrayX = [ChartData(text: "noData", color: .pink, time: 2000, percent: 100, value: 100)]
                            }
                        }, label: {
                            DailyView(month: dates[i].month, day: dates[i].day, color: dates[i].color)
                        })
                    }
                }
                .padding(6)
            }
            HStack {
                Text("LifeMemory is...")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding(4)
            .frame(maxWidth: .infinity)
            .background(Color.gray)
            Spacer()
            ZStack {
                VStack {
                    HStack {
                        Text(selectDate)
                            .font(.largeTitle)
                            .foregroundColor(selectDateColor)
                            .padding(.horizontal, 10.0)
                        Spacer()
                    }
                    Spacer()
                }
                VStack {
                    PieChartView(chartData: $dayArrayX)
                        .padding()
                    Spacer()
                }
            }
        }
        // 再描画するとチャートが消える
        // これのタイミングがデイアレイ整理前になってる問題
        .onAppear{
            dayArray = roadDayArrayItems()!
        }
    }
}


struct ScheduleView_Previews: PreviewProvider {
    @State static var showSchedule = true
    static var previews: some View {
        ScheduleView(showSchedule: $showSchedule)
    }
}


