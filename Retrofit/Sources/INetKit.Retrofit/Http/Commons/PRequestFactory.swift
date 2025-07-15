//
//  RequestBuilder.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.∂
//

protocol PRequestFactory {
    func parseRequestFields(paramName: String,builder: Request.Builder,retrofit: PRetrofit) throws
}
