//
//  PValidator.swift
//  INetKit
//
//  Created by Taiyou on 2025/6/26.
//

import Foundation

/// 定义用于验证 URL 响应规范的规则
protocol PValidator{
    /// Validate
    /// - Parameter data: URLResponse
    func validate(_ response: URLResponse, with data: Data?) throws
}
