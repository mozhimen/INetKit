//
//  IJsonRead.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/26.
//

import Foundation

/// 处理从远程源获取的数据
public protocol PJsonReader{
    /// 解析从远程源加载的数据
    /// - Parameter data: 数据源
    func fromJson<T:Decodable>(data:Data) throws -> T
}
