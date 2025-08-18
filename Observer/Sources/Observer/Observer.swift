// The Swift Programming Language
// https://docs.swift.org/swift-book
import Network
import SwiftUI

public final class NetworkObserver: ObservableObject,@unchecked Sendable {
    
    private let _monitor = NWPathMonitor()
    private let _queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published public private(set) var isConnected = false
    
    public init() {
        _monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        _monitor.start(queue: _queue)
    }
}
struct ContentView: View {
    @StateObject private var networkObserver = NetworkObserver()
    
    var body: some View {
        VStack {
            if networkObserver.isConnected {
                Text("网络已连接")
            } else {
                Text("网络未连接")
            }
        }
    }
}

#Preview(body: {
    ContentView()
})
