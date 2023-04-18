//
//  GuideView.swift
//  Music
//
//  Created by sihhd on 2023/4/18.
//

import SwiftUI

struct GuideView: View {
    @State var index = 0
    
    var body: some View {
        GeometryReader{_ in
            VStack{
                
                Image("ShengT")
                    .resizable()
                    .frame(width: 60,height: 60)
                
                ZStack{
                    RegisterView(index: self.$index)
                        .zIndex(Double(self.index))
                    LoginView(index: self.$index)
                }
                
                HStack(spacing : 15){
                    Rectangle()
                        .fill(Color("LightGreen"))
                        .frame(height: 1)
                    
                    Text("OR")
                    
                    Rectangle()
                        .fill(Color("LightGreen"))
                        .frame(height: 1)
                }
                .padding(.horizontal,20)
                .padding(.top,50)
                
                HStack(spacing:25){
                    Button(action: {
                        
                    }){
                        Image("huawen")
                    }
                }
            }
            .padding(.top,100)
        }
        .background(Color("DeepGreen").edgesIgnoringSafeArea(.all))
        
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
