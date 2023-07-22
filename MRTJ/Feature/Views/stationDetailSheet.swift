//
//  stationDetailSheet.swift
//  MRTJ
//
//  Created by Jonathan Heriyanto on 21/07/23.
//

import SwiftUI

struct stationDetailSheet: View {
    @Environment(\.dismiss) var dismiss
    var station: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32){
            HStack{
                Image(AssetName.male)
                VStack(alignment: .leading, spacing: 12){
                    Text("Welcome")
                        .font(.callout)
                        .fontWeight(.bold)
                    Text("\(station) is currently not too busy.")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            
            //exit gate
            VStack(alignment: .leading){
                Text("Exits")
                    .font(.title)
                    .fontWeight(.semibold)
                HStack{
                    VStack(alignment: .leading){
                        iconDescView(iconName: "exita", iconDesc: "Jl. Ciputat Raya, \nSepolwan")
                        iconDescView(iconName: "exitb", iconDesc: "Jl. Sapta Taruna Baru, Komp. PU")
                        iconDescView(iconName: "exitc", iconDesc: "Jl. R. A. Kartini, Carrefour")
                    }
                    Spacer()
                    VStack(alignment: .leading){
                        iconDescView(iconName: "exitd", iconDesc: "Halte Transjakarta Lebak Bulus")
                        iconDescView(iconName: "exite", iconDesc: "Jl. Pasar Jumat, Depo MRT Lebak Bulus")
                        iconDescView(iconName: "exitf", iconDesc: "Jl. Lebak Lestari, Poins Square")
                    }
                }
            }
            
            //facilities
            VStack(alignment: .leading){
                Text("Facilities")
                    .font(.title)
                    .fontWeight(.semibold)
                HStack(spacing: 35){
                    VStack(alignment: .leading){
                        iconDescView(iconName: "stairs", iconDesc: "Stairs")
                        iconDescView(iconName: "escalator", iconDesc: "Escalator")
                        iconDescView(iconName: "elevator", iconDesc: "Elevator")
                        iconDescView(iconName: "mentoilet", iconDesc: "Men's Toilet")
                        iconDescView(iconName: "womantoilet", iconDesc: "Women's Toilet")
                        iconDescView(iconName: "disabledtoilet", iconDesc: "Disabled Toilet")
                    }
                    VStack(alignment: .leading){
                        iconDescView(iconName: "nurseryroom", iconDesc: "Nursery Room")
                        iconDescView(iconName: "fareadj", iconDesc: "Fare Adjustment")
                        iconDescView(iconName: "ticketbox", iconDesc: "Ticket Box")
                        iconDescView(iconName: "retail", iconDesc: "Retail")
                        iconDescView(iconName: "firstaid", iconDesc: "First Aid")
                        iconDescView(iconName: "prayerroom", iconDesc: "Prayer Room")
                    }
                }
            }
            Spacer()
            Button {
                dismiss()
            } label: {
                ButtonView(buttonName: "Okay, I Understand")
                
            }
        }
        .padding()
    }
}

struct stationDetailSheet_Previews: PreviewProvider {
    static var previews: some View {
        stationDetailSheet(station: "Lebak Bulus Grab")
    }
}
