//
//  ContentViewModel.swift
//  INetKitRetrofit2_Example
//
//  Created by Taiyou on 2025/7/8.
//
import Foundation
import Combine
import INetKit_Retrofit

final class ContentViewModel: ObservableObject{

    @Published private(set) var loading = false
    @Published private(set) var details = ""
    
    @Published var error = nil as String?
    @Published var artist = "Molchat Doma"
    @Published var corruptAppId = false

    private let _api = Apis(retrofit: Retroft.Builder().setStrScheme("https").setStrHost("rest.bandsintown.com").build())
    
    //========================================================================>
    
    func find() {
        Task {
            loading = true
            details = ""

            do {
                let artistDetailsRes = try await _api.findArtist(FindArtistReq(
                    artistName: self.artist,
                    appId: "123"))

                //========================================================================>
                
                let articleEventsRes = try await self._api.artistEvents(ArtistEventsReq(
                    artistName: self.artist,
                    appId: self.corruptAppId ? "fffff" : "123",
                    date: "2023-05-05,2023-09-05"))

                //========================================================================>
                
//                switch articleEventsRes {
//                case .success(let events):
//                    details = "\(artistDetailsRes.description)\n\nEvents:\n\(events.description)"
//                case .error(let errorResponse):
//                    error = errorResponse.errorMessage
//                }
                if articleEventsRes != nil,articleEventsRes != nil {
                    self.details = "\(artistDetailsRes!.description)\n\nEvents:\n\(articleEventsRes!.description)"
                }
            } catch {
                print("print \(error.localizedDescription)")
                self.error = error.localizedDescription
            }

            loading = false
        }
    }
}



