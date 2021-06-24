//
//  ButtonDailyView.swift
//  LifeDiary
//
//  Created by kohei morioka on 2021/05/20.
//

import SwiftUI

struct DailyView: View {
    
    let month: String
    let day: String
    let color: Color
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text(month)
                        .font(.headline)
                        .foregroundColor(color)
                        .padding(5)
                    Spacer()
                }
                Spacer()
            }
            Text(day)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(color)
        }
        .frame(width: 99.0, height: 99.0)
        .background(Color(.white))
        .cornerRadius(10)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
    }
}

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView(month: "MON", day: "Day", color: .orange)
    }
}
