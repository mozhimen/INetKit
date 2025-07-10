//
//  BandsInTownApi.swift
//  INetKitRetrofit2_Example
//
//  Created by Taiyou on 2025/7/8.
//
import Retrofit2

final class Apis: Scope {
    @GET("/artists/{artist_name}")
    var findArtist: (FindArtistReq) async throws -> FindArtistRes

    @GET("/artists/{artist_name}/events")
    var artistEvents: (ArtistEventsReq) async throws
        -> /*Either<*/ArtistEventsRes/*, ArtistEventsErrorResponse>*/
}
