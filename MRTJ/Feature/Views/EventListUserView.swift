//
//  EventListUserView.swift
//  MRTJ
//
//  Created by beni garcia on 23/07/23.
//

import SwiftUI

struct EventListUserView: View {
    @EnvironmentObject var vm: StationViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            ForEach(0..<vm.events.count, id: \.self) { index in
                if vm.events[index].station == vm.station.id {
                    ZStack(alignment: .leading){
                        //Event
                        HStack(alignment: .center, spacing: 12) {
                            Image(AssetName.rotio)
                                .padding(0)
                                .frame(width: 40, height: 40, alignment: .leading)
                                .cornerRadius(4)
                            
                            VStack(alignment: .leading){
                                Text("\(vm.events[index].name)")
                                    .font(.system(size:20))
                                    .fontWeight(.medium)
                                
                                Text("\(vm.events[index].category)")
                                    .font(.system(size:13))
                                    .fontWeight(.light)
                            }.padding(.trailing, 50)
                            Spacer()
                            NavigationLink {
                                PromoEventView(type: vm.events[index].category,
                                               epTitle: vm.events[index].name,
                                               epDesc: vm.events[index].description,
                                               epImage: "brotio",
                                               epLocation:  vm.events[index].location,
                                               epDate: "\(vm.getCurrentDate(date: vm.events[index].startDate)) - \(vm.getCurrentDate(date: vm.events[index].endDate))",
                                               epTime: "\(vm.getCurrentTimeDate(date: vm.events[index].startDate)) - \(vm.getCurrentTimeDate(date: vm.events[index].endDate))")
                                
                            } label: {
                                Text("See More")
                                    .font(.system(size:13))
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
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
                }
            }
        }
        .frame(height: 325)

    }
}

struct EventListUserView_Previews: PreviewProvider {
    static var previews: some View {
        EventListUserView()
            .environmentObject(StationViewModel())
    }
}
