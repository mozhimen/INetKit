//
//  BandsInTownApi.swift
//  INetKitRetrofit2_Example
//
//  Created by Taiyou on 2025/7/8.
//

final class BandsInTownApi: BandsInTownDomain {
    @Get("/artists/{artist_name}")
    var findArtist: (FindArtistRequest) async throws -> FindArtistResponse

    @Get("/artists/{artist_name}/events")
    var artistEvents: (ArtistEventsRequest) async throws
        -> Either<ArtistEventsResponse, ArtistEventsErrorResponse>
}
