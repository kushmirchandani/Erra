

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var LogoutVM1 = logoutVM()
    @State private var isPlaceholderPresented = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Account")) {
                    UserCard()
                }
                
                Section(header: Text("Account Details")) {
                    NavigationLink(destination: HomeView()) {
                        SettingRow(iconName: "person.fill", title: "Profile")
                    }
                }
                
                Section(header: Text("App Settings")) {
                    NavigationLink(destination: HomeView()) {
                        SettingRow(iconName: "bell.fill", title: "Notifications")
                    }
                    NavigationLink(destination: HomeView()) {
                        SettingRow(iconName: "paintbrush.fill", title: "Appearance")
                    }
                    NavigationLink(destination: HomeView()) {
                        SettingRow(iconName: "questionmark.circle.fill", title: "Help & Support")
                    }
                }
                
                Section {
                    Button(action: {
                        LogoutVM1.signout() { signoutSuccess in
                            if signoutSuccess {
                                isPlaceholderPresented.toggle()
                            } else {
                                print("signout failed")
                            }
                        }
                    })  {
                        Text("Sign Out")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}


struct UserCard: View {
    var body: some View {
        VStack(spacing: 10) {
            Image("ProfilePicture")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            Text("/UserName")
                .font(.title)
            
            Text("/User City, State")
                .font(.caption)
                .foregroundColor(.gray)
                
                
        }
        .padding(.vertical, 20)
    }
}

struct SettingRow: View {
    var iconName: String
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.title2)
                .foregroundColor(.black)
            
            Text(title)
                .font(.headline)
            
            Spacer()
            
//            Image(systemName: "chevron.right")
//                .foregroundColor(.gray)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


final class logoutVM: ObservableObject {
    
    func signout(completion: @escaping (Bool) -> Void) {
        
            AuthenticationManager.shared.logout()
            completion(true)
      
    }
}

