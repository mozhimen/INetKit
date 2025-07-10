//
//  FindArtistResponse.swift
//  INetKitRetrofit2_Example
//
//  Created by Taiyou on 2025/7/8.
//

struct FindArtistRes: Decodable {
    let artistId: String?
    let name: String
    let url: String
    let imageUrl: String
    let thumbUrl: String
    let facebookPageUrl: String
    let mbid: String
    let trackerCount: Int
    let upcomingEventCount: Int

    enum CodingKeys: String, CodingKey {
        case artistId = "id"
        case name
        case url
        case imageUrl = "image_url"
        case thumbUrl = "thumb_url"
        case facebookPageUrl = "facebook_page_url"
        case mbid
        case trackerCount = "tracker_count"
        case upcomingEventCount = "upcoming_event_count"
    }
}
