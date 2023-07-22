//
//  EventDetailView.swift
//  FirebaseTesting
//
//  Created by Leo Harnadi on 19/07/23.
//

import SwiftUI

struct EventDetailView: View {
    @EnvironmentObject var dataManager: StationViewModel
    @State var editingEvent: Bool = false
    
    var event: Event
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var category: String = ""
    @State private var station: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var location: String = ""
    @State private var imageName: String = ""
    
    var stationList = ["ASEAN", "Bendungan Hilir", "Blok A","Blok M BCA","Bundaran HI", "Cipete Raya", "Dukuh Atas BNI", "Fatmawati Indomaret", "Haji Nawi", "Istora Mandiri", "Lebak Bulus Grab", "Senayan", "Setiabudi Astra"]
    @State private var selectedStation = 0
    
    var categoryList = ["Event","Promo"]
    @State private var selectedCategory = 0
    
    var isAdmin: Bool
    
    var body: some View {
        
        NavigationView {
            VStack{
                if editingEvent {
                    Spacer()
                    //TAMBAH IMAGE + LOCATION
                    Group {
                        TextField("Name", text: $name)
                        TextField("Description", text: $description)
                        
                        Picker("Category", selection: $selectedCategory) {
                            ForEach(0..<categoryList.count, id: \.self) { index in
                                Text(categoryList[index]).tag(index)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onAppear {
                            selectedCategory = categoryList.firstIndex(of: category) ?? 0
                        }
                        .onChange(of: selectedCategory) { newValue in
                            category = categoryList[newValue]
                        }
                        
                        Picker("Station", selection: $selectedStation) {
                            ForEach(0..<stationList.count, id: \.self) { index in
                                Text(stationList[index]).tag(index)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onAppear {
                            selectedStation = stationList.firstIndex(of: station) ?? 0
                        }
                        .onChange(of: selectedStation) { newValue in
                            station = stationList[newValue]
                        }
                        DatePicker("Start Date", selection: $startDate)
                        DatePicker("End Date", selection: $endDate)
                        TextField("Location", text: $location)
                        TextField("Image Name", text: $imageName)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Spacer()
                    
                    Button {
                        dataManager.updateEvent(eventId: event.id, eventName: name, eventStation: station, eventDescription: description, eventCategory: category, eventStartDate: startDate, eventEndDate: endDate, eventLocation: location, eventImageName: imageName)
                        editingEvent = false
                    } label: {
                        Text("Save")
                    }
                } else {
                    Text(category)
                        .font(.system(.title2))
                    Text(name)
                        .font(.system(.largeTitle))
                    Text(station)
                        .font(.system(.title))
                    Text(location)
                        .font(.system(.title))
                    Text(startDate, style: .date)
                        .font(.system(.caption))
                    Text(endDate, style: .date)
                        .font(.system(.caption))
                    Text(description)
                        .font(.system(.body))
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 500, height: 500)
                }
                
            }
            //            .navigationTitle(event.name)
            .navigationBarItems(trailing: Button(action: {
                editingEvent.toggle()
            }, label: {
                Text(editingEvent ? "Cancel" : "Edit")
            }).disabled(!isAdmin)
                .opacity(isAdmin ? 1 : 0))
            .padding(25)
        }
        .onAppear {
            name = event.name
            description = event.description
            category = event.category
            station = event.station
            startDate = event.startDate
            endDate = event.endDate
            location = event.location
            imageName = event.imageName
        }
    }
}


//struct EventDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetailView()
//    }
//}
