//
//  problemDetailSheet.swift
//  MRTJ
//
//  Created by Jonathan Heriyanto on 22/07/23.
//

import SwiftUI

struct problemDetailSheet: View {
    @Environment(\.dismiss) var dismiss
    var station: String
    var cause: String
    var duration: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32){
            HStack(){
                Image(AssetName.female)
                    .padding(.trailing)
                VStack(alignment: .leading, spacing: 12){
                    Text("We’re Sorry")
                        .font(.callout)
                        .fontWeight(.bold)
                    Text("\(station) is temporarily closed.")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            .padding(.init(top: 12, leading: 24, bottom: 0, trailing: 0))
            
            VStack(alignment: .leading){
                Text("Cause")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("\(cause)")
                    .font(.callout)
                    .multilineTextAlignment(.leading)
            }
            
            VStack(alignment: .leading){
                Text("Duration")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("\(duration)")
                    .font(.callout)
                    .multilineTextAlignment(.leading)
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

struct problemDetailSheet_Previews: PreviewProvider {
    static var previews: some View {
        problemDetailSheet(station: "Lebak Bulus", cause: "Station is currently cramped with people going to a concert at Gelora Bung Karno.", duration: "Expected to reopen at 17.05")
    }
}
