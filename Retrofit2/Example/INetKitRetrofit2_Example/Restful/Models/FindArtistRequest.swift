//
//  FindArtistRequest.swift
//  INetKitRetrofit2_Example
//
//  Created by Taiyou on 2025/7/8.
//
import Retrofit2

struct FindArtistRequest {
    @Path("artist_name") var artistName: String = ""
    @Query("app_id") var appId: String = ""
}
