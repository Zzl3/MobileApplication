//
//  FeedBack.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/10.
//

import SwiftUI

struct FeedBack: View {
    let feedbackTypes = ["页面错误", "功能建议", "其他反馈"]
    @State private var selectedFeedbackType = "页面错误" //反馈类型
    @State private var feedbackContent = "" //反馈内容
    @State private var response = "" //回应
    @Binding var showFeedback : Bool
    
    var body: some View {
        Button{
            withAnimation(.easeInOut(duration: 0.35)){
                showFeedback=false
            }
        } label: {
            Label("返回",systemImage: "arrowshape.turn.up.backward")
                .font(.title2)
                .foregroundColor(.black)
                .padding(15)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        
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
                Button(action: {
                    let params = ["user_id": "1", "type": "乐器种类", "content": "希望能添加更多的乐器类型，涵盖更广泛的中国古典音乐"]
                    submitFeedback(params: params) { response in
                        self.response = response
                        print(self.response)
                    }
                }) {
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

    func submitFeedback(params: [String: Any], completion: @escaping (String) -> Void) {
           let url = URL(string: "http://123.60.156.14:5000//feedback")!
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           URLSession.shared.dataTask(with: request) { data, response, error in
               guard let data = data, error == nil else {
                   completion(error?.localizedDescription ?? "Unknown error")
                   return
               }
               if let response = String(data: data, encoding: .utf8) {
                   completion(response)
               }
           }.resume()
       }
}



struct FeedBack_Previews: PreviewProvider {
    static var previews: some View {
        FeedBack(showFeedback: .constant(false))
    }
}
