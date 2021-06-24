//
//  PieChartView.swift
//  LifeDiary
//
//  Created by kohei morioka on 2021/05/21.
//

// 右のパーセンテージは専用リストを作成してそこからやりくり
// ↑メソッドで実装が楽か？

import SwiftUI

struct PieChartView: View {
    @Binding var chartData: [ChartData]
    @State var indexOfTappedSlice = -1
    @State var title = "Tap Chart"
    @State var titleColor: Color = .blue
    var body: some View {
        VStack {
            ZStack{
                VStack{
                    HStack{
                        Text(title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(titleColor)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 30.0)
                            .padding(.top, 50.0)
                        Spacer()
                    }
                    Spacer()
                }
                VStack{
                    ScrollView(.vertical, showsIndicators: true) {
                    ForEach(0..<chartData.count, id: \.self) { index in
                        HStack {
                            // 同じ予定があった場合は合算したい
                            Text("\(chartData[index].time / 3600 % 24)h \(chartData[index].time / 60 % 60)m")
                                .font(indexOfTappedSlice == index ? .headline : .subheadline)
                            RoundedRectangle(cornerRadius: 3)
                                .fill(chartData[index].color)
                                .frame(width: 15, height: 15)
                        }
                    }
                    .padding(8)
                    .frame(width: 300, alignment: .trailing)
                    Spacer()
                    }
                }
            }
            .frame(height: 160)
            Spacer()
            //MARK:- Pie Slices
            Text("0")
                .fontWeight(.light)
            HStack {
                Text("18")
                    .fontWeight(.light)
                    .padding(.trailing, 5.0)
                ZStack {
                    ZStack {
                        ForEach(0..<chartData.count, id: \.self) { index in
                            Circle()
                                // sizeとoffsetで擬似strokeBorder
                                .size(width:300, height:150)
                                .offset(x:0, y:75)
                                .trim(from: index == 0 ? 0.0 : chartData[index-1].value/100,
                                      to: chartData[index].value/100)
                                .stroke(chartData[index].color,lineWidth: 150)
                                .scaleEffect(index == indexOfTappedSlice ? 1.06 : 1.0)
                                .rotationEffect(Angle(degrees: -90.0))
                                .animation(.spring())
                                .onTapGesture {
                                    indexOfTappedSlice = indexOfTappedSlice == index ? -1 : index
                                    title = chartData[index].text
                                    titleColor = chartData[index].color
                                }
                        }
                    }
                    .frame(width: 300, height: 300)
                }.frame(width: 300, height: 300)
                Text("6")
                    .fontWeight(.light)
                    .padding(.leading, 3.0)
                    .frame(width: 20, height: 20)
            }
            Text("12")
                .fontWeight(.light)
                .padding(.top, 4.0)
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(chartData: .constant([ChartData(text: "a",color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), time: 2000, percent: 8, value: 8),
                                           ChartData(text: "b",color: Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), time: 2000, percent: 15, value: 23),
                                           ChartData(text: "c",color: Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)), time: 2000, percent: 32, value: 55),
                                           ChartData(text: "d",color: Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)), time: 2000, percent: 45, value: 100)]))
    }
}
