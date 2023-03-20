//
//  Intro_Nav.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/20.
//

import SwiftUI

struct Intro_Nav: View {
    var body: some View {
        VStack{
            HeaderView()
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.945, green: 0.949, blue: 0.949)/*@END_MENU_TOKEN@*/)
    }
    
    @ViewBuilder
    func HeaderView()->some View{
        VStack{
            HStack(spacing: 0){
                HStack(spacing:0){
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(red: 0.388, green: 0.46, blue: 0.373))
                    
                    TextField("Search",text: .constant(""))
                        .tint(Color(red: 0.388, green: 0.46, blue: 0.373))
                }
                .padding(.vertical,10)
                .padding(.horizontal,15)
                .background{
                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                        .fill(.black)
                        .opacity(0.15)
                }
            }
            HStack(spacing:100){
                CustomButton(symbolImage: "rectangle.and.pencil.and.ellipsis", title: "吹奏类"){
                    
                }
                CustomButton(symbolImage: "rectangle.and.pencil.and.ellipsis", title: "弹拨类"){
                    
                }
                CustomButton(symbolImage: "rectangle.portrait.and.arrow.forward", title: "打击类"){
                    
                }
            }
        }
        .padding(.all,15)
        .background{
            Rectangle()
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.945, green: 0.949, blue: 0.949)/*@END_MENU_TOKEN@*/)
    }
    
    
    @ViewBuilder
    func CustomButton(symbolImage:String,title:String,onClick:@escaping()->())->some View{
        Button{
            
        }label: {
            VStack(spacing: 8){
                Image(systemName: symbolImage)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 0.388, green: 0.46, blue: 0.373))
                    .frame(width: 35,height: 35)
                    .background{
                        RoundedRectangle(cornerRadius: 8,style: .continuous)
                            .fill(.white)
                    }
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundColor(Color(red: 0.384, green: 0.46, blue: 0.373))
            }
        }
    }
}

struct Intro_Nav_Previews: PreviewProvider {
    static var previews: some View {
        Intro_Nav()
    }
}
