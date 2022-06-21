//
//  PlayCharts.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/6/20.
//

//import SwiftUI
//import Charts
//
//struct PChartModel: Hashable {
//    var day: String
//    var amount: Int = .random(in: 1..<100)
//}
//
//extension PChartModel {
//    static var data: [PChartModel] {
//        let calendar = Calendar(identifier: .gregorian)
//        let days = calendar.shortWeekdaySymbols
//        return days.map { day in
//            PChartModel(day: day)
//        }
//    }
//}
//
//struct PlayCharts: View {
//    var body: some View {
//        if #available(macOS 13.0, *) {
//            Chart(PChartModel.data, id: \.self) { v in
//                BarMark(x: .value("天", v.day), y: .value("数量", v.amount))
//                
//            }
//            .padding()
//        } else {
//            // Fallback on earlier versions
//        }
//    }
//}

