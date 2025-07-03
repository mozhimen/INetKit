//
//  File.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/30.
//

import Foundation

public extension Http.Proxy where R== JsonReader,W==JsonWriter{
    ///Create proxy from base url
    ///- Parameter baseURL: Base url
    init(baseURL:URL) {
        let config = Http.Configuration<R,W>(baseURL: baseURL)
        self.init(config: config)
    }
}
