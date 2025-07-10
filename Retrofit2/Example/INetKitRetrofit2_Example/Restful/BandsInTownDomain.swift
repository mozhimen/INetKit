//
//  BandsInTownDomain.swift
//  INetKitRetrofit2_Example
//
//  Created by Taiyou on 2025/7/8.
//
import Retrofit2

class BandsInTownDomain: Scope {
    override init(transport: HttpTransport) {
        super.init(transport: transport)
        transport.setConfiguration(scheme: "https", host: "rest.bandsintown.com", sharedHeaders: nil)
    }
}
