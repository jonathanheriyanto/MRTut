//
//  iconDescView.swift
//  MRTJ
//
//  Created by Jonathan Heriyanto on 21/07/23.
//

import SwiftUI

struct iconDescView: View {
    var iconName: String
    var iconDesc: String
    
    var body: some View {
        HStack(alignment: .top){
            Image("\(iconName)")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
                .padding(.top, 1)
            Text("\(iconDesc)")
                .font(.callout)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
        }
        .frame(maxHeight: 45)
    }
}

struct iconDescView_Previews: PreviewProvider {
    static var previews: some View {
        iconDescView(
            iconName: "exita", iconDesc: "Jl. Ciputat Raya, \nSepolwan"
        )
    }
}
