//
//  LoadingView.swift
//  Erra
//
//  Created by Kush Mirchandani on 9/16/23.
//

import SwiftUI

struct LoadingView: View {
    @State private var isPulsing = false

    var body: some View {
        ZStack {
            Color(.systemBackground)

            VStack {
                Spacer()

                Image("CenteredLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 240, height: 200)
                    .scaleEffect(isPulsing ? 1.1 : 1.0)
                    .animation(
                        Animation.easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true) //pulse continuosly
                    )
                    

                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            isPulsing.toggle() // when view appears
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
