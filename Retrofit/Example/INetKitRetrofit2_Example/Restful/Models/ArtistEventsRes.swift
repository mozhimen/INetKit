//
//  ArtistEventsResponse.swift
//  INetKitRetrofit2_Example
//
//  Created by Taiyou on 2025/7/8.
//

struct ArtistEventsRes: Decodable {
    let eventsList: [Event]

    struct Event: Decodable {
        let eventId: String
        let artistId: String
        let url: String
        let onSaleDateTime: String
        let dateTime: String
        let description: String?
        let venue: Venue
        let offers: [Offer]
        let lineup: [String]

        enum CodingKeys: String, CodingKey {
            case eventId = "id"
            case artistId = "artist_id"
            case url
            case onSaleDateTime = "on_sale_datetime"
            case dateTime = "datetime"
            case description
            case venue
            case offers
            case lineup
        }
    }

    struct Venue: Decodable {
        let name: String
        let latitude: String
        let longitude: String
        let city: String
        let region: String
        let country: String
    }

    struct Offer: Decodable {
        let type: String
        let url: String
        let status: String
    }
}

extension ArtistEventsRes {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        eventsList = try container.decode([Event].self)
    }
}

extension ArtistEventsRes {
    var description: String {
        eventsList
            .map { event in [event.dateTime] + event.lineup }
            .map { $0.joined(separator: "\n") }
            .joined(separator: "\n\n")
    }
}

