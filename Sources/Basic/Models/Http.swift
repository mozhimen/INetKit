//
//  File.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/26.
//

import Foundation

/// HTTP 异步客户端的命名空间
public struct Http{
    /// 一组用于请求的名称-值对
    public typealias Querys = [(String,String?)]
    
    /// 一个包含所有请求中 HTTP 头部字段的字典
    public typealias Headers = [String:String]
}
