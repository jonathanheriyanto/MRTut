//
//  StationDetailView.swift
//  FirebaseTesting
//
//  Created by Leo Harnadi on 21/07/23.
//

import SwiftUI

struct StationDetailView: View {
    @EnvironmentObject var dataManager: StationViewModel
    var station: Station
    
    var body: some View {
        if station.service == "Normal" {
            Text("All good")
        } else {
            VStack {
                Text(station.cause)
                Text(station.expectedDuration)
                Text(station.situation)
            }
            
        }
    }
}

