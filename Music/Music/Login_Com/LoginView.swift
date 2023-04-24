//
//  LoginView.swift
//  Music
//
//  Created by sihhd on 2023/4/18.
//

import SwiftUI

struct LoginView: View {
    @State var email=""
    @State var pass=""
    @State var msg=""
    @State var show=false
    @State var userInfo : UserInfo?
    @State var showPass=false
    @Binding var index : Int
    @Binding var showPerson : Bool
    
    var body: some View {
        ZStack (alignment: .bottom){
            VStack{
                HStack{
                    VStack(spacing:10){
                        Text("Login")
                            .foregroundColor(self.index == 0 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        Capsule()
                            .fill(self.index == 0 ? Color.white : Color.clear)
                            .frame(width: 100,height: 5)
                    }
                    
                    Spacer(minLength: 0)
                    
                    
                }
                .padding(.top,30)
                
                VStack{
                    HStack(spacing:15){
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.white)
                        
                        TextField("Email Address",text: self.$email)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,40)
                
                VStack{
                    HStack(spacing:15){
                        Button(action: {
                            showPass = !showPass
                        }){
                            if(showPass){
                                Image(systemName: "eye.fill")
                                    .foregroundColor(.white)
                            }else{
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(.white)
                            }
                            
                        }
                        
                        if(showPass){
                            TextField("Password",text: self.$pass)
                        }else{
                            SecureField("Password",text: self.$pass)
                        }
                        
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,30)
                
//                VStack{
//                    HStack(spacing:15){
//                        Image(systemName: "eye.slash.fill")
//                            .foregroundColor(.white)
//                        
//                        TextField("RePassword",text: self.$pass)
//                    }
//                    
//                    Divider().background(Color.white.opacity(0.5))
//                }
//                .padding(.horizontal)
//                .padding(.top,30)
                
                HStack{
                    Spacer(minLength: 0)
                    
                    Button(action:{
                        self.index=2
                    }){
                        Text("Forget Password?")
                            .foregroundColor(Color("DeepGreen"))
                    }
                }
                .padding(.horizontal)
                .padding(.top,40)
            }
            .padding()
            .padding(.bottom,65)
            .background(Color("LightGreen"))
            .clipShape(CShape())
            .contentShape(CShape())
            .shadow(color: Color.black.opacity(0.3), radius: 5,x:0,y:-5)
            .onTapGesture{
                self.index=0
            }
            .cornerRadius(35)
            .padding(.horizontal,20)
            
            Button(action: {
                if(email==""||pass==""){
                    show=true
                    msg="邮箱或密码不能为空"
                }else{
                    let params = ["mail": email,"password": pass]
                    let userDefault = UserDefaults.standard
                    userDefault.set(email, forKey: "mail")
                    userDefault.set(pass, forKey: "password")
                    login(params: params) {userInfo in
                        self.userInfo = userInfo
                        
                        print(self.userInfo)
                        if(userInfo.code==200){
                            let userDefault = UserDefaults.standard
                            userDefault.set(userInfo.data?.id, forKey: "userid")
                            let userid = userDefault.integer(forKey: "userid")
                            userDefault.set(userInfo.data?.avatar, forKey: "avatar")
                            userDefault.set(userInfo.data?.username,forKey: "username")
                            self.showPerson=true
                            print(userid)
                        }else{
                            self.msg="邮箱或密码错误"
                            self.show=true
                        }
                    }
                    
                }
                
                
            }){
                Text("LOGIN")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal,50)
                    .background(Color("DeepGreen"))
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.1), radius: 5,x:0,y:5)
            }
            .offset(y:25)
            .opacity(self.index == 0 ? 1 : 0)
            .alert(isPresented: $show){ // 这里 isPresented 绑定 showAlert变量
                Alert(title: Text("提示"), message: Text(self.msg))
            }
            
        }
    }
    
//    func login(email:String,password:String){
//        let params = ["mail": email,"password": password]
//        
//        
//    }
    
    func login(params: [String: Any], completion: @escaping (UserInfo) -> Void) {
        let url = URL(string: "http://123.60.156.14:5000/login_mail")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let userInfo = try? decoder.decode(UserInfo.self, from: data) {
                    DispatchQueue.main.async {
                        completion(userInfo)
                        print(userInfo)
                    }
                }
            }
        }.resume()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(index: .constant(0),showPerson: .constant(false))
    }
}
