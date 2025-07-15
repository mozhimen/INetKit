//
//  BandsInTownApi.swift
//  INetKitRetrofit2_Example
//
//  Created by Taiyou on 2025/7/8.
//
import INetKit_Retrofit
import SUtilKit_SwiftUI

final class Apis: Scope<Retroft> {
    @GET("/artists/{artist_name}")
    var findArtist: (FindArtistReq) async throws -> FindArtistRes?

    @GET("/artists/{artist_name}/events")
    var artistEvents: (ArtistEventsReq) async throws -> ArtistEventsRes?///*Either<*/ArtistEventsRes/*, ArtistEventsErrorResponse>*/
}

/**
 struct ArtistEventsErrorResponse: Error, Decodable {
     let errorMessage: String

     enum CodingKeys: String, CodingKey {
         case errorMessage = "Message"
     }
 }

 */
