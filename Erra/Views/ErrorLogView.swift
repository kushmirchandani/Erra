//
//  ErrorLogView.swift
//  Erra
//
//  Created by Kush Mirchandani on 7/13/23.
//

import SwiftUI

struct ErrorLogView: View {
    @State private var selectedCategory = "Reading"
    @State private var errorLogs: [ErrorLog] = []
    
    var body: some View {
        VStack(spacing: 0) {
            // Category tabs
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(["Reading", "Writing", "Math"], id: \.self) { category in
                        Button(action: {
                            selectedCategory = category
                            loadErrorLogs()
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
            
            // Error logs content
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(errorLogs) { errorLog in
                        ErrorLogCard(errorLog: errorLog)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 30)
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("Error Log")
        .onAppear {
            loadErrorLogs()
        }
    }
    
    // Function to load error logs for the selected category
    func loadErrorLogs() {
        // Fetch error logs from Firestore or any other data source based on the selected category
        // Update the "errorLogs" array with the fetched error logs
        
        // Example predefined error logs
        let readingErrorLogs = [
            ErrorLog(description: "Reading error 1 description", section: "Section 1", test: "Test 1", tags: ["Tag 1", "Tag 2"]),
            ErrorLog(description: "Reading error 2 description", section: "Section 2", test: "Test 2", tags: ["Tag 3", "Tag 4"]),
            ErrorLog(description: "Reading error 3 description", section: "Section 3", test: "Test 3", tags: ["Tag 5", "Tag 6"])
        ]
        
        let writingErrorLogs = [
            ErrorLog(description: "Writing error 1 description", section: "Section 1", test: "Test 1", tags: ["Tag 7", "Tag 8"]),
            ErrorLog(description: "Writing error 2 description", section: "Section 2", test: "Test 2", tags: ["Tag 9", "Tag 10"]),
            ErrorLog(description: "Writing error 3 description", section: "Section 3", test: "Test 3", tags: ["Tag 11", "Tag 12"])
        ]
        
        let mathErrorLogs = [
            ErrorLog(description: "Math error 1 description", section: "Section 1", test: "Test 1", tags: ["Tag 13", "Tag 14"]),
            ErrorLog(description: "Math error 2 description", section: "Section 2", test: "Test 2", tags: ["Tag 15", "Tag 16"]),
            ErrorLog(description: "Math error 3 description", section: "Section 3", test: "Test 3", tags: ["Tag 17", "Tag 18"])
        ]
        
        switch selectedCategory {
        case "Reading":
            errorLogs = readingErrorLogs
        case "Writing":
            errorLogs = writingErrorLogs
        case "Math":
            errorLogs = mathErrorLogs
        default:
            errorLogs = []
        }
    }
}

struct ErrorLog: Identifiable {
    let id = UUID()
    let description: String
    let section: String
    let test: String
    let tags: [String]
}

struct ErrorLogCard: View {
    let errorLog: ErrorLog
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Section:")
                    .font(.caption)
                    .fontWeight(.bold)
                Text(errorLog.section)
                    .font(.caption)
            }
            HStack {
                Text("Test:")
                    .font(.caption)
                    .fontWeight(.bold)
                Text(errorLog.test)
                    .font(.caption)
            }
            HStack {
                ForEach(errorLog.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
            Text(errorLog.description)
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct ErrorLogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ErrorLogView()
        }
    }
}
