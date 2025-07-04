//
//  File.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/26.
//

import Foundation
/// 处理从远程源获取的数据
public protocol PJsonWriter{
    /// 解析从远程源加载的数据
    /// - Parameter data: 数据源
    func t2StrJson<T:Encodable>(_ t: T) throws -> Data
}
