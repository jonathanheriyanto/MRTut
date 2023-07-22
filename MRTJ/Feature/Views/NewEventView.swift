//
//  NewEventView.swift
//  FirebaseTesting
//
//  Created by Leo Harnadi on 19/07/23.
//

import SwiftUI

struct NewEventView: View {
    @EnvironmentObject var dataManager: StationViewModel
    @Binding var showPopUp: Bool
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var category: String = "Event"
    @State private var station: String = "ASEAN"
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var location: String = ""
    @State private var imageName: String = ""
    
    var stationList = ["ASEAN", "Bendungan Hilir", "Blok A","Blok M BCA","Bundaran HI", "Cipete Raya", "Dukuh Atas BNI", "Fatmawati Indomaret", "Haji Nawi", "Istora Mandiri", "Lebak Bulus Grab", "Senayan", "Setiabudi Astra"]
    @State private var selectedStation = 0
    
    var categoryList = ["Event","Promo"]
    @State private var selectedCategory = 0
    
    var body: some View {
        VStack {
            Spacer()
            
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
                dataManager.addEvent(eventName: name, eventStation: station, eventDescription: description, eventCategory: category, eventStartDate: startDate, eventEndDate: endDate, eventLocation: location, eventImageName: imageName)
                showPopUp = false
            } label: {
                Text("Save")
            }

        }
        .padding(25)
    }
}
//
//struct NewEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewEventView(showPopUp: true)
//            .environmentObject(DataManager())
//    }
//}
