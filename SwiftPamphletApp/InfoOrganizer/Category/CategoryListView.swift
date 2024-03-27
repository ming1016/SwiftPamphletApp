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
        GroupBox("图表显示") {
            Chart(cates) { cate in
                BarMark(
                    x: .value("数量", cate.infos?.count ?? 0),
                    y: .value("名字", cate.name)
                )
                .annotation(position: .overlay, alignment: .trailing, spacing: 3) {
                    Text("\(cate.infos?.count ?? 0)")
                        .font(.footnote)
                        .foregroundColor(light: .white, dark: .white)
                }
//                SectorMark(angle: .value("数量", cate.infos?.count ?? 0), innerRadius: .ratio(0.5),
//                           angularInset: 1.5)
//                    .foregroundStyle(by: .value("名字", cate.name))
//                    .annotation(position: .overlay, alignment: .trailing, spacing: 3) {
//                        Text(cate.name)
//                            .font(.footnote)
//                            .foregroundColor(light: .white, dark: .white)
//                    }
            }
            .chartLegend(.hidden)
            .chartXAxis(.hidden)
//            .chartYAxis(.hidden)
//            .aspectRatio(1, contentMode: .fit)
        }
        
    }
}

