//
//  DeviceList.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 17/02/2024.
//

import SwiftUI

struct BrowserView: View {
    @Environment(SessionModel.self) var sessionModel
    @Environment(BrowserModel.self) var browserModel
    
    var body: some View {
        List {
            Section("Available Devices") {
                DevicesView(peers: browserModel.availableDevices) { peer in
                    browserModel.selectedPeer = peer
                }
            }
            
            if !sessionModel.connectedDevices.isEmpty {
                Section("Connected Devices") {
                    DevicesView(peers: sessionModel.connectedDevices, onTap: nil)
                }
            }
        }
        .onAppear(perform: {
            browserModel.isBrowsing = true
        })
        .onDisappear {
            browserModel.isBrowsing = false
        }
    }
}

#Preview {
    BrowserView()
        .modelPreview()
}
