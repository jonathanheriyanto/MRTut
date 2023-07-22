//
//  AdminView.swift
//  FirebaseTesting
//
//  Created by Leo Harnadi on 19/07/23.
//

import SwiftUI

struct AdminView: View {
    @EnvironmentObject var dataManager: StationViewModel
    
    var body: some View {
        EventListView(isAdmin: true)
            .environmentObject(dataManager)
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
