//
//  SessionModel.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 18/02/2024.
//

import os
import MultipeerConnectivity

@Observable
class SessionModel: NSObject {
    let logger = Logger(subsystem: "com.romain-tirbisch.SimpleMultipeerConnectivity", category: "mc_session")
    let session: MCSession
    
    var peers: [PeerDevice] = []
    
    var connectedDevices: [PeerDevice] {
        peers.filter { peer in
            peer.state == .connected
        }
    }
    
    override init() {
        session = MCSession(peer: peer)
        super.init()
        
        session.delegate = self
    }
    
    func disconnect() {
        session.disconnect()
    }
}

// MARK: - MCSessionDelegate implementation
extension SessionModel: MCSessionDelegate {
    /// Trigger when the state of a peerId has changed.
    /// This method will be called on both device (Browser and Advertiser.
    func session(
        _ session: MCSession,
        peer peerID: MCPeerID,
        didChange state: MCSessionState
    ) {
        switch state {
        case .notConnected:
            logger.debug("disconnected from \(peerID.displayName)")
            guard let index = (peers.firstIndex { $0.peerId == peerID }) else {
                return
            }
            peers.remove(at: index)
        case .connecting:
            break
        case .connected:
            logger.debug("connected to \(peerID.displayName)")
            if let index = (peers.firstIndex { $0.peerId == peerID }) {
                peers[index].state = .connected
            }
            else {
                peers.append(PeerDevice(peerId: peerID, state: .connected))
            }
        @unknown default:
            fatalError("Unhandled MCSessionState")
        }
    }
    
    func session(
        _ session: MCSession,
        didReceive data: Data,
        fromPeer peerID: MCPeerID
    ) {
        receiveMessage(
            session,
            didReceive: data,
            fromPeer: peerID
        )
    }
    
    func session(
        _ session: MCSession,
        didReceive stream: InputStream,
        withName streamName: String,
        fromPeer peerID: MCPeerID
    ) {}
    
    func session(
        _ session: MCSession,
        didStartReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        with progress: Progress
    ) {}
    
    func session(
        _ session: MCSession,
        didFinishReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        at localURL: URL?,
        withError error: Error?
    ) {}
}

/// Example: A message application.
extension SessionModel {
    func send(message: String) {
        guard let data = message.data(using: .utf8) else {
            return
        }
        
//        try? session.send(
//            data,
//            toPeers: joinedPeer.map({ peer in
//                peer.peerId
//            }),
//            with: .reliable
//        )
    }
    
    func receiveMessage(
        _ session: MCSession,
        didReceive data: Data,
        fromPeer peerID: MCPeerID
    ) {
        
    }
}

// MARK: - Preview
extension SessionModel {
    static var preview: SessionModel {
        let session = SessionModel()
        session.peers.append(contentsOf: [
            PeerDevice(peerId: MCPeerID(displayName: "iPhone d'Elfo"), state: .available),
            PeerDevice(peerId: MCPeerID(displayName: "iPhone de Romain"), state: .connected),
            PeerDevice(peerId: MCPeerID(displayName: "iPhone d'Amélie"), state: .available),
            PeerDevice(peerId: MCPeerID(displayName: "iPad d'Elfo"), state: .connected)
        ])
        return session
    }
}
