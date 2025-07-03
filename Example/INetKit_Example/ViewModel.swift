//
//  ViewModel.swift
//  INetKit_Example
//
//  Created by Taiyou on 2025/7/1.
//

import Foundation
import INetKit

final class ViewModel: ObservableObject{
    let http = Http.Proxy(baseURL: URL(string: "http://localhost:3000")!)
    
    func get(path:String) async throws -> Http.Response<[User]>{
        try await http.get(path: path,retry: 1)
    }
    
    func postWithMetrics(path: String) async throws -> Http.Response<[User]>{
        try await http.post(path: path, taskDelegate: TaskDelegate())
    }
    
    func post(path: String) async throws -> Http.Response<[User]>{
        try await http.post(path: path, body: data, querys: [("name", "Igor"), ("page","1")], headers: ["Content-Type": "application/json"])
    }
    
    func put(path: String) async throws -> Http.Response<[User]>{
        try await http.put(path: path, body: data)
    }
    
    func delete(path: String) async throws -> Http.Response<[User]>{
        try await http.delete(path: path)
    }
}
