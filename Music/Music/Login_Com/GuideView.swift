//
//  GuideView.swift
//  Music
//
//  Created by sihhd on 2023/4/18.
//

import SwiftUI

struct GuideView: View {
    @State var index = 0
    @State var showPerson = false
    
    var body: some View {
        if showPerson {
            BaseView().environmentObject(AppSettings())
        }else{
            GeometryReader{_ in
                VStack{
                    
                    Image("app")
                        .resizable()
                        .frame(width: 120,height: 120)
                        .shadow(radius: 10)
                    
                    ZStack{
                        
                        RegisterView(index: self.$index)
                            .zIndex(Double(self.index))
                        
                        
                        LoginView(index: self.$index,showPerson: self.$showPerson)
                        
                        ForgetView(index: self.$index)
                            .opacity(self.index == 2 ? 1 : 0)
                            .zIndex(Double(self.index))
                        
                    }
                    
                    ZStack {
                        Image("huawen")
                            .frame(width: 300,height: 300)
    
                        HStack(spacing : 15){
                            Rectangle()
                                .fill(Color("LightGreen"))
                                .frame(height: 1)
    
                            Text("END")
    
                            Rectangle()
                                .fill(Color("LightGreen"))
                                .frame(height: 1)
                        }
                        .padding(.horizontal,20)
                        .padding(.top,50)
                    }
                }
                .padding(.top,100)
            }
            .background(Color("DeepGreen").edgesIgnoringSafeArea(.all))
        }
        
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}

struct CShape : Shape{
    func path(in rect: CGRect) -> Path{
        return Path{path in
            path.move(to:CGPoint(x: rect.width, y: 100))
            path.addLine(to:CGPoint(x:rect.width,y:rect.height))
            path.addLine(to:CGPoint(x:0,y:rect.height))
            path.addLine(to:CGPoint(x:0,y:0))
        }
    }
}

struct CShape1 : Shape{
    func path(in rect: CGRect) -> Path{
        return Path{path in
            path.move(to:CGPoint(x: 0, y: 100))
            path.addLine(to:CGPoint(x:0,y:rect.height))
            path.addLine(to:CGPoint(x:rect.width,y:rect.height))
            path.addLine(to:CGPoint(x:rect.width,y:0))
        }
    }
}
