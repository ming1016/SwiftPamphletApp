//
//  MetricManager.swift
//  SwiftPamphletApp
//
//  Created by Ming on 2024/11/11.
//

import MetricKit

@objc class MetricKitManager: NSObject, MXMetricManagerSubscriber {
    @MainActor @objc public static let shared = MetricKitManager()

    private override init() {
        super.init()
        start()
    }

    func start() {
        let metricManager = MXMetricManager.shared
        metricManager.add(self)
    }
}

extension MetricKitManager {
    #if os(iOS)
    @available(iOS 13.0, *)
    func didReceive(_ payloads: [MXMetricPayload]) {
        guard let firstPayload = payloads.first else { return }
        print("Launch Time Data: \(firstPayload.dictionaryRepresentation())")
    }
    #endif

    @available(iOS 14.0, *)
    func didReceive(_ payloads: [MXDiagnosticPayload]) {
        guard let firstPayload = payloads.first else { return }
        print("Diagnostic Data: \(firstPayload.dictionaryRepresentation())")
    }
}
