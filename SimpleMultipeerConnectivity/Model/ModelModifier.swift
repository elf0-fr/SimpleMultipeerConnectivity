//
//  ModelModifier.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 25/02/2024.
//

import SwiftUI

struct ModelModifier: ViewModifier {
    var sessionModel: SessionModel
    var advertiserModel: AdvertiserModel
    var browserModel: BrowserModel
    
    func body(content: Content) -> some View {
        content
            .environment(sessionModel)
            .environment(advertiserModel)
            .environment(browserModel)
            .onAppear {
                advertiserModel.sessionModel = sessionModel
                browserModel.sessionModel = sessionModel
            }
    }
}

extension View {
    func model(
        sessionModel: SessionModel,
        advertiserModel: AdvertiserModel,
        browserModel: BrowserModel
    ) -> some View {
        modifier(
            ModelModifier(
                sessionModel: sessionModel,
                advertiserModel: advertiserModel,
                browserModel: browserModel
            )
        )
    }
    
    func model() -> some View {
        let sessionModel = SessionModel()
        let advertiserModel = AdvertiserModel()
        let browserModel = BrowserModel()
        return model(
            sessionModel: sessionModel,
            advertiserModel: advertiserModel,
            browserModel: browserModel
        )
    }
    
    func modelPreview() -> some View {
        let sessionModel = SessionModel.preview
        let advertiserModel = AdvertiserModel()
        let browserModel = BrowserModel()
        return model(
            sessionModel: sessionModel,
            advertiserModel: advertiserModel,
            browserModel: browserModel
        )
    }
}
