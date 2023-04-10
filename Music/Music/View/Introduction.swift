//
//  ContentView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/16.
//

import SwiftUI

struct Introduction: View {
    @State var instrumentList: InstrumentList?
    @State var selectedCategory: Int = 0 //保存当前索引
    @State var instrumentsByCategory: [String: [Instrument]] = [:] //字典保存值
    
    let categories = ["拉弦", "吹管", "打击", "弹拨"]
    
    var body: some View {
        VStack{
            // Intro_Nav()
            // Spacer(minLength: 30)
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
        .padding(.bottom, 90)
        .onAppear {fetchData()}
        .foregroundColor(Color(red: 0.945, green: 0.949, blue: 0.949))
        .onChange(of: selectedCategory) { newValue in
            switch newValue {
            case 0:
                fetchDataType(for: "拉弦乐器")
            case 1:
                fetchDataType(for: "吹管乐器")
            case 2:
                fetchDataType(for: "打击乐器")
            case 3:
                fetchDataType(for: "弹拨乐器")
            default:
                fetchData()
            }
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
    
    func fetchDataType(for type: String) {
        if let instruments = instrumentsByCategory[type] {// 使用缓存数据
            self.instrumentList = InstrumentList(code: 200,msg: instruments.count,data: instruments)
            print(self.instrumentList as Any)
        } else {
            if let encodedString = type.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let urlString = "http://123.60.156.14:5000/instrument?category=\(encodedString)"
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
                if let instrumentList = instrumentList {
                    ForEach(instrumentList.data, id: \.id){ instrument in
                        VStack{
                            RotateCard(instrument: instrument)
                            .frame(width: 350, height: 550)
                        }
                    }
                    .foregroundColor(Color(red: 0.949, green: 0.949, blue: 0.949))
                    .padding(.leading,20)
                } else {
                    Text("Loading...")
                }
            }
        }
    }
}

struct Introduction_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
