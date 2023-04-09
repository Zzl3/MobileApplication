//
//  ContentView.swift
//  Music
//
//  Created by 周紫蕾 on 2023/3/16.
//

import SwiftUI

struct Introduction: View {
//    @State var cards:[RotateCard]=[
//        .init(nowindex:0),
//        .init(nowindex:0)]
    @State var instrumentList: InstrumentList?
    var body: some View {
        VStack{
            Intro_Nav()
            Spacer(minLength: 30)
            CardsScrollView()
        }
        .onAppear {fetchData()}
        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.945, green: 0.949, blue: 0.949)/*@END_MENU_TOKEN@*/)
    }
    
    func fetchData() {
        let url = URL(string: "http://123.60.156.14:5000/instrument")! // Replace with your API URL
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
    
    @ViewBuilder
    func CardsScrollView()->some View{
        ScrollView(.horizontal,showsIndicators: false){
            HStack(spacing:15){
                if let instrumentList = instrumentList {
                    ForEach(instrumentList.data, id: \.id){ instrument in
                        VStack{
                            RotateCard(instrument: instrument)
                            .frame(width: 350, height: 700)
                        }
                    }
                    .foregroundColor(Color(red: 0.949, green: 0.949, blue: 0.949))
                    .padding(.leading,20)
                } else {
                    Text("Loading...")
                }
            }
            .onAppear {
                fetchData()
            }
        }
    }
}

struct Introduction_Previews: PreviewProvider {
    static var previews: some View {
        Introduction()
    }
}
    
