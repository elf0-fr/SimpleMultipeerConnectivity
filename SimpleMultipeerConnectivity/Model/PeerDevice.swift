//
//  PeerDevice.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 17/02/2024.
//

import MultipeerConnectivity

enum PeerState {
    case available
    case connected
}

struct PeerDevice: Identifiable, Hashable {
    let id = UUID()
    let peerId: MCPeerID
    var state: PeerState
}
