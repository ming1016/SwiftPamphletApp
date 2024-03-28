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
    @State var catesByCount: [IOCategory] = [IOCategory]()
    
    @State var maxCount: Int = 0
    @State var averageCount: Int = 0
    
    let linearGradient = LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.8), Color.pink.opacity(0.01)]),
                                        startPoint: .top,
                                        endPoint: .bottom)
    
    var body: some View {
        List(selection: $selectCate) {
            Section("编辑分类") {
                ForEach(cates) { cate in
                    NavigationLink(value: cate) {
                        CategoryRowView(cate: cate, selectedCate: selectCate)
                    }
                }
            }
        }
        GroupBox("分类排序") {
            Chart(catesByCount) { cate in
                BarMark(
                    x: .value("名字", cate.name),
                    y: .value("数量", cate.infos?.count ?? 0)
                )
                .foregroundStyle(linearGradient)
//                .interpolationMethod(.catmullRom) // 设置曲线啥的
                .annotation(position: .overlay, alignment: .top, spacing: 3) {
                    VStack {
                        Text("\(cate.infos?.count ?? 0)")
                            .font(.footnote)
                            .foregroundColor(light: .white, dark: .white)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        Text(cate.name)
                            .font(.footnote)
                            .foregroundColor(light: .white, dark: .white)
                            .rotationEffect(.degrees(45))
//                            .fixedSize(horizontal: false, vertical: true)
                            
                    }
                }
                RuleMark(y: .value("均线", averageCount))
                    .foregroundStyle(Color.secondary)
                    .lineStyle(StrokeStyle(lineWidth: 0.8, dash: [10]))
                    .annotation(alignment: .topLeading) {
                        Text("均线:\(averageCount)")
                            .font(.footnote).bold()
                            .padding(.trailing, 32)
                            .foregroundStyle(Color.secondary)
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
//            .chartYScale(domain: 0...maxCount)
            .aspectRatio(1, contentMode: .fit)
//            .chartLegend(.hidden)
//            .chartXAxis(.hidden)
            .chartScrollableAxes(.horizontal)
//            .chartScrollPosition(initialY: 8)
//            .chartXVisibleDomain(length: 5) // 调整可见数据点数
//            .chartYAxis(.hidden)
            
        }
        .onAppear(perform: {
            sortCates()
        })
        .onChange(of: cates) { oldValue, newValue in
            sortCates()
        }
    }
    
    func sortCates() {
        catesByCount = cates.sorted(by: { l, r in
            l.infos?.count ?? 0 > r.infos?.count ?? 0
        })
        
        // 找出最大
        var cateCounts = [Int]()
        for cate in cates {
            if let cateCount = cate.infos?.count {
                cateCounts.append(cateCount)
            }
        }
        maxCount = cateCounts.max() ?? 0
        let sum = cateCounts.reduce(0, +)
        averageCount = Int(Double(sum) / Double(cateCounts.count))
    }
}

