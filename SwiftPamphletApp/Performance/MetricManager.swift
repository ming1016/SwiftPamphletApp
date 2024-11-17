//
//  MetricManager.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/11.
//

import MetricKit
import Observation

@Observable
@MainActor
class MetricsManager: NSObject, @preconcurrency MXMetricManagerSubscriber {
    var latestPayload: MXMetricPayload?

    override init() {
        super.init()
        MXMetricManager.shared.add(self)
    }

    deinit {
        MXMetricManager.shared.remove(self)
    }

    func didReceive(_ payloads: [MXMetricPayload]) {
        Task { @MainActor in
            if let latest = payloads.last {
                self.latestPayload = latest
            }
        }
    }

    func didReceive(_ payloads: [MXDiagnosticPayload]) {
        // Handle diagnostic payloads if needed
    }

    func fetchMetrics() async {
        // Example async function to fetch metrics
        try! await Task.sleep(nanoseconds: 2 * 1_000_000_000) // Simulate network delay
        // Update state with fetched metrics
    }
}

extension MetricsManager {
    func performAsyncOperation() async {
        await Task { @Sendable in
            // Perform some async operation
        }.value
    }
}
