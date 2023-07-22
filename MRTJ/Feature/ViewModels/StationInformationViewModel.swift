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
                    let expectedDuration = data["station_expected_duration"] as? String ?? ""
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
    
    //events
    func fetchEvent(){
        events.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("events")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let detail = data["name"] as? String ?? ""
                    
                    let event = Event(id: id, name: name, category: "", imageUrl: "", location: "")
                    self.events.append(event)
                }
            }
        }
    }
    
    func addEvent(eventName: String){
        let db = Firestore.firestore()
        var eventDetails = ["name": eventName]
        eventDetails["detail"] = "detail 123"
        
        let newEventRef = db.collection("Event").document()
            
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
        let eventRef = db.collection("Event").document(eventId)
        
        eventRef.delete { error in
            if let error = error {
                print("Error deleting event: \(error.localizedDescription)")
            } else {
                print("Event deleted successfully!")
            }
        }
        fetchEvent()
    }
    
    func updateEvent(eventId: String) {
        let db = Firestore.firestore()
        let eventRef = db.collection("Event").document(eventId)
        
        let newData = [
            "id": eventId,
            "name": "ini keupdate",
            "detail": "detailnya keupdate"
        ]
        
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
