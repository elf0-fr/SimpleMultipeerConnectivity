//
//  AdvertiserView.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 24/02/2024.
//

import SwiftUI

struct AdvertiserView<Label>: View where Label: View {
    @Environment(BrowserModel.self) var browserModel
    @Environment(AdvertiserModel.self) var advertiserModel
    
    @ViewBuilder var browserView: () -> Label
    
    var requestDeviceName: String {
        advertiserModel.permissionRequest?.peerId.displayName ?? ""
    }
    
    var body: some View {
        @Bindable var advertiseModel = advertiserModel
        
        NavigationStack {
            browserView()
            .toolbar {
                Toggle(
                    "Be discoverable by others",
                    isOn: $advertiseModel.isAdvertised
                )
                .toggleStyle(.switch)
            }
        }
        .alert(
            "Do you want to join \(requestDeviceName)?",
            isPresented: $advertiseModel.showPermissionAlert
        ) {
            Button("No", role: .cancel) {
                advertiseModel.permissionRequest?.onRequest(false)
            }
            
            Button("Yes") {
                advertiseModel.permissionRequest?.onRequest(true)
            }
        }
        .onDisappear {
            advertiserModel.isAdvertised = false
        }
    }
}

#Preview {
    AdvertiserView {
        BrowserView()
    }
    .modelPreview()
}
