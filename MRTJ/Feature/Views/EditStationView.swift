//
//  EditStationView.swift
//  FirebaseTesting
//
//  Created by Leo Harnadi on 21/07/23.
//

import SwiftUI

struct EditStationView: View {
    @EnvironmentObject var dataManager: StationViewModel
    
    var station: Station
    
    @State private var service: String = ""
    @State private var situation: String = ""
    @State private var cause: String = ""
    @State private var expectedDuration: String = ""
    @State private var live: String = ""
    
    var serviceList = ["Normal","Closed"]
    @State private var selectedService = 0
    
    var liveList = ["Not Too Busy","Busy","Very Busy","Extremely Busy"]
    @State private var selectedLive = 0
    
    @Binding var editingStation: Bool
    
    var body: some View {
        VStack {
            Picker("Service", selection: $selectedService) {
                ForEach(0..<serviceList.count, id: \.self) { index in
                    Text(serviceList[index]).tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onAppear {
                selectedService = serviceList.firstIndex(of: service) ?? 0
            }
            .onChange(of: selectedService) { newValue in
                service = serviceList[newValue]
            }
            
            Picker("Live Status", selection: $selectedLive) {
                ForEach(0..<liveList.count, id: \.self) { index in
                    Text(liveList[index]).tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onAppear {
                selectedLive = liveList.firstIndex(of: live) ?? 0
            }
            .onChange(of: selectedLive) { newValue in
                live = liveList[newValue]
            }
            TextField("Situation", text: $situation)
            TextField("Expected Duration", text: $expectedDuration)
            TextField("Cause", text: $cause)
            
            Spacer()
            Button {
                dataManager.updateStation(stationId: station.id, stationService: service, stationSituation: situation, stationCause: cause, stationExpectDuration: expectedDuration, stationLive: live, stationName: station.name)
                editingStation = false
            } label: {
                Text("Save")
            }
        }
        .onAppear {
            service = station.service
            situation = station.situation
            cause = station.cause
            expectedDuration = station.expectedDuration
            live = station.live
            
            
        }
        
    }
}

