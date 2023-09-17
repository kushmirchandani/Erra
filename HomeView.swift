//
//  HomeView.swift
//  Erra
//
//  Created by Kush Mirchandani on 7/8/23.
//

import SwiftUI
struct HomeView: View {
    @StateObject private var LogoutVM1 = LogoutVM2()
   
    @State private var isPlaceholderPresented = false
   
    var body: some View {
        VStack{
        Group{
    Text("Hey, Deborah")
                .font(Font.custom("Inter", size: 24))
        .foregroundColor(.black)
            Text("Welcome back to your circle")
                .font(Font.custom("Inter", size: 12))
                .foregroundColor(.gray)
        }
        .padding(5)
            MapView()
                .frame(width: 352, height: 438)
//            Rectangle()
//                  .foregroundColor(.clear)
//                  .frame(width: 352, height: 438)
//                  .background(
//                    AsyncImage(url: URL(string: "https://via.placeholder.com/352x438"))
//                  )
                .cornerRadius(10)
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 390, height: 165)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 1, blue: 1).opacity(0.95), Color(red: 1, green: 1, blue: 1).opacity(0)]), startPoint: .top, endPoint: .bottom)
                )
            Text("Tools")
                .font(.title)
            
            Button(action: {
                LogoutVM1.signout() { signoutSuccess in
                    if signoutSuccess {
                        isPlaceholderPresented.toggle()
                    } else {
                        print("signout failed")
                    }
                }
            }) {
                Text("Sign Out")
                    .foregroundColor(.red)
            }
            Text("© 2023 Ignis | A Life Studio Experience")
                .foregroundStyle(.gray.opacity(0.5))
                .font(.caption)
                .padding(.top, 10)
            
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

final class LogoutVM2: ObservableObject {
    
    func signout(completion: @escaping (Bool) -> Void) {
        
            AuthenticationManager.shared.logout()
            completion(true)
      
    }
}
