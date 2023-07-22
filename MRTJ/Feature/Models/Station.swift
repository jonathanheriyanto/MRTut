//
//  Station.swift
//  MRTJ
//
//  Created by beni garcia on 21/07/23.
//

import Foundation

struct Station: Identifiable {
    var id: String
    var name: String
    var live: String
    var expectedDuration: String
    var service: String
    var cause: String
    var situation: String
    var events: [Event]
}
