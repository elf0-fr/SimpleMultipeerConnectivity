//
//  DeviceRowView.swift
//  SimpleMultipeerConnectivity
//
//  Created by Elfo on 17/02/2024.
//

import SwiftUI

struct DeviceRowView: View {
    var deviceName: String
    
    var body: some View {
        HStack {
            Image(systemName: "iphone.gen1")
                .imageScale(.large)
                .foregroundStyle(Color.accentColor)
            
            Text(deviceName)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    DeviceRowView(deviceName: "iPhone de Elfo")
}
