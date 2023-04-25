//
//  ContentView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/16.
//

import SwiftUI

struct Introduction: View {
    @EnvironmentObject var appSettings: AppSettings
    @State var instrumentList: InstrumentList?
    @State var selectedCategory: Int = 0 //保存当前索引
    @State var instrumentsByCategory: [String: [Instrument]] = [:] //字典保存值
    @State private var searchText = "" //保存输入框的值
    @State private var isKeyboardVisible = false
    
    let categories = ["拉弦", "吹管", "打击", "弹拨"]
    
    var body: some View {
        ZStack {
            VStack{
                // Spacer(minLength: 30)
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(red: 0.388, green: 0.46, blue: 0.373))
                        
                        TextField("Search", text: $searchText,onCommit: {
                            fetchDataType(for: searchText,other: "name")
                        })
                        .tint(Color(red: 0.388, green: 0.46, blue: 0.373))
                        .foregroundColor(.primary)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.black)
                            .opacity(0.15)
                    }
                    .padding(.horizontal)
                }
                
                Picker(selection: $selectedCategory, label: Text("Category")) {
                    ForEach(0 ..< categories.count) { index in
                        Text(categories[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                Spacer()
                CardsScrollView()
            }
            .padding(.bottom, 50)
            .onAppear {fetchData()}
            .foregroundColor(Color(red: 0.945, green: 0.949, blue: 0.949))
            .onChange(of: selectedCategory) { newValue in
                switch newValue {
                case 0:
                    fetchDataType(for: "拉弦乐器",other: "category")
                case 1:
                    fetchDataType(for: "吹管乐器",other: "category")
                case 2:
                    fetchDataType(for: "打击乐器",other: "category")
                case 3:
                    fetchDataType(for: "弹拨乐器",other: "category")
                default:
                    fetchData()
                }
            }
            .offset(y: isKeyboardVisible ? -200 : 0)
        }
        .onAppear {
            // 监听键盘的出现
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                isKeyboardVisible = true
            }
            
            // 监听键盘的消失
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
                isKeyboardVisible = false
            }
        }
        .onDisappear {
            // 移除键盘的监听
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    func fetchData() {
        let url = URL(string: "http://123.60.156.14:5000/instrument")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let instrumentList = try? decoder.decode(InstrumentList.self, from: data) {
                    DispatchQueue.main.async {
                        self.instrumentList = instrumentList
                        // 将所有乐器按照类别进行分类
                        var instrumentsByCategory = [String: [Instrument]]()
                        for instrument in instrumentList.data {
                            let category = instrument.category
                            if instrumentsByCategory[category] == nil {
                                instrumentsByCategory[category] = [Instrument]()
                            }
                            instrumentsByCategory[category]?.append(instrument)
                        }
                        self.instrumentsByCategory = instrumentsByCategory
                        //print(instrumentsByCategory)
                    }
                }
            }
        }.resume()
    }
    
    func fetchDataType(for type: String,other para: String) {
        if let instruments = instrumentsByCategory[type] {// 使用缓存数据
            self.instrumentList = InstrumentList(code: 200,msg: instruments.count,data: instruments)
            print(self.instrumentList as Any)
        } else {
            if let encodedString = type.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let urlString = "http://123.60.156.14:5000/instrument?\(para)=\(encodedString)"
                guard let url = URL(string: urlString) else {
                    print("Invalid URL")
                    return
                }
                print(url)
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        let decoder = JSONDecoder()
                        if let instrumentList = try? decoder.decode(InstrumentList.self, from: data) {
                            DispatchQueue.main.async {
                                self.instrumentList = instrumentList
                            }
                        }
                    }
                }.resume()
            }
        }
    }
    
    @ViewBuilder
    func CardsScrollView()->some View{
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing:15){
                //动态数据
                if let instrumentList = instrumentList {
                    ForEach(instrumentList.data, id: \.id){ instrument in
                        VStack{
                            RotateCard(instrument: instrument)
                            .frame(width: 350, height: 550)
                        }
                    }
                    .foregroundColor(Color(red: 0.949, green: 0.949, blue: 0.949))
                    .padding(.leading,20)
                    .padding(.bottom,50)
                } else {
                    LoadingView()
                        .position(x:195,y:180)
                }
                
                //静态数据
//                ForEach(sampleInstrument, id: \.id){ instrument in
//                    VStack{
//                        RotateCard(instrument: instrument)
//                        .frame(width: 350, height: 550)
//                    }
//                }
//                .foregroundColor(Color(red: 0.949, green: 0.949, blue: 0.949))
//                .padding(.leading,20)
            }
        }
    }
}

struct Introduction_Previews: PreviewProvider {
    static var previews: some View {
        BaseView().environmentObject(AppSettings())
    }
}
