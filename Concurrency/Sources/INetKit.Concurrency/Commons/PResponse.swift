//
//  File.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/26.
//

import Foundation

/// 定义了来自远程源的响应
public protocol PResponse{
    /// Raw data
    var data: Data{get}
}
