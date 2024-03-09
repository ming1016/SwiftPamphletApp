// The Swift Programming Language
// https://docs.swift.org/swift-book


import Observation
import Network

@Observable
public final class NetworkMonitor {
    public var hasNetworkConnection = true
    public var isUsingMobileConnection = false // low data usage ( 3G / 4G / etc )
    
    private let networkMonitor = NWPathMonitor()
    
    public init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            self?.hasNetworkConnection = path.status == .satisfied
            self?.isUsingMobileConnection = path.usesInterfaceType(.cellular)
        }
        
        networkMonitor.start(queue: DispatchQueue.global())
    }
}
