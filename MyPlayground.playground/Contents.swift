//
//  PieChartView.swift
//  LifeDiary
//
//  Created by kohei morioka on 2021/05/21.
//

import SwiftUI

struct PieChartView: View {
    @State var chartData = [ChartData(text: "",color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: 8, value: 8),
                            ChartData(text: "",color: Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), percent: 15, value: 23),
                            ChartData(text: "",color: Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)), percent: 32, value: 55),
                            ChartData(text: "",color: Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)), percent: 45, value: 100)]
    @State var indexOfTappedSlice = -1
    var body: some View {
        VStack {
            ForEach(0..<chartData.count) { index in
                HStack {
                    Text(String(format: "%.2f", Double(chartData[index].percent))+"%")
                        .font(indexOfTappedSlice == index ? .headline : .subheadline)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(chartData[index].color)
                        .frame(width: 15, height: 15)
                }
            }
            .padding(8)
            .frame(width: 300, alignment: .trailing)
            //MARK:- Pie Slices
            Text("0")
                .fontWeight(.light)
            HStack {
                Text("18")
                    .fontWeight(.light)
                    .padding(.trailing, 5.0)
                ZStack {
                    ZStack {
                        ForEach(0..<chartData.count) { index in
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

struct ChartData: Identifiable {
    var id = UUID()
    var text: String
    var color : Color
    var percent : CGFloat
    var value : CGFloat
    
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView()
    }
}
