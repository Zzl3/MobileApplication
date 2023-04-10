//
//  test.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/9.
//

import SwiftUI
 
struct ContenttView: View {
    @State var instrumentList: InstrumentList?
        
    var body: some View {
        VStack {
            if let musicList = instrumentList {
                List(musicList.data, id: \.id) { music in
                    VStack(alignment: .leading) {
                        Text(music.name)
                            .font(.headline)
                        Text(music.description)
                            .font(.subheadline)
                        Spacer()
                    }
                }
                .listStyle(InsetListStyle())
                .padding(.vertical)
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            fetchData(for: "拉弦")
        }
    }
        
    func fetchData(for type: String) {
        if let encodedString = type.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let urlString = "http://123.60.156.14:5000/instrument?category=\(encodedString)"
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
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
 
struct Contentt_Previews:PreviewProvider{
     static var previews: some View {
         ContenttView()
    }
}
