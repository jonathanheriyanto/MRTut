//
//  Event.swift
//  FirebaseTesting
//
//  Created by Leo Harnadi on 19/07/23.
//

import Foundation

struct Event: Identifiable {
    var id: String
    var name: String
    var station: String
    var description: String
    var category: String
    var startDate: Date
    var endDate: Date
    var location: String
    var imageName: String
}
