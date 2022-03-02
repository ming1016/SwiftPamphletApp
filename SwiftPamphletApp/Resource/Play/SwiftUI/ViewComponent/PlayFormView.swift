//
//  PlayFormView.swift
//  SwiftPamphletApp
//
//  Created by Ming Dai on 2022/2/22.
//

import SwiftUI
import Combine

struct PlayFormView: View {
    @EnvironmentObject var stVM: SettingsVM
    @State private var isShowBadge: Bool = false
    var body: some View {
        Form {
            Section("设置") {
                Toggle(isOn: $isShowBadge) {
                    Text("是否显示 Badge")
                }
            }
        } // end Form
    }
}

// Form 的数据管理，使用 UserDefaults 进行存取
final class SettingsVM: ObservableObject {
    private enum K {
        static let showBadge = "p_showBadge"
        static let sizeMode = "p_sizeMode"
    }
    private let ud: UserDefaults
    
    enum SizeMode: String, CaseIterable {
        case small, normal, big
    }
    
    init() {
        self.ud = UserDefaults.standard
        ud.register(defaults: [
            K.showBadge: true,
            K.sizeMode: SizeMode.normal
        ])
    }
    
    var isShowBadge: Bool {
        set {
            ud.set(newValue, forKey: K.showBadge)
        }
        get {
            ud.bool(forKey: K.showBadge)
        }
    }
    
    var sizeMode: SizeMode {
        set {
            ud.set(newValue.rawValue, forKey: K.sizeMode)
        }
        get {
            ud.string(forKey: K.sizeMode).flatMap { SizeMode(rawValue: $0) } ?? .normal
        }
    }
}






