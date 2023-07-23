import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var dataManager: StationViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    @State private var guestIsLoggedIn = true
    
    var body: some View {
        if userIsLoggedIn {
            AdminView()
//            EventListView(isAdmin: true)
                .environmentObject(dataManager)
        } else if guestIsLoggedIn {
            StationGeneralView(isPresented: .constant(false))
                .environmentObject(dataManager)
        } else {
            content
        }
        
        //        content
    }
    
    var content: some View {
        ZStack {
            
            VStack {
                TextField("Email", text: $email)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .textInputAutocapitalization(.never)
                
                SecureField("Password", text: $password)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                
                
                
                Button {
                    login()
                } label: {
                    Text("Log in")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.linearGradient(colors: [.pink,.red], startPoint: .top, endPoint: .bottomTrailing)))
                        .foregroundColor(.white)
                }
                
                Button {
                    guestIsLoggedIn.toggle()
                } label: {
                    Text("Continue as Passenger")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.linearGradient(colors: [.pink,.red], startPoint: .top, endPoint: .bottomTrailing)))
                        .foregroundColor(.white)
                }
            }
            .frame(width: 300)
            .onAppear {
                do {
                    try Auth.auth().signOut()
                } catch {
                    
                }
                
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        userIsLoggedIn.toggle()
                    }
                }
            }
            .padding()
            
            
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

