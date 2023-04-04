//
//  DetailView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/4.
//

import SwiftUI

struct DetailView:View{
    var animation:Namespace.ID
    var album:Album
    @Binding var show:Bool
    var body: some View{
        VStack{
            HStack{
                Button{
                    withAnimation(.easeInOut(duration: 0.35)){
                        show=false
                    }
                } label: {
                    Text("试试其他")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(15)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        SongChoose(song:sampleSong[0])
    }
}
