//
//  FeedBack.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/10.
//

import SwiftUI

struct FeedBack: View {
    let feedbackTypes = ["Bug Report", "Feature Request", "General Feedback"]
    @State private var selectedFeedbackType = "Bug Report"
    @State private var feedbackContent = ""

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Feedback Type").foregroundColor(.blue)) {
                        Picker(selection: $selectedFeedbackType, label: Text("Type")) {
                            ForEach(feedbackTypes, id: \.self) { type in
                                Text(type).tag(type)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }

                    Section(header: Text("Feedback Content").foregroundColor(.blue)) {
                        TextEditor(text: $feedbackContent)
                            .frame(height: 150)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .background(Color(UIColor.secondarySystemBackground))
                    }
                }
                

                Button(action: submitFeedback) {
                    Text("Submit Feedback")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 40)
            }
            .accentColor(.blue)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func submitFeedback() {
        // Implement submit feedback functionality
    }
}



struct FeedBack_Previews: PreviewProvider {
    static var previews: some View {
        MySetting()
    }
}
