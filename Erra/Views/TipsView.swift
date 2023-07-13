//
//  TipsView.swift
//  Erra
//
//  Created by Kush Mirchandani on 7/13/23.
//

import SwiftUI

struct TipsView: View {
    @State private var selectedCategory = "Reading"
    
    var body: some View {
        VStack(spacing: 0) {
            // Category tabs
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(["Reading", "Writing", "Math"], id: \.self) { category in
                        Button(action: {
                            selectedCategory = category
                        }) {
                            Text(category)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(selectedCategory == category ? .white : .black)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(selectedCategory == category ? Color.black : Color.gray.opacity(0.3))
                                .clipShape(Capsule())
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, 20)
            
            // Tips content
            VStack(spacing: 20) {
                ForEach(tipsForCategory(selectedCategory)) { tip in
                    TipCard(tip: tip)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 30)
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("Tips")
        
    }
    
    // Function to retrieve tips for the selected category
    func tipsForCategory(_ category: String) -> [Tip] {
        // Return tips based on the selected category
        // You can customize this function to fetch tips from a data source or use predefined tips
        
        // Example predefined tips
        let readingTips = [
            Tip(title: "Reading", description: "Reading tip description", example: "Reading example")
        ]
        
        let writingTips = [
            Tip(title: "Writing", description: "Writing tip description", example: "Writing example")
        ]
        
        let mathTips = [
            Tip(title: "Math", description: "Math tip description", example: "Math example")
        ]
        
        switch category {
        case "Reading":
            return readingTips
        case "Writing":
            return writingTips
        case "Math":
            return mathTips
        default:
            return []
        }
    }
}

struct Tip: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let example: String
}

struct TipCard: View {
    let tip: Tip
    @State private var isFlipped = false
    
    var body: some View {
        ZStack {
            if isFlipped {
                CardContent(text: tip.example)
            } else {
                CardContent(text: tip.description)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .onTapGesture {
            withAnimation(.linear(duration: 0.3)) {
                isFlipped.toggle()
            }
        }
    }
}

struct CardContent: View {
    let text: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text(text)
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding()
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TipsView()
        }
    }
}
