//
//  NewEventView.swift
//  FirebaseTesting
//
//  Created by Leo Harnadi on 19/07/23.
// View tambah event baru

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
//            Spacer()
            
            Text("Add New Event/Promo")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(AssetName.navy))
            
            Group {
                HStack{
                    Text("Name")
                        .padding(.trailing, 5)
                    TextField("Name", text: $name)
                        .offset(x:50)
                }.padding(.bottom, 8)
                    
                HStack{
                    Text("Description")
                        .padding(.trailing, 5)
                    TextField("Description", text: $description)
                        .offset(x:8)
                    
                }.padding(.bottom, 8)
                
                HStack{
                    Text("Category")
                    Spacer()
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
                    .offset(x:-158)
                    .foregroundColor(.gray)
                }
                .padding(.bottom, 8)
                
                HStack{
                    Text("Station")
                    Spacer()
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
                    .offset(x: -147)
                    .foregroundColor(.gray)
                }
                .padding(.bottom, 8)
                
                DatePicker("Start Date", selection: $startDate)
                    .padding(.bottom, 8)
                
                DatePicker("End Date", selection: $endDate)
                    .padding(.bottom, 8)
                
                HStack{
                    Text("Location")
                        .padding(.trailing, 5)
                    TextField("Location", text: $location)
                        .offset(x:32)
                }
                .padding(.bottom, 8)
                
                HStack{
                    Text("Image")
                        .padding(.trailing, 5)
                    TextField("Image Name", text: $imageName)
                        .textInputAutocapitalization(.never)
                        .offset(x:50)
                }
               
                
            }
            
            Spacer()
            
            Button {
                dataManager.addEvent(eventName: name, eventStation: station, eventDescription: description, eventCategory: category, eventStartDate: startDate, eventEndDate: endDate, eventLocation: location, eventImageName: imageName)
                showPopUp = false
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
