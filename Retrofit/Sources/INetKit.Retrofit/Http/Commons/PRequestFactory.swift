//
//  RequestBuilder.swift
//  Retrofit2
//
//  Created by Taiyou on 2025/7/8.∂
//

protocol PRequestFactory {
    func parseRequestFields(forParameterWithName paramName: String,in builder: Request.Builder,by retrofit: PRetrofit) throws
}
