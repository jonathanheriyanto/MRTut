//
//  StationGeneralView.swift
//  MRTJ
//
//  Created by Jonathan Heriyanto on 23/07/23.
//

import SwiftUI
import Lottie

struct StationGeneralView: View {
    
    @State var selectedOption = "Schedule"
    @EnvironmentObject var vm: StationViewModel
    @State var isPresented: Bool = false
    @State private var sheetContentHeight = CGFloat(0)
    
    @State private var tappedIndex: Int = 0
    let condensedBold = UIFont.systemFont(ofSize: 31, weight: .bold, width: .condensed)
    let condensedHeavy = UIFont.systemFont(ofSize: 24, weight: .heavy, width: .condensed)
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    //Background Image
                    ZStack{
                        Image("\(vm.station.id)")
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
                        
                        HStack {
                            Text(vm.station.name)
                                .font(Font(condensedBold))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                            Button {
                                isPresented.toggle()
                            } label: {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                            //ini nanti kayaknya harus ditambahin kondisi stasiun di database nya jadi sheet nya bisa beda dimunculin sesuai kondisi stasiunnya
                            .sheet(isPresented: $isPresented) {
                                if(vm.station.service == "Closed"){
                                    problemDetailSheet(station: "\(vm.station.name)", cause: "\(vm.station.cause)", duration: "\(vm.station.expectedDuration)")
                                        .background {
                                            GeometryReader { proxy in
                                                Color.clear
                                                    .task {
                                                        print("size = \(proxy.size.height)")
                                                        sheetContentHeight = proxy.size.height
                                                    }
                                            }
                                        }
                                        .presentationDetents([.height(sheetContentHeight+120)])
                                }
                                else{
                                    stationDetailSheet(station: "\(vm.station.name)")
                                        .background {
                                            GeometryReader { proxy in
                                                Color.clear
                                                    .task {
                                                        print("size = \(proxy.size.height)")
                                                        sheetContentHeight = proxy.size.height
                                                    }
                                            }
                                        }
                                        .presentationDetents([.height(sheetContentHeight-20)])
                                }
                            }
                        }
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
                                        
                                        Text(vm.station.live)
                                    }
                                    
                                    
                                    //Service Status
                                    HStack{
                                        Image(systemName: vm.station.service == "Normal" ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                                            .frame(width: 16, height: 16)
                                            .foregroundColor(vm.station.service == "Normal" ? .green : .red)
                                        Text(vm.station.service == "Normal" ? "Normal service" : "Temporary Closed")
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
                            ForEach(0..<vm.stations.count, id:\.self){ index in
                                if index == 0 {
                                    if tappedIndex == index {
                                        Image(AssetName.stationLeftActive)
                                            .zIndex(tappedIndex == index ? 1.0 : 0.0)
                                            .onTapGesture {
                                                tappedIndex = tappedIndex == index ? -1 : index
                                                vm.station = vm.stations[index]
                                            }
                                    }else {
                                        Image(AssetName.stationLeftInactive)
                                            .zIndex(tappedIndex == index ? 1.0 : 0.0)
                                            .onTapGesture {
                                                tappedIndex = tappedIndex == index ? -1 : index
                                                vm.station = vm.stations[index]
                                            }
                                    }
                                }else if index == vm.stations.count - 1 {
                                    if tappedIndex == index {
                                        Image(AssetName.stationRightActive)
                                            .padding(.trailing, 25)
                                            .zIndex(tappedIndex == index ? 1.0 : 0.0)
                                            .onTapGesture {
                                                tappedIndex = tappedIndex == index ? -1 : index
                                                vm.station = vm.stations[index]
                                            }
                                    }else{
                                        Image(AssetName.stationRightInactive)
                                            .padding(.trailing, 25)
                                            .zIndex(tappedIndex == index ? 1.0 : 0.0)
                                            .onTapGesture {
                                                tappedIndex = tappedIndex == index ? -1 : index
                                                vm.station = vm.stations[index]
                                            }
                                    }
                                    
                                }else{
                                    if index == tappedIndex{
                                        Image(AssetName.stationMiddleActive)
                                            .zIndex(1.0)
                                            .onTapGesture {
                                                tappedIndex = tappedIndex == index ? -1 : index
                                                vm.station = vm.stations[index]
                                            }
                                    }else{
                                        Image(AssetName.stationMiddleInactive)
                                            .zIndex(0.0)
                                            .onTapGesture {
                                                tappedIndex = tappedIndex == index ? -1 : index
                                                vm.station = vm.stations[index]
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
                    
                    
                    Group{
                        //SCHEDULE
                        if selectedOption == "Schedule"{
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
                            ScheduleListView(colorRectangle: Color(AssetName.green))
                                .position(x: geometry.size.width * 0.28, y: geometry.size.height / 1.16)
                            ScheduleListView(colorRectangle: Color(AssetName.navy))
                                .position(x: geometry.size.width * 0.74, y: geometry.size.height / 1.16)
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
                                        
                                        NavigationLink {
                                            PromoEventView(type: "promo",
                                                           epTitle: "ROTI’O BUY 4 GET 5",
                                                           epDesc: "Promo hanya berlaku untuk pembelian di tempat. *S&K berlaku",
                                                           epImage: "brotio",
                                                           epLocation: "Stasiun MRT Lebak Bulus",
                                                           epDate: "20 - 31 Juli 2023",
                                                           epTime: "06:00 - 21:00")
                                        } label: {
                                            Text("See More")
                                                .font(.system(size:13))
                                                .fontWeight(.light)
                                        }
                                        
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
                                .position(x: geometry.size.width * 0.5, y: geometry.size.height / 1.75)
                            }
                        }
                    }
                    .zIndex(-1)
                }
            }
        }
        
    }
}

struct stationGeneralView_Previews: PreviewProvider {
    static var previews: some View {
        StationGeneralView()
            .environmentObject(StationViewModel())
    }
}