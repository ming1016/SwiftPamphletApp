//
//  InfoRowView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/12.
//

import SwiftUI
import InfoOrganizer
import SMDate

struct InfoRowView: View {
    @State var info: IOInfo
    let selectedInfo: IOInfo?
    @State private var showAlert = false
    
    var infoColor: Color {
        selectedInfo == info ? Color.white : Color.accentColor
    }
    
    var body: some View {
        VStack(alignment:.leading) {
            if let coverImg = info.coverImage {
                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 80)
                    GeometryReader { geometry in
                        if coverImg.url.isEmpty == false {
                            NukeImage(width: geometry.size.width, height: geometry.size.height, url: coverImg.url, contentModel: .fill)
                        } else if let imgData = coverImg.imgData {
                            if let nsImage = NSImage(data: imgData) {
                                Image(nsImage: nsImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
            }
            Text(info.name)
                .fixedSize(horizontal: false, vertical: true)
            Text(shortDes())
                .fixedSize(horizontal: false, vertical: true)
                .font(.footnote)
                .foregroundColor(.secondary)
            
            HStack(alignment: .center) {
                if info.category != nil {
                    Text(info.category?.name ?? "")
                        .padding(4)
                        .overlay {
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(lineWidth: 1)
                            }
                }
                
                Spacer()
                if info.star == true {
                    Image(systemName: "star.square.fill")
                        .symbolRenderingMode(.multicolor)
                }
                if info.isArchived == true {
                    Image(systemName: "archivebox.fill")
                        .foregroundStyle(Color.mint)
                }
                if info.des == "\n" || info.des.isEmpty {
                    
                } else {
                    Image(systemName: "pencil.and.list.clipboard")
                }
                if info.webArchive != nil {
                    Image(systemName: "square.and.arrow.down.fill")
                }
                Text(SMDate.howLongAgo(date: info.updateDate))
                    .foregroundColor(.secondary)
            }
            .font(.footnote)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
        .swipeActions {
            Button(role: .destructive) {
                IOInfo.delete(info)
            } label: {
                Label("删除", systemImage: "trash")
            }
            
        }
        .contextMenu {
            Button("删除") {
                IOInfo.delete(info)
            }
        }
    }
    
    func shortDes() -> String {
        let shortDes = info.des.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        var reStr = ""
        if let first = shortDes.first {
            reStr += first
        }
        if shortDes.count > 1 {
            reStr += "\n" + shortDes[1]
        }
        return reStr
    }
    
}


