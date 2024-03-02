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
    @State private var text = ""
    
    var body: some View {
        NavigationStack {
            VStack{
                if !sessionModel.connectedDevices.isEmpty {
                    Form {
                        ForEach(sessionModel.connectedDevices) { peer in
                            Text(peer.peerId.displayName)
                        }
                        
                        if !sessionModel.lastSender.isEmpty {
                            Section {
                                Text("\(sessionModel.lastSender):")
                                Text(sessionModel.lastMessageReceived)
                            }
                        }
                        
                        Section {
                            TextField(
                                "Message",
                                text: $text,
                                prompt: Text("Message")
                            )
                            Button("Send Message") {
                                sessionModel.send(message: text)
                            }
                        }
                    }
                }
                else {
                    Text("No Device Connected")
                }
            }
            .navigationTitle("Session")
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
