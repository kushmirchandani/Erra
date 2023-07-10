//
//  SettingsView.swift
//  Erra
//
//  Created by Kush Mirchandani on 7/9/23.
//

import SwiftUI

struct SettingsView: View {
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
                        // Action when the Sign Out button is tapped
                    }) {
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
            
            Text("Deborah Schultz")
                .font(.title)
            
            Text("Member since July 1, 2023")
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
