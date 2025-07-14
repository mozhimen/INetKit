//
//  ArtistEventsErrorRes.swift
//  INetKitRetrofit2_Example
//
//  Created by Taiyou on 2025/7/14.
//

struct ArtistEventsErrorRes: Error, Decodable,Sendable {
    let errorMessage: String

    enum CodingKeys: String, CodingKey {
        case errorMessage = "Message"
    }
}
