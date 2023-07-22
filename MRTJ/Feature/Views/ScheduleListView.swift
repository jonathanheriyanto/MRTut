//
//  ScheduleListView.swift
//  MRTJ
//
//  Created by beni garcia on 22/07/23.
//

import SwiftUI

struct ScheduleListView: View {
    let condensedBold = UIFont.systemFont(ofSize: 31, weight: .bold, width: .condensed)
    let condensedHeavy = UIFont.systemFont(ofSize: 24, weight: .heavy, width: .condensed)
    var colorRectangle: Color
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{ //stacking jadwal
                ZStack(alignment: .leading){ //setiap komponen rectangle
                    //Schedule
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(colorRectangle, lineWidth: 2)
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
                //Rectangle kedua
                ZStack(alignment: .leading){ //setiap komponen rectangle
                    //Schedule
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(colorRectangle, lineWidth: 2)
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
                ZStack(alignment: .leading){ //setiap komponen rectangle
                    //Schedule
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(colorRectangle, lineWidth: 2)
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
                ZStack(alignment: .leading){ //setiap komponen rectangle
                    //Schedule
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(colorRectangle, lineWidth: 2)
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
                ZStack(alignment: .leading){ //setiap komponen rectangle
                    //Schedule
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(colorRectangle, lineWidth: 2)
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
                ZStack(alignment: .leading){ //setiap komponen rectangle
                    //Schedule
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(colorRectangle, lineWidth: 2)
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
                ZStack(alignment: .leading){ //setiap komponen rectangle
                    //Schedule
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(colorRectangle, lineWidth: 2)
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
            }
        }
        .frame(height:420)
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView(colorRectangle: Color(AssetName.green))
    }
}
