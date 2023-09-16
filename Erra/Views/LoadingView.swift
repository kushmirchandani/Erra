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
            Color(.systemBackground) // Use system background color

            VStack {
                Spacer()

                Image("CenteredLogo") // Replace "Logo" with the name of your asset
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 240, height: 200) // Adjust the size as needed
                    .scaleEffect(isPulsing ? 1.1 : 1.0) // Apply pulsing animation
                    .animation(
                        Animation.easeInOut(duration: 1.0) // Adjust the animation duration as needed
                            .repeatForever(autoreverses: true) // Make it pulse continuously
                    )
                    

                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            isPulsing.toggle() // Start the animation when the view appears
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
