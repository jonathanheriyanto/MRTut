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
            
            Text("Edit Station Status")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(AssetName.navy))
                .padding()
            
            HStack{
                Text("Service Status")
                    .padding(.trailing, 1)
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
            }
            .offset(x: -72)
            .padding(.bottom, 8)
            
            HStack{
                Text("Crowd Status")
                    .padding(.trailing, 10)
                
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
            }
            .offset(x: -43)
            .padding(.bottom, 8)
            
            HStack{
                Text("Situation")
                    .padding(.trailing, 15)
                
                TextField("Situation", text: $situation)
                    .padding(.leading, 5)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 12)
            .padding(.bottom, 8)
            
            HStack{
                Text("Expected Duration")
                    .padding(.trailing, 10)
                
                TextField("Expected Duration", text: $expectedDuration)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 12)
            .padding(.bottom, 8)
            
            HStack{
                Text("Cause")
                    .padding(.trailing, 10)
                
                TextField("Cause", text: $cause)
                    .foregroundColor(.gray)
            }.padding(.leading, 12)
            
            Spacer()
            Button {
                dataManager.updateStation(stationId: station.id, stationService: service, stationSituation: situation, stationCause: cause, stationExpectDuration: expectedDuration, stationLive: live, stationName: station.name)
                editingStation = false
            } label: {
                Text("Save")
                    .frame(width: 150, height: 30)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .background(Color(AssetName.green))
                    .cornerRadius(8)
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

