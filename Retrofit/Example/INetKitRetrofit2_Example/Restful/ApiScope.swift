//
//  BandsInTownDomain.swift
//  INetKitRetrofit2_Example
//
//  Created by Taiyou on 2025/7/8.
//
import Retrofit2

class BandsInTownDomain: Scope {
    override init(retrofit: any PRetrofit) {
        super.init(retrofit: retrofit)
        retrofit.setConfiguration(scheme: "https", host: "rest.bandsintown.com", sharedHeaders: nil)
    }
}
