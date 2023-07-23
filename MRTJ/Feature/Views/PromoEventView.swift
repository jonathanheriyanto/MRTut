//
//  PromoEventView.swift
//  CobaComponent
//
//  Created by Jonathan Heriyanto on 20/07/23.
//

import SwiftUI

struct PromoEventView: View {
    var type: String
    var epTitle: String
    var epDesc: String
    var epImage: String
    var epLocation: String
    var epDate: String
    var epTime: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(epTitle)")
                .font(.title)
                .fontWeight(.heavy)
            Image("\(epImage)")
            
            VStack(alignment: .leading,spacing: 14){
                HStack(spacing: 12){
                    Image(systemName: "location.circle.fill")
                    Text("\(epLocation)")
                        .font(.callout)
                }
                HStack(spacing: 12){
                    Image(systemName: "calendar.circle.fill")
                    Text("\(epDate)")
                        .font(.callout)
                }
                HStack(spacing: 12){
                    Image(systemName: "clock.circle.fill")
                    Text("\(epTime)")
                        .font(.callout)
                }
            }
            .padding(.top)
            
            Text("\(epDesc)")
                .font(.callout)
                .padding(.top)
            
            Spacer()
            
            if(type == "event"){
                ButtonView(buttonName: "Buy Ticket")
            }
        }
        .padding()
    }
}

struct PromoEventView_Previews: PreviewProvider {
    static var previews: some View {
        PromoEventView(
            type: "event",
            epTitle: "WAKTU INDONESIA BERDANSA FESTIVAL",
            epDesc: "WIB merupakan festival musik nasional berskala besar yang diadakan di ruang-ruang publik kota metropolitan di Indonesia dengan membawa kampanye positif bagi kaum muda di Indonesia. Sekumpulan anak muda dan pekerja di industri kreatif dari berbagai latar belakang yang berbeda namun memiliki visi dan misi yang sama, yaitu menciptakan wadah penyaluran hasrat kebutuhan akan hiburan dan kreatifitas",
            epImage: "WIB",
            epLocation: "Stadion Madya GBK dan Plaza Barat Senayan",
            epDate: "29 - 31 Juli 2023",
            epTime: "13:00 - 00:00"
        )
    }
}
