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
            fetchData()
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
                    }
                }
            }
        }.resume()
    }
}
 
struct Contentt_Previews:PreviewProvider{
     static var previews: some View {
         ContenttView()
    }
}
