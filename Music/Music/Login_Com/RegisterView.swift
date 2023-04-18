//
//  RegisterView.swift
//  Music
//
//  Created by sihhd on 2023/4/18.
//

import SwiftUI

struct RegisterView: View {
    @State var email=""
    @State var pass=""
    @State var Repass=""
    @Binding var index : Int
    
    var body: some View {
        ZStack (alignment: .bottom){
            VStack{
                HStack{
                    Spacer(minLength: 0)
                    
                    VStack(spacing: 10){
                        Text("SignUp")
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
                
                VStack{
                    HStack(spacing:15){
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(.white)
                        
                        TextField("RePassword",text: self.$pass)
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
            
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(index: .constant(1))
    }
}


