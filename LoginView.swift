//
//  LoginView.swift
//  Erra
//
//  Created by Kush Mirchandani on 7/8/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            // Page background image
            Image("Google Logo Black")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            Color.white.opacity(1) // Lower opacity of the grey background
            
            VStack(spacing: 20) { // Adjust spacing between the login rectangles
                Spacer()
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(#colorLiteral(red: 0.9125000238418579, green: 0.9125000238418579, blue: 0.9125000238418579, alpha: 0.2))) // Adjusted opacity of the grey rectangle
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .overlay(
                        VStack {
                            Text("Welcome to Erra")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Test Prep Simplified")
                            
                            HStack(spacing: 20) {
                                Button(action: {}) {
                                    HStack {
                                        Image(systemName: "applelogo")
                                            .resizable()
                                            .frame(width: 20, height: 25)
                                        Text("Apple Sign In")
                                            .padding(5)
                                    }
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(10)
                                    .background(Color.black)
                                    .cornerRadius(10)
                                }
                                
                                Button(action: {}) {
                                    HStack {
                                        Image("Google Icon White")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        Text("Google Sign In")
                                            .padding(5)
                                    }
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(10)
                                    .background(Color.black)
                                    .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.top, 20)
                    )
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

