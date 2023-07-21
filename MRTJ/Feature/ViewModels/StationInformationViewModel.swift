//
//  stationInformationViewModel.swift
//  StationInformation
//
//  Created by Clarabella Lius on 20/07/23.
//

import Foundation

class StationInformationViewModel: ObservableObject{
    
    func getCurrentTime() -> String{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let timeString = formatter.string(from: Date())
        return timeString
    }
    
    func formattedDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        let dateString = formatter.string(from: Date())
        return dateString
    }
    
}
