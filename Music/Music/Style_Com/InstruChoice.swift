//
//  InstruChoice.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/3.
//

import SwiftUI

struct InstruChoice: View {
    @State var albums:[Album]=sampleAlbums
    @State var currentIndex:Int=0
    @State var currentAlbum:Album=sampleAlbums.first!
    var body: some View {
        VStack(spacing:0){
            Text("乐器选择")
                .font(.title2)
                .foregroundColor(Color.black)
                .bold()
                .padding(.bottom, 6.0)
                .frame(maxWidth: .infinity,alignment: .leading)
            VStack(spacing:20){
                AlbumScroller()
                    .zIndex(1)
                standView
                    .zIndex(0)
            }
            .zIndex(1)
            .scaleEffect(0.8)
            .frame(height: 40)
            
            TabView{
                ForEach($albums) { $album in
                    AlbumCardView(album: album)
                        .offsetX{value,width in
                            //上面的文字跟着图片移动
                            if value == 0 && currentIndex != getIndex(album: album){
                                withAnimation(.easeInOut(duration: 0.6)){
                                    currentIndex=getIndex(album: album)
                                    currentAlbum=albums[currentIndex]
                                }
                            }
                        
                        }
                }
            }
            .padding(.horizontal,-5)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .zIndex(0)
            .frame(height: 400)
        }
        .padding(5)
        .frame(maxWidth: .infinity,alignment: .top)
        .background(Color(red: 0.933, green: 0.933, blue: 0.925))
    }
    
    var standView:some View{
        Rectangle()
            .fill(.white.opacity(0.6))
            .shadow(color:.black.opacity(0.85),radius:20,x:0,y:5)
            .frame(height:10)
            .overlay(alignment:.top){
                Rectangle()
                    .fill(.white.opacity(0.75).gradient)
                    .frame(height:385)
                    //MARK: 3D Rotation
                    .rotation3DEffect(.init(degrees: -98), axis: (x: 1 , y: 0, z: 0),
                                      anchor: .top,anchorZ: 0.5,perspective: 1)
                    .shadow(color: .black.opacity(0.08), radius: 25,x:0,y:5)
                    .shadow(color: .black.opacity(0.08), radius: 5,x:0,y:15)
            }
            .scaleEffect(1.0)
    }
    
    func getIndex(album:Album)->Int{
        return albums.firstIndex{_album in
            return _album.id == album.id
        } ?? 0
    }
    
    @ViewBuilder
    func AlbumCardView(album:Album)->some View{
        VStack(alignment: .leading, spacing: 0){
            HStack(spacing:0){
                Image(album.albumImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250,height: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 8,style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 5,x:0,y:10)
                    .zIndex(1)
            }
        }
        .frame(maxWidth: .infinity,alignment: .top)
        .background{
            CustomCorners(corners: [.bottomLeft,.bottomRight], radius: 25)
                .fill(.white.opacity(0.6))
        }
        .padding(.horizontal,30)
    }
    
    @ViewBuilder
    func AlbumScroller()->some View{
        GeometryReader{proxy in
            let size=proxy.size
            
            LazyHStack(spacing:0){
                ForEach($albums){
                    $album in
                    HStack{
        //                Text("\"关于\"")
        //                    .fontWeight(.semibold)
        //                    .foregroundColor(.gray.opacity(0.6))
        //                    .frame(maxWidth: .infinity,alignment: .leading)
                        Text(album.albumName)
                            .font(.title.bold())
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
        //                    .frame(maxWidth: .infinity,alignment: .leading)
        //                HStack(spacing:5.0){
        //                    ForEach(1...5,id: \.self){index in
        //                        Image(systemName: "star.fill")
        //                            .font(.system(size:12))
        //                            .foregroundColor(.gray.opacity(index > album.rating ? 0.2 : 1))
        //                    }
        //
        //                    Text("\(album.rating).0")
        //                        .font(.caption)
        //                        .padding(.leading,5)
        //                }
                    }
                    .frame(width: size.width,alignment: currentIndex > getIndex(album: album) ? .trailing : currentIndex == getIndex(album: album) ?
                        .center : .leading)
                    .scaleEffect(currentAlbum.id == album.id ? 1 : 0.8, anchor: .bottom)
                    .offset(x: currentIndex > getIndex(album: album) ? 100 : currentIndex == getIndex(album: album) ? 0 : -40)
                }
                
            }
            .offset(x: CGFloat(currentIndex) * -size.width)
            
        }
        .frame(height:30)
    }
}

struct InstruChoice_Previews: PreviewProvider {
    static var previews: some View {
        InstruChoice()
    }
}

extension View{
    func offsetX(completion:@escaping(CGFloat,CGFloat)->())->some View{
        self
            .overlay{
                GeometryReader{proxy in
                    Color.clear
                        .preference(key:OffsetXkey.self,value: proxy.frame(in: .global).minX)
                        .onPreferenceChange(OffsetXkey.self){value in
                            completion(value,proxy.size.width)
                        }
                }
            }
    }
}

struct OffsetXkey:PreferenceKey{
    static var defaultValue: CGFloat=0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value=nextValue()
    }
}
