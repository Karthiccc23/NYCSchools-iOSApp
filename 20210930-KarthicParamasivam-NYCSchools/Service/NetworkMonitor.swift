//
//  NetMonitor.swift
//  20210930-KarthicParamasivam-NYCSchools
//
//  Created by Karthic Paramasivam on 10/1/21.
//

import Foundation
import Network

protocol ConnectionObserver: class {
    func connectionStateDidChange(internetOn: Bool)
}
 
class NetworkMonitor {
    static public let shared = NetworkMonitor()
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    var isInternetOn: Bool = true
    
    weak var connectionObserver: ConnectionObserver?
    
    private init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }
 
    func startMonitoring() {
        self.monitor.pathUpdateHandler = { [weak self] path in
            self?.isInternetOn = path.status == .satisfied
            self?.connectionObserver?.connectionStateDidChange(internetOn: path.status == .satisfied)
        }
    }
 
    func stopMonitoring() {
        self.monitor.cancel()
    }
}
