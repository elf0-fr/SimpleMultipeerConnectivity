//
//  DevicesView.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 24/02/2024.
//

import SwiftUI

struct DevicesView: View {
    var peers: [PeerDevice]
    var onTap: ((PeerDevice) -> Void)?
    
    var body: some View {
        ForEach(peers) { peer in
            DeviceRowView(deviceName: peer.peerId.displayName)
                .onTapGesture {
                    onTap?(peer)
                }
        }
    }
}

#Preview {
    let sessionModel = SessionModel.preview
    let advertiserModel = AdvertiserModel()
    let browserModel = BrowserModel()
    return DevicesView(peers: browserModel.availableDevices) { peer in
        browserModel.selectedPeer = peer
    }
    .model(
        sessionModel: sessionModel,
        advertiserModel: advertiserModel,
        browserModel: browserModel
    )
}
