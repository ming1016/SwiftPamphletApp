//
//  NotificationService.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/11.
//

import Foundation
import UserNotifications
import SwiftUI

struct NotificationPreheatDemoView: View {
    var body: some View {
        VStack {
            Button("请求通知授权") {
                NotificationService.shared.requestAuthorization { granted in
                    if granted {
                        print("授权成功")
                    } else {
                        print("授权失败")
                    }
                }
            }
            
            Button("安排通知") {
                NotificationService.shared.scheduleNotification(title: "提醒", body: "这是一个通知示例", timeInterval: 5)
            }
        }
        .padding()
    }
}

class NotificationService: NSObject, UNUserNotificationCenterDelegate {
    @MainActor static let shared = NotificationService()
    
    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Authorization error: \(error.localizedDescription)")
                completion(false)
                return
            }
        }
    }
    
    func scheduleNotification(title: String, body: String, timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification scheduling error: \(error.localizedDescription)")
            }
        }
    }
    
    // 处理接收到的通知
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 在应用程序前台时处理通知
        print("接收到通知：\(notification.request.content.title)")
        preloadSystemLibraries()
        completionHandler([.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // 处理用户点击通知的行为
        print("用户点击了通知：\(response.notification.request.content.userInfo)")
        completionHandler()
    }
    
    private func preloadSystemLibraries() {
        // 使用 dlopen 提前加载主 App 常用的系统动态库
        let libraries = [
            "/usr/lib/libobjc.A.dylib",
            "/System/Library/Frameworks/UIKit.framework/UIKit",
            "/System/Library/Frameworks/Foundation.framework/Foundation"
        ]
        
        for library in libraries {
            dlopen(library, RTLD_NOW)
        }
    }
}
