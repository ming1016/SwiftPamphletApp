//
//  InfoRowView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2024/3/12.
//

import SwiftUI

struct InfoRowView: View {
    @State var info: IOInfo
    let selectedInfo: IOInfo?
    @State private var showAlert = false
    
    var infoColor: Color {
        selectedInfo == info ? Color.white : Color.accentColor
    }
    
    var body: some View {
        VStack(alignment:.leading) {

            
            HStack(alignment:.top) {
                if let coverImg = info.coverImage {
                    if coverImg.url.isEmpty == false {
                        AsyncImage(url: URL(string: coverImg.url), content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .cornerRadius(5)
                        },
                        placeholder: {
                            Image(systemName: "photo.fill")
                                .frame(width: 60, height: 60)
                        })
                    } else if let imgData = coverImg.imgData {
                        if let nsImage = NSImage(data: imgData) {
                            Image(nsImage: nsImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .cornerRadius(5)
                        }
                    }
                    
                }
                Text(info.name)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            
            HStack(alignment: .center) {
                if info.category != nil {
                    Text(info.category?.name ?? "")
                }
                
                Spacer()
                if info.star == true {
                    Image(systemName: "star.square.fill")
                        .symbolRenderingMode(.multicolor)
                }
                if info.des == "\n" || info.des.isEmpty {
                    
                } else {
                    Image(systemName: "pencil.and.list.clipboard")
                }
                if info.webArchive != nil {
                    Image(systemName: "square.and.arrow.down.fill")
                }
                Text(howLongAgo(date: info.updateDate))
                    
                
            }
            .foregroundColor(light: .secondary, dark: .secondary)
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
    
}


