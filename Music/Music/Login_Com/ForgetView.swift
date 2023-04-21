//
//  ForgetView.swift
//  Music
//
//  Created by sihhd on 2023/4/18.
//

import SwiftUI

struct ForgetView: View {
    @State var mail=""
    @State var pass=""
    @State var verify=""
    @State var verify_com=""
    @State var msg=""
    
    @State var showPass = false
    @State var showAlert = false
    @State var showGetAlert = false

    @Binding var index : Int
    var body: some View {
        ZStack (alignment: .bottom){
            VStack{
                HStack{
                    VStack(spacing:10){
                        Text("Forget Password")
                            .foregroundColor(self.index == 2 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        Capsule()
                            .fill(self.index == 2 ? Color.white : Color.clear)
                            .frame(width: 220,height: 5)
                    }

                    
                    
                }
                .padding(.top,30)
                
                VStack{
                    HStack(spacing:15){
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.white)
                        
                        TextField("Email Address",text: self.$mail)
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
                
                VStack{
                    HStack(spacing:15){
                        Image(systemName: "light.min")
                            .foregroundColor(.white)

                        TextField("Verify",text: self.$verify)
                        
                        Button(action: {
                            if(mail==""){
                               showGetAlert=true
                            }else{
                                let params = ["mail": self.mail]
                                print(params)
                                getVerify(params: params)
                            }
                            
                        },label: {
                            Text("GET")
                        })
                        .alert(isPresented: $showGetAlert){ // 这里 isPresented 绑定 showAlert变量
                            Alert(title: Text("提示"), message: Text("邮箱不能为空"))
                        }
                        
                    }

                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,30)
            
            }
            .padding()
            .padding(.bottom,65)
            .background(Color("LightGreen"))
            .clipShape(CShape2())
            .contentShape(CShape2())
            .shadow(color: Color.black.opacity(0.3), radius: 5,x:0,y:-5)
            .onTapGesture{
                self.index=2
            }
            .cornerRadius(35)
            .padding(.horizontal,20)
            
            HStack {
                Button(action: {
                    if(verify==""){
                        showAlert=true
                        msg="验证码不能为空"
                    }
                    else if(mail==""||pass==""){
                        showAlert=true
                        msg="邮箱或密码不能为空"
                    }else if(!(verify==verify_com)){
                        showAlert=true
                        msg="验证码错误"
                    }
                    else{
                        let params = ["mail": mail,"verify_code":verify,"password": pass]
                        modify(params: params) {modify in
                            print(modify)
                            if(modify.code==200){
                                self.showAlert=true
                                self.index = 0
                                self.msg="密码修改成功"
                            }else{
                                self.msg=modify.msg
                                self.showAlert=true
                            }
                        }
                        
                        mail=""
                        pass=""
                        verify=""
                        verify_com=""
                    }
                }){
                    Text("确认")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .padding(.horizontal,50)
                        .background(Color("DeepGreen"))
                        .clipShape(Capsule())
                        .shadow(color: Color.white.opacity(0.1), radius: 5,x:0,y:5)
                }
                .offset(y:25)
                .opacity(self.index == 2 ? 1 : 0)
                .alert(isPresented: $showAlert){ // 这里 isPresented 绑定 showAlert变量
                    Alert(title: Text("提示"), message: Text(self.msg))
                }
                
                Button(action: {
                    self.index=0
                    mail=""
                    pass=""
                    verify=""
                    verify_com=""
                }){
                    Text("取消")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .padding(.horizontal,50)
                        .background(Color("DeepGreen"))
                        .clipShape(Capsule())
                        .shadow(color: Color.white.opacity(0.1), radius: 5,x:0,y:5)
                }
                .offset(y:25)
                .opacity(self.index == 2 ? 1 : 0)
            }
            
        }
    }
    
    func getVerify(params: [String: Any]){
        let url = URL(string: "http://123.60.156.14:5000//send_verify_code")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let verify_com = try? decoder.decode(Verify.self, from: data) {
                    DispatchQueue.main.async {
                        self.verify_com = String(verify_com.data.code)
//                        if(verify_com.code==200){
//                            self.result=1
//                        }else{
//                            self.result=2
//                        }
                        print(verify_com)
                    }
                }
            }
        }.resume()

    }
    func modify(params: [String: Any], completion: @escaping (Modify) -> Void) {
        let url = URL(string: "http://123.60.156.14:5000//modify_passwd")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let modify = try? decoder.decode(Modify.self, from: data) {
                    DispatchQueue.main.async {
                        completion(modify)
                        print(modify)
                    }
                }
            }
        }.resume()
    }
}

struct ForgetView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetView(index: .constant(2))
    }
}

struct CShape2 : Shape{
    func path(in rect: CGRect) -> Path{
        return Path{path in
            path.move(to:CGPoint(x: 0, y: 0))
            path.addLine(to:CGPoint(x:0,y:rect.height))
            path.addLine(to:CGPoint(x:rect.width,y:rect.height))
            path.addLine(to:CGPoint(x:rect.width,y:0))
        }
    }
}
