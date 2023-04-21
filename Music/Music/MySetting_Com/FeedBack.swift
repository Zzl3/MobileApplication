//
//  FeedBack.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/10.
//

import SwiftUI

struct FeedBack: View {
    @EnvironmentObject var appSettings: AppSettings
    let feedbackTypes = ["页面错误", "功能建议", "其他反馈"]
    @State private var selectedFeedbackType = "页面错误" //反馈类型
    @State private var feedbackContent = "" //反馈内容
    @State private var response = "" //回应
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("反馈类型").foregroundColor(.blue)) {
                        Picker(selection: $selectedFeedbackType, label: Text("类型")) {
                            ForEach(feedbackTypes, id: \.self) { type in
                                Text(type).tag(type)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }

                    Section(header: Text("反馈内容").foregroundColor(.blue)) {
                        TextEditor(text: $feedbackContent)
                            .frame(height: 150)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .background(Color(UIColor.secondarySystemBackground))
                    }
                }
                Button(action: {
                    let userDefault = UserDefaults.standard
                    let userid = userDefault.integer(forKey: "userid")
                    print(userid)
                    let params = ["user_id": userid, "type": feedbackTypes, "content": feedbackContent] as [String : Any]
                    submitFeedback(params: params) { response in
                        self.response = response
                        print(self.response)
                    }
                }) {
                    Text("提交反馈")
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
        FeedBack().environmentObject(AppSettings())
    }
}
