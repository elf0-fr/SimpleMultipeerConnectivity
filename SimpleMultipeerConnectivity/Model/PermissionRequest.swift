//
//  PermissionRequest.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 17/02/2024.
//

import Foundation
import MultipeerConnectivity

struct PermissionRequest: Identifiable {
    let id = UUID()
    let peerId: MCPeerID
    /// Wether or not the selected peer accept the connection
    let onRequest: (Bool) -> Void
}
