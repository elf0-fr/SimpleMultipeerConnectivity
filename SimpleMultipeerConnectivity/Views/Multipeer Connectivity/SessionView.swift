//
//  SessionView.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 23/02/2024.
//

import SwiftUI

struct SessionView: View {
    @Environment(SessionModel.self) var sessionModel
    @State private var showNearByDevices = false
    
    var body: some View {
        NavigationStack {
            List(sessionModel.connectedDevices) { peer in
                Text(peer.peerId.displayName)
            }
            .toolbar() {
                Button() {
                    showNearByDevices = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showNearByDevices) {
                ConnectionView()
            }
        }
    }
}

#Preview {
    SessionView()
        .modelPreview()
}
