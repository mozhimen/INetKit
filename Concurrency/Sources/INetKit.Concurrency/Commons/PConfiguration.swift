//
//  File.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/26.
//

import Foundation

/// ``Sendable`` - 一种其值能够在不同并发域之间安全地通过复制方式进行传递的类型
public protocol PConfiguration{
    associatedtype Reader: PJsonReader
    associatedtype Writer: PJsonWriter
    
    /// 一个能够从 JSON 对象中解码出某一数据类型实例的程序组件
    var reader: Reader { get }
    
    /// 一种将数据类型的实例编码为 JSON 对象的工具/技术。
    var writer: Writer { get }
}
