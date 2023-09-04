//
//  ContentView.swift
//  Erra
//
//  Created by Kush Mirchandani on 7/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var userIsLoggedIn = false
    var body: some View {
        if userIsLoggedIn{
            HomeView()
        }else{
            Onboarding1()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}
