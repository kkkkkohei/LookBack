//
//  PieChart.swift
//  LifeDiary
//
//  Created by kohei morioka on 2021/05/21.
//

import Foundation
import SwiftUI


struct ChartData: Identifiable, Codable {
    var id = UUID()
    var text: String
    var color : Color
    var time: Int
    var percent : CGFloat
    var value : CGFloat
    
}



class ChartDataContainer : ObservableObject {
    @Published var chartData =
        [ChartData(text: "",color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), time: 2000, percent: 8, value: 8),
         ChartData(text: "",color: Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), time: 2000, percent: 15, value: 23),
         ChartData(text: "",color: Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)), time: 2000, percent: 32, value: 55),
         ChartData(text: "",color: Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)), time: 2000, percent: 45, value: 100)]
}
