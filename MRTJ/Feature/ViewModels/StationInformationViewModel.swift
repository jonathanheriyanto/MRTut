//
//  stationInformationViewModel.swift
//  StationInformation
//
//  Created by Clarabella Lius on 20/07/23.
//

import Foundation
import Firebase

class StationViewModel: ObservableObject{
    @Published var events: [Event] = []
    @Published var stations: [Station] = []
    @Published var station: Station = Station(id: "dummy", name: "dummy", live: "dummy", expectedDuration: "dummy", service: "dummy", cause: "dummy", situation: "dummy", events: [])
    @Published var sortedStations: [Station] = []
    
    init(){
        fetchEvent()
        fetchStations()
//        DispatchQueue.main.asyncAfter(deadline: .now()+2){
//            self.sortStation()
//        }
    }
    //stations
    func fetchStations(){
        self.stations.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("train_stations")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let name = data["station_name"] as? String ?? ""
                    let live = data["station_live"] as? String ?? ""
                    let expectedDuration = data["station_expect_duration"] as? String ?? ""
                    let service = data["station_service"] as? String ?? ""
                    let cause = data["station_cause"] as? String ?? ""
                    let situation = data["station_situation"] as? String ?? ""
                    
                    let station = Station(id: id, name: name, live: live, expectedDuration: expectedDuration, service: service, cause: cause, situation: situation, events: [])
                    self.stations.append(station)
                }
            }
        }
        
    }
    
    func sortStation(){
        sortedStations.append(self.stations.first(where: {$0.id == "LebakBulus"})!)
        sortedStations.append(self.stations.first(where: {$0.id == "Fatmawati"})!)
        sortedStations.append(self.stations.first(where: {$0.id == "CipeteRaya"})!)
        sortedStations.append(self.stations.first(where: {$0.id == "HajiNawi"})!)
        sortedStations.append(self.stations.first(where: {$0.id == "BlokA"})!)
        sortedStations.append(self.stations.first(where: {$0.id == "BlokM"})!)
        sortedStations.append(self.stations.first(where: {$0.id == "ASEAN"})!)
        sortedStations.append(self.stations.first(where: {$0.id == "Senayan"})!)
        sortedStations.append(self.stations.first(where: {$0.id == "IstoraMandiri"})!)
        sortedStations.append(self.stations.first(where: {$0.id == "BendunganHilir"})!)
        sortedStations.append(self.stations.first(where: {$0.id == "Setiabudi"})!)
        sortedStations.append(self.stations.first(where: {$0.id == "DukuhAtas"})!)
        sortedStations.append(self.stations.first(where: {$0.id == "BundaranHI"})!)
        stations.removeAll()
        stations = sortedStations
        
    }
    
    func updateStation(stationId: String, stationService: String, stationSituation: String, stationCause: String, stationExpectDuration: String, stationLive: String, stationName: String) {
        let db = Firestore.firestore()
        let stationRef = db.collection("train_stations").document(stationId)
        
        let newData = ["station_cause": stationCause,"station_expect_duration": stationExpectDuration, "station_live":stationLive, "station_service":stationService, "station_situation":stationSituation, "station_name":stationName]
        
        stationRef.updateData(newData) { error in
            if let error = error {
                print("Error updating event: \(error.localizedDescription)")
            } else {
                print("Event updated successfully!")
            }
        }
        fetchStations()
        
    }
    
    //events
    func fetchEvent() {
        events.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("events")
        ref.getDocuments { snapshot, error in
            guard error == nil else  {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let station = data["station"] as? String ?? ""
                    let location = data["location"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let category = data["category"] as? String ?? ""
                    let startDate = (data["startDate"] as? Timestamp)?.dateValue() ?? Date()
                    let endDate = (data["endDate"] as? Timestamp)?.dateValue() ?? Date()
                    let imageName = data["imageName"] as? String ?? ""
                    
                    let event = Event(id: id, name: name, station: station, description: description, category: category, startDate: startDate, endDate: endDate, location: location, imageName: imageName)
                    self.events.append(event)
                    
                }
            }
        }
    }
    
    func addEvent(eventName: String, eventStation: String, eventDescription: String, eventCategory: String, eventStartDate: Date, eventEndDate: Date, eventLocation: String, eventImageName: String){
        let db = Firestore.firestore()
        var eventDetails = ["name": eventName, "station": eventStation, "description": eventDescription, "category": eventCategory, "startDate": eventStartDate, "endDate": eventEndDate, "location": eventLocation, "imageName" : eventImageName] as [String : Any]
        
        let newEventRef = db.collection("events").document()
        
        eventDetails["id"] = newEventRef.documentID
        
        newEventRef.setData(eventDetails) { error in
            if let error = error {
                print("Error adding event: \(error.localizedDescription)")
            } else {
                print("Event added successfully!")
            }
        }
        fetchEvent()
    }
    
    func deleteEvent(eventId: String) {
        let db = Firestore.firestore()
        let eventRef = db.collection("events").document(eventId)
        
        eventRef.delete { error in
            if let error = error {
                print("Error deleting event: \(error.localizedDescription)")
            } else {
                print("Event deleted successfully!")
            }
        }
        fetchEvent()
    }
    
    func updateEvent(eventId: String, eventName: String, eventStation: String, eventDescription: String, eventCategory: String, eventStartDate: Date, eventEndDate: Date, eventLocation: String, eventImageName: String) {
        let db = Firestore.firestore()
        let eventRef = db.collection("events").document(eventId)
    
        let newData = ["name": eventName, "station": eventStation, "description": eventDescription, "category": eventCategory, "startDate": eventStartDate, "endDate": eventEndDate, "location": eventLocation, "imageName": eventImageName] as [String : Any]
        
        eventRef.updateData(newData) { error in
            if let error = error {
                print("Error updating event: \(error.localizedDescription)")
            } else {
                print("Event updated successfully!")
            }
        }
        fetchEvent()
        
    }
    
    func getCurrentTime() -> String{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let timeString = formatter.string(from: Date())
        return timeString
    }
    
    func formattedDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        let dateString = formatter.string(from: Date())
        return dateString
    }
    
}
