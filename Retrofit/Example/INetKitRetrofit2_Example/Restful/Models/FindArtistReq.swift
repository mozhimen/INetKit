//
//  FindArtistRequest.swift
//  INetKitRetrofit2_Example
//
//  Created by Taiyou on 2025/7/8.
//
import INetKit_Retrofit

struct FindArtistReq {
    @Path("artist_name") var artistName: String = ""
    @Query("app_id") var appId: String = ""
}
