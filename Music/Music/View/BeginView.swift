//
//  BeginView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/17.
//

import SwiftUI

struct BeginView: View {
    @State var showWalkThroughScrrens: Bool = false
    @State var currentIndex: Int = 0
    @State var showHomeView: Bool = false
    var body: some View {
        ZStack {
            if showHomeView {
                Home()
                    .transition(.move(edge: .trailing))
            } else {
                ZStack {
                    Color("LightGreen")
                        .ignoresSafeArea()
                    IntroScreen()
                    WalkThroughScreens()
                    NavBar()
                }
                .animation(.interactiveSpring(response: 1.1, dampingFraction: 0.85, blendDuration: 0.85), value: showWalkThroughScrrens)
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.35), value: showHomeView)
    }
    
    // 登录注册页面
    @ViewBuilder
    func WalkThroughScreens() -> some View {
        let isLast = currentIndex == intros.count
        GeometryReader {
            let size = $0.size
            ZStack {
                ForEach(intros.indices, id: \.self) { index in
                    ScreeenView(size: size, index: index)
                }
                WelcomeView(size: size, index: intros.count)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottom) {
                ZStack {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .scaleEffect(!isLast ? 1 : 0.001)
                        .frame(height: !isLast ? nil : 0)
                        .opacity(!isLast ? 1 : 0)
                    HStack{
                        Text("进入登录注册")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .font(.custom("Slideqiuhong",size:20))
                        
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 15)
                    .scaleEffect(isLast ? 1 : 0.001)
                    .frame(height: isLast ? nil : 0)
                    .opacity(isLast ? 1 : 0)
                }
                .frame(width: isLast ? size.width / 1.5 : 55, height: isLast ? 50 : 55)
                .foregroundColor(.white)
                .background {
                    RoundedRectangle(cornerRadius: isLast ? 10 : 30, style: isLast ? .continuous : .circular)
                        .fill(Color("DeepGreen"))
                }
                .onTapGesture {
                    if currentIndex == intros.count {
                        showHomeView = true //进入注册页面
                    } else {
                        currentIndex += 1
                    }
                }
                .offset(y:isLast ? -40 : -90)
                .animation(.interactiveSpring(response: 0.91, dampingFraction: 0.85, blendDuration: 0.5), value: isLast)
                
                    
            }
            .overlay(alignment: .bottom, content: {
                let isLast = currentIndex == intros.count
//                HStack(spacing: 5) {
//                    Text("已经有账户了？")
//                        .font(.title3)
//                        .foregroundColor(.gray)
//                        .font(.custom("Slideqiuhong",size:20))
//
//                    Button("登录") {
//
//                    }
//                    .font(.title3)
//                    .foregroundColor(Color("DeepGreen"))
//                    .font(.custom("Slideqiuhong",size:20))
//                }
//                .offset(y: isLast ? -12 : 100)
//                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
            })
            .offset(y: showWalkThroughScrrens ? 0 : size.height)
        }
    }
    
    // 中间页面
    @ViewBuilder
    func ScreeenView(size: CGSize, index: Int) -> some View {
        let intro = intros[index]
        VStack(spacing: 10) {
            Text(intro.title)
                //.font(.title)
                // .font(.system(size: 40, weight: .heavy, design: .rounded))
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
                .font(.custom("Slideqiuhong",size:40))
            
            Text(intro.introduction)
                //.font(.callout)
                .font(.custom("Slideqiuhong",size:20))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .bold()
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode:.fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal, 20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
        }
    }
    
    // 最后的页面
    @ViewBuilder
    func WelcomeView(size: CGSize, index: Int) -> some View {
        VStack(spacing: 30) {
            Image("Welcome")
                .resizable()
                .aspectRatio(contentMode:.fill)
                .frame(width: size.width, height: size.height / 2)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
                .clipped()
        
            
            Text("欢迎使用")
                //.font(.title)
                .font(.custom("Slideqiuhong",size:20))
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
            
            Text("开启一段奇妙的音乐之旅吧！")
                //.font(.callout)
                .font(.custom("Slideqiuhong",size:20))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.1 : 0), value: currentIndex)
        }
        .ignoresSafeArea()
    }
    
    // 导航页
    @ViewBuilder
    func NavBar() -> some View {
        let isLast = currentIndex == intros.count
        HStack {
            Button {
                if currentIndex > 0 {
                    currentIndex -= 1
                } else {
                    showWalkThroughScrrens.toggle()
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Blue"))
            }
            
            Spacer()
            Button("跳过") {
                currentIndex = intros.count
            }
            .font(.body)
            .foregroundColor(Color("DeepGreen"))
            .opacity(isLast ? 0 : 1)
            .animation(.easeOut, value: isLast)
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)
        .frame(maxHeight: .infinity, alignment: .top)
        .offset(y: showWalkThroughScrrens ? 0 : -120)
    }
    
    // 最开始的页面
    @ViewBuilder
    func IntroScreen() -> some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 10) {
                Image("Introduction")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height / 2)
                    .clipped()
                
                Text("御乐变风")
                    //.font(.largeTitle)
                    .padding(.top, 20)
                    //.font(.system(size: 40, weight: .heavy, design: .rounded))
                    .font(.custom("Slideqiuhong",size:40))
                
                Text(dummyText)
                   // .font(.callout)
                    .font(.custom("Slideqiuhong",size:20))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .bold()
                
                Text("进入引导")
                    //.font(.body)
                    .font(.custom("Slideqiuhong",size:20))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 14)
                    .foregroundColor(.white)
                    .bold()
                    .background {
                        Capsule()
                            .fill(Color("DeepGreen"))
                    }
                    .onTapGesture {
                        showWalkThroughScrrens.toggle()
                    }
                    .padding(.top, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .offset(y: showWalkThroughScrrens ? -size.height : 0)
        }
        .ignoresSafeArea()
    }
}

struct BeginView_Previews: PreviewProvider {
    static var previews: some View {
        BeginView()
    }
}

struct Home: View {
    var body: some View {
        NavigationStack {
            GuideView()
        }
    }
}
