//
//  BrowserViewModel.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 16/02/2024.
//

import SwiftUI
import MultipeerConnectivity
import os

@Observable
class BrowserModel : NSObject {
    let logger = Logger(subsystem: "com.romain-tirbisch.SimpleMultipeerConnectivity", category: "mc_browser")
    let browser: MCNearbyServiceBrowser
    var sessionModel: SessionModel?
    
    var availableDevices: [PeerDevice] {
        sessionModel?.peers.filter { peer in
            peer.state == .available
        } ?? []
    }
    
    /// The selected peer set by the browser device.
    var selectedPeer: PeerDevice? {
        didSet {
            connect()
        }
    }
    
    /// Whether this devise is browsing to find other devise.
    var isBrowsing: Bool = false {
        didSet {
            isBrowsing
            ? browser.startBrowsingForPeers()
            : browser.stopBrowsingForPeers()
        }
    }
    
    override init() {
        browser = MCNearbyServiceBrowser(
            peer: peer,
            serviceType: serviceType
        )
        super.init()
        browser.delegate = self
    }
    
    private func connect() {
        guard let sessionModel else {
            logger.fault("Session model is not set.")
            return
        }
        guard let selectedPeer else {
            logger.fault("Selected peer is null")
            return
        }
        guard !sessionModel.session.connectedPeers.contains(selectedPeer.peerId) else {
            logger.error("SelectedPeer is already connected")
            return
        }
        
        logger.debug("Send invitation to \(selectedPeer.peerId.displayName).")
        browser.invitePeer(
            selectedPeer.peerId,
            to: sessionModel.session,
            withContext: nil,
            timeout: 60
        )
    }
}

extension BrowserModel: MCNearbyServiceBrowserDelegate {
    /// This method is trigger when a device is found.
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        logger.info("Found device \(peerID.displayName)")
        if (sessionModel?.peers.firstIndex { $0.peerId == peerID }) == nil {
            sessionModel?.peers.append(PeerDevice(peerId: peerID, state: .available))
        }
    }
    
    /// This method is trigger when a device is lost.
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        logger.info("Lost device \(peerID.displayName)")
        sessionModel?.peers.removeAll { peer in
            peer.peerId == peerID && peer.state != .connected
        }
    }
}
