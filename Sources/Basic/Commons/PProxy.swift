//
//  File.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/26.
//

import Foundation

/// 定义了一个具有远程数据来源的通信层
public protocol PProxy{
    associatedtype Config:PConfiguration
    
    /// Configuration
    var config: Config{get}
}
