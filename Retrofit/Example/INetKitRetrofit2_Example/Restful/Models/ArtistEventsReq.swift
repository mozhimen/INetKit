//
//  ArtistEventsRequest.swift
//  INetKitRetrofit2_Example
//
//  Created by Taiyou on 2025/7/8.
//
import INetKit_Retrofit
import Foundation

struct ArtistEventsReq{
    @Path("artist_name") var artistName: String = ""
    @Query("app_id") var appId: String = ""
    @Query var date: String
}
