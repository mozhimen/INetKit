// The Swift Programming Language
// https://docs.swift.org/swift-book
import Network
import SwiftUI
import ITaskKit_ThreadSafe

public final class NetworkObserver: ObservableObject,@unchecked Sendable {
    
    private let _monitor = NWPathMonitor()
    private let _queue = DispatchQueue(label: "NetworkMonitor")
    private let _lock = NSLock()
    
    @Published public private(set) var isConnected = false
    @Published public private(set) var connectionType: NWInterface.InterfaceType?
    
    public init() {
        _monitor.pathUpdateHandler = { [weak self] path in
            //            DispatchQueue.main.async {
            //                self.isConnected = path.status == .satisfied
            //            }
            self?.handlePathUpdate(path: path)
        }
        _monitor.start(queue: _queue)
    }
    
    deinit {
        _monitor.cancel()
    }
    
    private func handlePathUpdate(path: NWPath) {
        let isConnected = path.status == .satisfied
        var connectionType: NWInterface.InterfaceType?
        
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .wiredEthernet
        }
        
        // 线程安全地更新发布的值
        DispatchQueue.main.async { [weak self] in
            self?.updateStatus(isConnected: isConnected, connectionType: connectionType)
        }
    }
    
    private func updateStatus(isConnected: Bool, connectionType: NWInterface.InterfaceType?) {
        self.isConnected = isConnected
        self.connectionType = connectionType
    }
    
    public func currentStatus() -> (isConnected: Bool, connectionType: NWInterface.InterfaceType?) {
        _lock.lock()
        defer { _lock.unlock() }
        return (isConnected, connectionType)
    }
}

//struct ContentView: View {
//    @StateObject private var networkObserver = NetworkObserver()
//
//    var body: some View {
//        VStack {
//            if networkObserver.isConnected {
//                Text("网络已连接")
//            } else {
//                Text("网络未连接")
//            }
//        }
//    }
//}
//
//#Preview(body: {
//    ContentView()
//})
