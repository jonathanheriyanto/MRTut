//
//  stationInformationView.swift
//  StationInformation
//
//  Created by Clarabella Lius on 19/07/23.
//

import SwiftUI
import Lottie

struct Station {
    let name: String
    let events: [Event]
}

struct Event {
    let name: String
    let category: String
    let imageUrl: String
    let location: String
}

struct StationInformationView: View {
    
    @State var selectedOption = "Schedule"
    @EnvironmentObject var vm: StationInformationViewModel
    private var stations = ["Lebak Bulus Grab", "Fatmawati Indomaret", "Cipete Raya", "Haji Nawi", "Blok A", "Blok M BCA", "ASEAN", "Senayan", "Istora Mandiri", "Bendungan Hilir", "Setiabudi Astra", "Dukuh Atas BNI", "Bundaran HI"]

    @State private var tappedIndex: Int = -1
    let condensedBold = UIFont.systemFont(ofSize: 31, weight: .bold, width: .condensed)
    let condensedHeavy = UIFont.systemFont(ofSize: 24, weight: .heavy, width: .condensed)
    
    var body: some View {
        GeometryReader{ geometry in
            
            ZStack{
                //Background Image
                ZStack{
                    Image(AssetName.stationLebakBulus)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .frame(width: 393, height: 193)
                        .position(x: geometry.size.width * 0.5, y:geometry.size.height / 7.5)
                        .background(Color.clear)
                    
                    Color(.black)
                        .opacity(0.2)
                        .frame(width: 393, height: 250)
                        .position(x:390, y:249)
                        .position(x: geometry.size.width * 0.5, y:geometry.size.height / 10)
                    
                    Text("LEBAK BULUS GRAB")
                        .font(Font(condensedBold))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 35)
                        .position(x: geometry.size.width * 0.35, y: geometry.size.height / 5.2)
                    
                    //Header Frame
                    ZStack{
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(AssetName.green), lineWidth: 2)
                            .background(RoundedRectangle(cornerRadius: 16).fill(.white))
                            .frame(width: 358, height: 72)
                            

                        VStack(alignment: .leading){

                            //Date and Time
                            HStack{
                                LottieIcon(animationName: AssetName.liveAnimation)
                                    .frame(width: 21, height: 21)
                                Text(vm.formattedDate())
                                + Text(", ")
                                + Text(vm.getCurrentTime())
                            }.font(.system(size: 13))
                            
                            HStack(spacing: 68){
                                //Crowd Status
                                HStack{
                                    Image(systemName: "person.3.fill")
                                        .frame(width: 28, height: 16)
            
                                    Text("Not Too Busy")
                                }
                                
                                
                                //Service Status
                                HStack{
                                    Image(systemName: "checkmark.circle.fill")
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(.green)
                                    Text("Normal service")
                                }
                                
                            }.font(.system(size:13))

                        }
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 24)
                        
                    }
                    .position(x: geometry.size.width * 0.5,y: geometry.size.height / 3.5)
                }
                
                
                //Scrollable Station Line
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: -11){
                        ForEach(stations.indices){ index in

                            if index == 0 {
                                if tappedIndex == index {
                                    Image(AssetName.stationLeftActive)
                                        .zIndex(tappedIndex == index ? 1.0 : 0.0)
                                        .onTapGesture {
                                            tappedIndex = tappedIndex == index ? -1 : index
                                        }
                                }else {
                                        Image(AssetName.stationLeftInactive)
                                            .zIndex(tappedIndex == index ? 1.0 : 0.0)
                                            .onTapGesture {
                                                tappedIndex = tappedIndex == index ? -1 : index
                                            }
                                }

                            }else if index == stations.count - 1 {
                                if tappedIndex == index {
                                    Image(AssetName.stationRightActive)
                                        .padding(.trailing, 25)
                                        .zIndex(tappedIndex == index ? 1.0 : 0.0)
                                        .onTapGesture {
                                            tappedIndex = tappedIndex == index ? -1 : index
                                        }
                                }else{
                                    Image(AssetName.stationRightInactive)
                                        .padding(.trailing, 25)
                                        .zIndex(tappedIndex == index ? 1.0 : 0.0)
                                        .onTapGesture {
                                            tappedIndex = tappedIndex == index ? -1 : index
                                        }
                                }
                                
                            }else{
                                if index == tappedIndex{
                                    Image(AssetName.stationMiddleActive)
                                        .zIndex(1.0)
                                        .onTapGesture {
                                            tappedIndex = tappedIndex == index ? -1 : index
                                        }
                                }else{
                                    Image(AssetName.stationMiddleInactive)
                                        .zIndex(0.0)
                                        .onTapGesture {
                                            tappedIndex = tappedIndex == index ? -1 : index
                                        }
                                }
                            }
                        }
                    }
                }
                .position(x: geometry.size.width * 0.55, y: geometry.size.height / 2.55)
                .padding(.trailing)
                
                //Picker
                Picker("Options", selection: $selectedOption){
                    Text("Schedule").tag("Schedule")
                    Text("Event").tag("Event")
                }
                .frame(width: 360)
                .pickerStyle(SegmentedPickerStyle())
                .position(x: geometry.size.width * 0.5, y: geometry.size.height / 2.1)
                
                //Direction header
                HStack{
                        Text("To Lebak Bulus")
                        .padding(.trailing, 10)
                            
                        Image(AssetName.leftArrow)
                            .padding(.leading, 22)

                        Image(AssetName.rightArrow)
                            .padding(.trailing, 22)
                    
                        Text ("To Bundaran HI")
                        
                }
                .position(x: geometry.size.width * 0.5, y: geometry.size.height / 1.85)
                
                Group{
                    //SCHEDULE
                    if selectedOption == "Schedule"{
                        VStack{ //stacking jadwal
                            ZStack(alignment: .leading){ //setiap komponen rectangle
                                //Schedule
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(AssetName.green), lineWidth: 2)
                                    .background(RoundedRectangle(cornerRadius: 16).fill(.white))
                                    .frame(width: 171, height: 64)

                                VStack{
                                    Text("17:01")
                                        .font(Font(condensedHeavy))

                                    Text("in 1 minute")
                                        .font(.system(size: 13))
                                        .opacity(0.5)
                                        .padding(.leading, 7)
                                }.padding(.horizontal, 8)
                            }
                            .position(x: geometry.size.width * 0.27, y: geometry.size.height / 1.6)

                            //Rectangle kedua
                            ZStack(alignment: .leading){ //setiap komponen rectangle
                                //Schedule
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(AssetName.green), lineWidth: 2)
                                    .background(RoundedRectangle(cornerRadius: 16).fill(.white))
                                    .frame(width: 171, height: 64)

                                VStack{
                                    Text("17:01")
                                        .font(Font(condensedHeavy))
                                        .font(.system(size: 24))

                                    Text("in 1 minute")
                                        .font(.system(size: 13))
                                        .opacity(0.5)
                                        .padding(.leading, 7)
                                }.padding(.horizontal, 8)
                            }
                            .position(x: geometry.size.width * 0.27, y: geometry.size.height / 4.5)
                        }
                    //EVENT
                    }else if selectedOption == "Event"{
                        VStack{
                            ZStack(alignment: .leading){
                                //Event
                                HStack(alignment: .center, spacing: 12) {
                                    Image(AssetName.rotio)
                                        .padding(0)
                                        .frame(width: 40, height: 40, alignment: .leading)
                                        .cornerRadius(4)
                                   
                                        VStack(alignment: .leading){
                                            Text("Roti'O Buy 4 Get 5")
                                                .font(.system(size:20))
                                                .fontWeight(.medium)
                                            
                                            Text("Promotion")
                                                .font(.system(size:13))
                                                .fontWeight(.light)
                                        }.padding(.trailing, 50)
                                        
                                        Text("See More")
                                            .font(.system(size:13))
                                            .fontWeight(.light)
                                    

                                }
                                .padding(8)
                                .frame(width: 361, height: 64, alignment: .leading)
                                .background(.white)
                                .cornerRadius(8)
                                .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.06), radius: 1, x: 0, y: 1)
                                .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.1), radius: 1.5, x: 0, y: 1)
                                .overlay(
                                  RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.93, green: 0.93, blue: 0.94), lineWidth: 1)
                                )
                            }
                            .position(x: geometry.size.width * 0.5, y: geometry.size.height / 1.6)
                        }
                    }
                }
                
                
                            
            }
        }
       
    }
}

struct stationInformationView_Previews: PreviewProvider {
    static var previews: some View {
        StationInformationView()
            .environmentObject(StationInformationViewModel())
    }
}


