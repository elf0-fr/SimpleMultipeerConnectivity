//
//  AdvertiserViewModel.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 16/02/2024.
//

import SwiftUI
import MultipeerConnectivity
import os

@Observable
class AdvertiserModel : NSObject {
    let logger = Logger(subsystem: "com.romain-tirbisch.SimpleMultipeerConnectivity", category: "mc_advertiser")
    let advertiser: MCNearbyServiceAdvertiser
    var sessionModel: SessionModel?
    
    var showPermissionAlert: Bool = false
    
    var permissionRequest: PermissionRequest? {
        didSet {
            if permissionRequest != nil {
                showPermissionAlert = true
            }
        }
    }
    
    /// Whether or not this devise is visible for other devices.
    var isAdvertised: Bool = false {
        didSet {
            isAdvertised
            ? advertiser.startAdvertisingPeer()
            : advertiser.stopAdvertisingPeer()
        }
    }
    
    override init() {
        advertiser = MCNearbyServiceAdvertiser(
            peer: peer,
            discoveryInfo: nil,
            serviceType: serviceType
        )
        super.init()
        advertiser.delegate = self
    }
}

extension AdvertiserModel: MCNearbyServiceAdvertiserDelegate {
    /// This method is trigger when an invitation from another device is received.
    func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didReceiveInvitationFromPeer peerID: MCPeerID,
        withContext context: Data?,
        invitationHandler: @escaping (Bool, MCSession?) -> Void
    ) {
        logger.debug("Receive invitation from \(peerID.displayName)")
        permissionRequest = PermissionRequest(
            peerId: peerID,
            onRequest: { [weak self] permission in
                invitationHandler(permission, permission ? self?.sessionModel?.session : nil)
            }
        )
    }
}
