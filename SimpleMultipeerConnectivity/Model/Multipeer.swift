//
//  Multipeer.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 16/02/2024.
//

import MultipeerConnectivity
import os

let mpLogger = Logger(subsystem: "com.romain-tirbisch.SimpleMultipeerConnectivity", category: "multiPeer")

/// Describe the app network protocol.
///
/// Bonjour service type: 1–15 characters long and valid characters include ASCII lowercase letters, numbers, and the hyphen, containing at least one letter and no adjacent hyphens.
/// This key is the same added to the Info.plist file.
///
/// ### Exemple:
/// a text chat app made by ABC company could use the service type "abc-txtchat".
let serviceType = "nearby-devices"

// Represent this device in a multipeer session.
let peer = MCPeerID(displayName: UIDevice.current.name)
