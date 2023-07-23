//
//  ExtStations.swift
//  MRTJ
//
//  Created by Febrian Daniel on 23/07/23.
//

import Foundation
import CoreLocation

struct Stations {
    static let stations: [CLCircularRegion] = [
        CLCircularRegion(center: Regions.lebakBulusRegion, radius: 500, identifier: .lebakBulus),
        CLCircularRegion(center: Regions.fatmawatiRegion, radius: 500, identifier: .fatmawati),
        CLCircularRegion(center: Regions.cipeteRayaRegion, radius: 500, identifier: .cipeteRaya),
        CLCircularRegion(center: Regions.hajiNawiRegion, radius: 500, identifier: .hajiNawi),
        CLCircularRegion(center: Regions.blokARegion, radius: 500, identifier: .blokA),
        CLCircularRegion(center: Regions.blokMRegion, radius: 500, identifier: .blokM),
        CLCircularRegion(center: Regions.aseanRegion, radius: 500, identifier: .asean),
        CLCircularRegion(center: Regions.senayanRegion, radius: 500, identifier: .senayan),
        CLCircularRegion(center: Regions.istoraRegion, radius: 500, identifier: .istora),
        CLCircularRegion(center: Regions.benHilRegion, radius: 500, identifier: .benHil),
        CLCircularRegion(center: Regions.setiabudiRegion, radius: 500, identifier: .setiabudi),
        CLCircularRegion(center: Regions.dukuhAtasRegion, radius: 500, identifier: .dukuhAtas),
        CLCircularRegion(center: Regions.bundaranHIRegion, radius: 500, identifier: .bundaranHI)
    ]
}

struct Regions {
    static let lebakBulusRegion = CLLocationCoordinate2D(latitude: -6.28941, longitude: 106.774840)
    static let fatmawatiRegion = CLLocationCoordinate2D(latitude: -6.2924482367003405, longitude: 106.79246036563308)
    static let cipeteRayaRegion = CLLocationCoordinate2D(latitude: -6.27826650638728, longitude: 106.79732298998807)
    static let hajiNawiRegion = CLLocationCoordinate2D(latitude: -6.26667951444775, longitude: 106.79733461451085)
    static let blokARegion = CLLocationCoordinate2D(latitude: -6.25575420377171, longitude: 106.79713696641265)
    static let blokMRegion = CLLocationCoordinate2D(latitude: -6.244466349609376, longitude: 106.79810366187519)
    static let aseanRegion = CLLocationCoordinate2D(latitude: -6.238397973115478, longitude: 106.79853966877472)
    static let senayanRegion = CLLocationCoordinate2D(latitude: -6.226740553710924, longitude: 106.80247852162029)
    static let istoraRegion = CLLocationCoordinate2D(latitude: -6.222365472331843, longitude: 106.80858980781773)
    static let benHilRegion = CLLocationCoordinate2D(latitude: -6.215002390027251, longitude: 106.8179522734759)
    static let setiabudiRegion = CLLocationCoordinate2D(latitude: -6.208864972122704, longitude: 106.82149613452461)
    static let dukuhAtasRegion = CLLocationCoordinate2D(latitude: -6.20079817475626, longitude: 106.82279755572677)
    static let bundaranHIRegion = CLLocationCoordinate2D(latitude: -6.191882571679688, longitude: 106.82295679033933)
}

extension String {
    static let mrtJ = "MRT-J"
    static let lebakBulus = "Lebak Bulus Grab"
    static let fatmawati = "Fatmawati Indomaret"
    static let cipeteRaya = "Cipete Raya"
    static let hajiNawi = "Haji Nawi"
    static let blokA = "Blok A"
    static let blokM = "Blok M BCA"
    static let asean = "ASEAN"
    static let senayan = "Senayan"
    static let istora = "Istora Mandiri"
    static let benHil = "Bendungan Hilir"
    static let setiabudi = "Setiabudi Astra"
    static let dukuhAtas = "Dukuh Atas BNI"
    static let bundaranHI = "Bundaran HI"
}
