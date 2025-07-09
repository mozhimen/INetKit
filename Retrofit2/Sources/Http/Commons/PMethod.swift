//
//  PMethod.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/9.
//

public protocol PMethod {
    var path: String { get }
    var method: HttpMethod { get }
}
