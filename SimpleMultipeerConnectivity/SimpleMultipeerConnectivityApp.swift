//
//  SimpleMultipeerConnectivityApp.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 16/02/2024.
//

import SwiftUI

@main
struct SimpleMultipeerConnectivityApp: App {
    @State var sessionModel = SessionModel()
    @State var advertiserModel = AdvertiserModel()
    @State var browserModel = BrowserModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .model(
                    sessionModel: sessionModel,
                    advertiserModel: advertiserModel,
                    browserModel: browserModel
                )
        }
    }
}
