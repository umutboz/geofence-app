//
//  NotificationView.swift
//  GeofenceTriggerApp
//
//  Created by umud on 7.12.2024.
//

import SwiftUI
import GeofenceTrigger

struct NotificationView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var notificationInfo: String = "No notification yet."
    var body: some View {
           VStack {
               Text(notificationInfo)
                   .padding()
                   .border(Color.gray, width: 1)
                   .frame(height: 100)

               Spacer()
               VStack{
                
                       if let coordinate = locationManager.lastKnownLocation {
                           Text("Latitude: \(coordinate.latitude)")
                           
                           Text("Longitude: \(coordinate.longitude)")
                       } else {
                           Text("Unknown Location")
                       }
               }
           }
           .padding()
           .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GeofenceNotification"))) { notification in
               if let userInfo = notification.userInfo,
                  let locationName = userInfo["locationName"] as? String,
                  let status = userInfo["status"] as? String {
                   notificationInfo = "Location: \(locationName), Status: \(status)"
               }
           }.onAppear{
               locationManager.checkLocationAuthorization()
           }
    }
}

#Preview {
    NotificationView()
}
