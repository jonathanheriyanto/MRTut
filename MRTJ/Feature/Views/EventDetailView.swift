//
//  EventDetailView.swift
//  FirebaseTesting
//
//  Created by Leo Harnadi on 19/07/23.
// Click yang promo test Asean

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
//                    Spacer()
                    //TAMBAH IMAGE + LOCATION
                    
                    Text("Edit Event/Promo Details")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(AssetName.navy))
                        .padding()
                    
                    Group {
                        
                        HStack{
                            Text("Name")
                                .padding(.trailing, 20)
                            
                            TextField("Name", text: $name)
                                .foregroundColor(.gray)
                                .offset(x: 20)
                                .padding(.leading, 7)
                        }.padding(.bottom, 8)
                        
                        HStack{
                            Text("Description")
                                .padding(.trailing, 7)
                            
                            TextField("Description", text: $description)
                                .foregroundColor(.gray)
                        }.padding(.bottom, 8)
                        
                        HStack{
                            Text("Category")
                                .offset(x: -15)
                            
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
                        }
                        .offset(x: -70)
                        .padding(.bottom, 8)
                        
                       
                        HStack{
                            Text("Station")
                                .offset(x: -15)
                                .padding(.trailing, 16)
                            
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
                        }
                        .offset(x: -70)
                        .padding(.bottom, 8)
                       
                        DatePicker("Start Date", selection: $startDate)
                            .offset(x: -3)
                            .padding(.bottom, 8)
                        
                        DatePicker("End Date", selection: $endDate)
                            .offset(x: -3)
                            .padding(.bottom, 8)
                        
                        HStack{
                            Text("Location")
                                .padding(.trailing, 15)
                            
                            TextField("Location", text: $location)
                                .padding(.leading, 15)
                                .foregroundColor(.gray)
                        }
                        .offset(x: -3)
                        .padding(.bottom, 8)
                        
                        HStack{
                            Text("Image")
                                .padding(.trailing, 23)
                            
                            TextField("Image Name", text: $imageName)
                                .textInputAutocapitalization(.never)
                                .padding(.leading, 23)
                                .foregroundColor(.gray)
                        }
                        .offset(x: -3)
                        .padding(.bottom, 8 )
                    }
                    
                    Spacer()
                    
                    Button {
                        dataManager.updateEvent(eventId: event.id, eventName: name, eventStation: station, eventDescription: description, eventCategory: category, eventStartDate: startDate, eventEndDate: endDate, eventLocation: location, eventImageName: imageName)
                        editingEvent = false
                    } label: {
                        Text("Save")
                            .frame(width: 150, height: 30)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .background(Color(AssetName.green))
                            .cornerRadius(8)
                    }
                    
                    
                } else {
                    Text(category)
                        .font(.system(.subheadline))
                        .foregroundColor(Color(AssetName.navy))
                        .fontWeight(.bold)
                    
                    Text(name)
                        .font(.system(.largeTitle))
                        .fontWeight(.heavy)
                        .padding(.bottom, 8)
                 
                        HStack{
                            Text("Station Name")
                            Text(station)
                                .font(.system(.body))
                                .foregroundColor(.gray)
                        }
                        .offset(x: -84)
                        .padding(.bottom, 8)
                        
                        HStack{
                            Text("Location")
                            Text(location)
                                .font(.system(.body))
                                .foregroundColor(.gray)
                        }
                        .offset(x: -111)
                        .padding(.bottom, 8)
                        
                        HStack{
                            Text("Start Date")
                                .multilineTextAlignment(.leading)
                            Text(startDate, style: .date)
                                .font(.system(.body))
                                .foregroundColor(.gray)
                        }
                        .offset(x: -73)
                        .padding(.bottom, 8)
                        
                        HStack{
                            Text("End Date")
                            Text(endDate, style: .date)
                                .font(.system(.body))
                                .foregroundColor(.gray)
                        }
                        .offset(x: -77)
                        .padding(.bottom, 8)
                        
                        HStack{
                            Text("Description")
                            Text(description)
                                .font(.system(.body))
                                .foregroundColor(.gray)
                        }
                        .offset(x: -90)
                        .padding(.bottom, 8)
                    
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
