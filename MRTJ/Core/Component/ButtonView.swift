//
//  SwiftUIView.swift
//  CobaComponent
//
//  Created by Jonathan Heriyanto on 20/07/23.
//

import SwiftUI

struct ButtonView: View {
    var buttonName: String
    
    var body: some View {
        Text("\(buttonName)")
            .font(.title3)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, minHeight: 44)
            .foregroundColor(.white)
            .background(.green)
            .cornerRadius(8)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(buttonName: "Okay, I Understand")
    }
}
