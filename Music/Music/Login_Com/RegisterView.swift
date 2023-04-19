//
//  RegisterView.swift
//  Music
//
//  Created by sihhd on 2023/4/18.
//

import SwiftUI

struct RegisterView: View {
    @State var phone=""
    @State var pass=""
    @State var Repass=""
    @State var verify=""
    @State var verify_com : Verify?
    
    @State var showAlert = false
    
    @Binding var index : Int
    
    var body: some View {
        ZStack (alignment: .bottom){
            VStack{
                HStack{
                    Spacer(minLength: 0)
                    
                    VStack(spacing: 10){
                        Text("Register")
                            .foregroundColor(self.index == 1 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(self.index == 1 ? Color.white : Color.clear)
                            .frame(width: 100,height: 5)
                    }

                }
                .padding(.top,30)
                
                VStack{
                    HStack(spacing:15){
                        Image(systemName: "phone")
                            .foregroundColor(.white)
                        
                        TextField("Phone Number",text: self.$phone)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,40)
                
                VStack{
                    HStack(spacing:15){
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(.white)
                        
                        TextField("Password",text: self.$pass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,30)
                
                VStack{
                    HStack(spacing:15){
                        Image(systemName: "light.min")
                            .foregroundColor(.white)
                        
                        TextField("Verify",text: self.$pass)
                        
                        Button("GET") {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                        }
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top,30)
                
//                HStack{
//                    Spacer(minLength: 0)
//                    
//                    Button(action:{
//                        
//                    }){
//                        Text("Forget Password?")
//                            .foregroundColor(Color.white.opacity(0.6))
//                    }
//                }
//                .padding(.horizontal)
//                .padding(.top,30)
                
                
            }
            .padding()
            .padding(.bottom,65)
            .background(Color("LightGreen"))
            .clipShape(CShape1())
            .contentShape(CShape1())
            .shadow(color: Color.black.opacity(0.3), radius: 5,x:0,y:-5)
            .onTapGesture{
                self.index=1
            }
            .cornerRadius(35)
            .padding(.horizontal,20)
            
            Button(action: {
                self.showAlert=true
                self.index = 0
            }){
                Text("SIGN UP")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal,50)
                    .background(Color("DeepGreen"))
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.1), radius: 5,x:0,y:5)
            }
            .offset(y:25)
            .opacity(self.index == 1 ? 1 : 0)
            .alert(isPresented: $showAlert){ // 这里 isPresented 绑定 showAlert变量
                Alert(title: Text("提示"), message: Text("注册成功"))
            }
            
        }
    }
    
    func getVerify() {
        let url = URL(string: "http://123.60.156.14:5000/send_verify_code")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let verify_com = try? decoder.decode(Verify.self, from: data) {
                    DispatchQueue.main.async {
                        self.verify_com = verify_com
                        // 将所有乐器按照类别进行分类
                        
                        print(verify_com)
                    }
                }
            }
        }.resume()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(index: .constant(1))
    }
}


