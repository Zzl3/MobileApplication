//
//  ForgetView.swift
//  Music
//
//  Created by sihhd on 2023/4/18.
//

import SwiftUI

struct ForgetView: View {
    @State var phone=""
    @State var pass=""
    @State var verify=""
    
    @State var showAlert:Bool = false;

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

                        TextField("Verify",text: self.$verify)
                        
                        Button("GET") {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
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
                    self.showAlert=true
                    self.index=0
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
                    Alert(title: Text("提示"), message: Text("找回密码成功"))
                }
                
                Button(action: {
                    self.index=0
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
