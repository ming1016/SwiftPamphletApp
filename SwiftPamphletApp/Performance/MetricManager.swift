//
//  MetricManager.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/11.
//

#if os(iOS)
import MetricKit

@MainActor
class MetricsManager: NSObject, @preconcurrency MXMetricManagerSubscriber {
    static let shared = MetricsManager()
    
    override init() {
        super.init()
        MXMetricManager.shared.add(self)
    }

    // 接收性能报告的回调
    func didReceive(_ payloads: [MXMetricPayload]) {
        for payload in payloads {
            if let launchMetrics = payload.applicationLaunchMetrics {
                // This represents the time when the first CA commit is finished.
                print(launchMetrics.histogrammedTimeToFirstDraw)
            }
        }
    }
    
    deinit {
        MXMetricManager.shared.remove(self)
    }
}

//import MetricKit
//import Observation

//@Observable
//@MainActor
//class MetricsManager: NSObject, @preconcurrency MXMetricManagerSubscriber {
//    var latestPayload: MXMetricPayload?
//
//    override init() {
//        super.init()
//        MXMetricManager.shared.add(self)
//    }
//
//    deinit {
//        MXMetricManager.shared.remove(self)
//    }
//
//    func didReceive(_ payloads: [MXMetricPayload]) {
//        Task { @MainActor in
//            if let latest = payloads.last {
//                self.latestPayload = latest
//            }
//        }
//    }
//
//    func didReceive(_ payloads: [MXDiagnosticPayload]) {
//        // Handle diagnostic payloads if needed
//    }
//
//    func fetchMetrics() async {
//        // Example async function to fetch metrics
//        try! await Task.sleep(nanoseconds: 2 * 1_000_000_000) // Simulate network delay
//        // Update state with fetched metrics
//    }
//}
//
//extension MetricsManager {
//    func performAsyncOperation() async {
//        await Task { @Sendable in
//            // Perform some async operation
//        }.value
//    }
//}
#endif
