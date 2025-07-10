//
//  ArtistEventsErrorResponse.swift
//  INetKitRetrofit2_Example
//
//  Created by Taiyou on 2025/7/8.
//

struct ArtistEventsErrorResponse: Error, Decodable {
    let errorMessage: String

    enum CodingKeys: String, CodingKey {
        case errorMessage = "Message"
    }
}
