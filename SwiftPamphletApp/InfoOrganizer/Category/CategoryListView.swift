//
//  CategoryListView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/11.
//

import SwiftUI
import SwiftData
import Charts

struct CategoryListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(IOCategory.allOrderByName) var cates: [IOCategory]
    @State var selectCate: IOCategory?
    
    var body: some View {
        List(selection: $selectCate) {
            ForEach(cates) { cate in
                NavigationLink(value: cate) {
                    CategoryRowView(cate: cate, selectedCate: selectCate)
                }
            }
        }
        ScrollView(.horizontal) {
            Chart {
                ForEach(cates) { cate in
                    BarMark(
                        x: .value("名字", cate.name),
                        y: .value("数量", cate.infos?.count ?? 0)
                    )
                    .foregroundStyle(.orange)
                    .symbol(.circle)
                    .interpolationMethod(.catmullRom)
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic(minimumStride: 10)) { _ in
                    AxisGridLine()
                    AxisTick()
                    
                }
            }
        }
        
    }
}

