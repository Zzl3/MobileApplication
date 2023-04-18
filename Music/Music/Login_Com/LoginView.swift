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
    @Binding var index : Int
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
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(.white)
                        
                        TextField("Password",text: self.$pass)
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
                        
                    }){
                        Text("Forget Password?")
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                }
                .padding(.horizontal)
                .padding(.top,30)
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
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(index: .constant(0))
    }
}
