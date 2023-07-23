//
//  EventListView.swift
//  FirebaseTesting
//
//  Created by Leo Harnadi on 19/07/23.
// View Secara keseluruhan

import SwiftUI

struct EventListView: View {
    @EnvironmentObject var dataManager: StationViewModel
    @State var creatingNewEvent: Bool = false
    @State var readingEvent: Bool = false
    @State var openingStationDetails: Bool = false
    //    @State var tappedEvent: Event?
    //    @State var tappedEvent: Event = Event(id: "", name: "", station: "", description: "", category: "", startDate: Date(), endDate: Date())
    @State var filterStation: String = "ASEAN"
    @State var selectedStation: Station?
    @StateObject var tappedEvent: ObservedEvent = ObservedEvent()
    @State var editingStation: Bool = false
    
    var isAdmin: Bool
    
    var stationList = ["ASEAN", "Bendungan Hilir", "Blok A","Blok M BCA","Bundaran HI", "Cipete Raya", "Dukuh Atas BNI", "Fatmawati Indomaret", "Haji Nawi", "Istora Mandiri", "Lebak Bulus Grab", "Senayan", "Setiabudi Astra"]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()

                    VStack{
                        Text("Crowd Status")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(AssetName.navy))
//                        Text(
//                            dataManager.stations.first {$0.name == filterStation}?.live ?? "Station Crowd"
//                        )
                        if let selectedStation = dataManager.stations.first(where: { $0.name == filterStation }) {
                           Text(selectedStation.live)
                               .foregroundColor(crowdStatusColor(for: selectedStation.live))
                       } else {
                           Text("Station Crowd")
                       }
                    }
                    
                    Spacer()
                    
                    VStack{
                        Text("Service Status")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(AssetName.navy))
//                        Text(
//                            dataManager.stations.first {$0.name == filterStation}?.service ?? "Station Service"
//                        )
                        if let selectedStation = dataManager.stations.first(where: { $0.name == filterStation }) {
                            Text(selectedStation.service)
                                .foregroundColor(serviceStatusColor(for: selectedStation.service))
                        } else {
                            Text("Station Service")
                        }
                    }
                    Spacer()
                }
                .padding(10)
                .onTapGesture {
                    selectedStation = dataManager.stations.first  { $0.name == filterStation }
                    tappedEvent.station = selectedStation
                    
                    openingStationDetails.toggle()
                }
                
                if isAdmin {
                    Button {
                        selectedStation = dataManager.stations.first  { $0.name == filterStation }
                        tappedEvent.station = selectedStation
                        
                        editingStation.toggle()
                    } label: {
                        Text("Edit Station Status")
                            .frame(width: 200, height: 30)
                            .font(.system(.title3))
                            .background(Color(AssetName.navy))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .cornerRadius(8)
                    }

                }
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(stationList, id:\.self) { station in
                            Button {
                                filterStation = station
                            } label: {
                                Text(station)
                                    .foregroundColor(Color(AssetName.navy))
                                    .fontWeight(.medium)
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                    .padding(10)
                }
                List {
                    ForEach(dataManager.events, id: \.id) { event in
                        if event.station == filterStation {
                            HStack {
                                Text(event.category)
                                    .foregroundColor(event.category == "Event" ? .blue : .black)
                                    .fontWeight(.semibold)
                                Text(event.name)
                                
                            }
                            .onTapGesture {
                                tappedEvent.event = event
                                
                                readingEvent = true
                                
                                
                            }
                        }
                        
                        
                    }
                    .onDelete{indexSet in
                        let deletedEvent = indexSet.map { dataManager.events[$0] }.first
                        if let deletedEvent = deletedEvent {
                            dataManager.deleteEvent(eventId: deletedEvent.id)
                        }
                    }
                    
                    
                }
            }
            
            .navigationTitle(
                Text((filterStation))
            )
            .navigationBarItems(trailing: Button(action: {
                creatingNewEvent.toggle()
            }, label: {
                Text("Add Event/Promo")
                Image(systemName: "plus")
            }).disabled(!isAdmin)
                .opacity(isAdmin ? 1 : 0))
        }
        .sheet(isPresented: $creatingNewEvent) {
            NewEventView(showPopUp: $creatingNewEvent)
        }
        .sheet(isPresented: $readingEvent) {
            if let event = tappedEvent.event {
                EventDetailView(event: event, isAdmin: isAdmin)
            }
            //            EventDetailView(event: tappedEvent)
        }
        .sheet(isPresented: $openingStationDetails) {
            if let station = tappedEvent.station {
                StationDetailView(station: station)
            }
            //            EventDetailView(event: tappedEvent)
        }
        .sheet(isPresented: $editingStation) {
            if let station = tappedEvent.station {
                EditStationView(station: station, editingStation: $editingStation)
            }
            //            EventDetailView(event: tappedEvent)
        }
        
    }
    
    class ObservedEvent: ObservableObject {
        @Published var event: Event? = nil
        @Published var station: Station? = nil
    }
    
}

func crowdStatusColor(for crowdStatus: String) -> Color{
    switch crowdStatus{
    case "Extremely Busy":
        return .red
    case "Very Busy":
        return Color(AssetName.darkOrange)
    case "Busy":
        return .orange
    case "Not Too Busy":
        return Color(AssetName.darkGreen)
    default:
        return .primary
    }
}

func serviceStatusColor(for serviceStatus: String) -> Color {
    switch serviceStatus {
    case "Normal":
        return Color(AssetName.darkGreen)
    case "Closed":
        return .red
    default:
        return .primary
    }
}




