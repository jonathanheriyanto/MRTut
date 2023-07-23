//
//  NotificationSheetView.swift
//  MRTJ
//
//  Created by Febrian Daniel on 24/07/23.
//

import SwiftUI
import CoreLocation

struct NotificationSheetView: View {
    @EnvironmentObject var vm: StationViewModel
    @Binding var isPresented: Bool
    @State private var sheetContentHeight = CGFloat(0)
    
    var body: some View {
        ZStack {
            if vm.station.service == "Closed" {
                problemDetailSheet(station: "\(vm.station.name)", cause: "\(vm.station.cause)", duration: "\(vm.station.expectedDuration)")
                    .background {
                        GeometryReader { proxy in
                            Color.clear
                                .task {
                                    print("size = \(proxy.size.height)")
                                    sheetContentHeight = proxy.size.height
                                }
                        }
                    }
                    .presentationDetents([.height(sheetContentHeight + 120)])
            } else {
                stationDetailSheet(station: "\(vm.station.name)")
                    .background {
                        GeometryReader { proxy in
                            Color.clear
                                .task {
                                    print("size = \(proxy.size.height)")
                                    sheetContentHeight = proxy.size.height
                                }
                        }
                    }
                    .presentationDetents([.height(sheetContentHeight - 20)])
            }
        }
        .onDisappear {
            sheetContentHeight = 0
        }
    }
}
