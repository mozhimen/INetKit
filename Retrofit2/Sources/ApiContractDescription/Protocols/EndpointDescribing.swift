//
//  EndpointDescribing.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.
//

public protocol EndpointDescribing {
    var path: String { get }
    var method: HttpMethod { get }
}
