//
//  BrowerView.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 17/02/2024.
//

import SwiftUI
import MultipeerConnectivity

struct ConnectionView: View {
    var body: some View {
        AdvertiserView {
            BrowserView()
        }
    }
}

#Preview {
    ConnectionView()
        .modelPreview()
}
