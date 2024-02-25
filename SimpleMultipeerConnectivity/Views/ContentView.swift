//
//  ContentView.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 16/02/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        SessionView()
    }
}

#Preview("Preview") {
    ContentView()
        .modelPreview()
}

#Preview("Running") {
    ContentView()
        .model()
}
