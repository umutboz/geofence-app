//
//  StartView.swift
//  GeofenceTriggerApp
//
//  Created by umud on 7.12.2024.
//

import SwiftUI
import GeofenceTrigger

struct StartView: View {
    @State private var isMonitoring = false
    let predefinedLocations = [
        LocationData(name: "Konum 1", coordinate: Coordinate(latitude: 37.331, longitude: -122.0307)),
        LocationData(name: "Konum 2", coordinate: Coordinate(latitude: 37.33005, longitude: -122.028600)),
        LocationData(name: "Konum 3", coordinate: Coordinate(latitude: 37.33003, longitude: -122.02975)),
        LocationData(name: "Konum 4", coordinate: Coordinate(latitude: 37.331049, longitude: -122.029149)),
        LocationData(name: "Konum 5", coordinate: Coordinate(latitude: 51.509980, longitude: -0.133700))
    ]
    @StateObject private var locationManager = LocationManager()
    @State private var notificationInfo: String = "No notification yet."
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                
                let geofence = Geofence.shared
                //change raidus and location size
                let config = GeofenceConfig(fixedSize: 5, geofenceRadius: 50)
                geofence.setConfig(config: config)
                geofence.startGeofenceMonitoring(locations: predefinedLocations)
                isMonitoring = true
                
            }) {
                Text("Start Geofence")
                    .padding()
                    .background(isMonitoring ? Color.green : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(isMonitoring)
            
            // NotificationView'e gecis icin NavigationLink
            MultilineTextView(text:$notificationInfo)
                .padding()
                .border(Color.gray, width: 1)
                .frame(height: 100)
            
            Spacer()
            if isMonitoring{
                
                /*
                 NavigationLink(destination: NotificationView()) {
                 Text("Go to Notifications")
                 .padding()
                 .foregroundColor(.blue)
                 .underline()
                 }
                 */
            }
            VStack{
                
                if let coordinate = locationManager.lastKnownLocation {
                    Text("Latitude: \(coordinate.latitude)")
                    
                    Text("Longitude: \(coordinate.longitude)")
                } else {
                    Text("Unknown Location")
                }
            }
            NavigationLink(destination: LocationView()) {
                Text("Current location")
                    .padding()
                    .foregroundColor(.blue)
                    .underline()
            }
            
            Spacer()
            Button(action: {
                Geofence.shared.stopGeofenceMonitoring()
                isMonitoring = false
            }) {
                Text("Stop Geofence")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GeofenceNotification"))) { notification in
            if let userInfo = notification.userInfo,
               let locationName = userInfo["locationName"] as? String,
               let status = userInfo["status"] as? String {
                notificationInfo += "\n Location: \(locationName), Status: \(status)"
            }
        }.onAppear{
            locationManager.checkLocationAuthorization()
        }
        
    }
}


#Preview {
    StartView()
}
struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
