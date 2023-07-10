//
//  HomeView.swift
//  Erra
//
//  Created by Kush Mirchandani on 7/8/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer(minLength: 0)
                
                Text("Welcome to Erra")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                Text("Test Prep Simplified")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                Spacer()
                
                HStack(spacing: 20) {
                    NavigationLink(destination: SettingsView()) {
                        DashboardItem(imageName: "book.fill", title: "Practice")
                    }
                    NavigationLink(destination: SettingsView()) {
                        DashboardItem(imageName: "clock.fill", title: "Timer")
                    }
                }
                .padding(.horizontal, 20)
                
                HStack(spacing: 20) {
                    NavigationLink(destination: SettingsView()) {
                        DashboardItem(imageName: "lightbulb.fill", title: "Exam Tips")
                    }
                    NavigationLink(destination: SettingsView()) {
                        DashboardItem(imageName: "person.fill", title: "Settings")
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
        }
    }
}


struct DashboardItem: View {
    var imageName: String
    var title: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .font(.system(size: 50))
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        .frame(width: 150, height: 150)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
