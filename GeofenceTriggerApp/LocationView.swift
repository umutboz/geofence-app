//
//  ContentView.swift
//  GeofenceTriggerApp
//
//  Created by umud on 6.12.2024.
//

import SwiftUI
import GeofenceTrigger

struct LocationView: View {
    @StateObject private var locationManager = LocationManager()
        
        var body: some View {
            VStack {
                if let coordinate = locationManager.lastKnownLocation {
                    Text("Latitude: \(coordinate.latitude)")
                    
                    Text("Longitude: \(coordinate.longitude)")
                } else {
                    Text("Unknown Location")
                }
                
                
                Button("Get location") {
                    locationManager.checkLocationAuthorization()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
            
}

#Preview {
    
}

