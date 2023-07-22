import SwiftUI

struct ContentView: View {
    var body: some View {
        StationInformationView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(StationViewModel())
    }
}
