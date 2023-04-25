//
//  ProfileView.swift
//  Music
//
//  Created by sihhd on 2023/4/12.
//

import SwiftUI
import Combine

struct ProfileView: View {
    
    @Environment(\.presentationMode)  var presentationMode
    @EnvironmentObject var appSettings: AppSettings
    @State var showingImagePicker: Bool = false
    @State var inputImage: UIImage?
    //@State var profileImage: String?
    @State private var isEditingName = false
    //@State private var newName = "用户昵称"
    
    // 关于用户数据
    @State var password:String = "123456"
    @State var userid:Int = 22
    @State var mail:String = "2039129107@qq.com"
    @State var avatar:String = "https://musicstyle.oss-cn-shanghai.aliyuncs.com/images/1c9f7979c81c46a186eedfd24cb81e89/image.jpeg"
    @State var username:String = "默认用户"
     
    var body: some View {
        VStack {
            NavigationView {
                List {
                    Section {
                        headPortrait
                    }
                    Section{
                        NavigationLink(destination: AppearanceSetView()) {
                            SettingItemView(iconName: "paintpalette.fill", title: "外观设置", bgColor: Color.accentColor)
                        }

                        NavigationLink(destination: HistoryView()) {
                            SettingItemView(iconName: "record.circle", title: "历史记录", bgColor: Color.accentColor)
                        }

                        NavigationLink(destination: CollectionView()) {
                            SettingItemView(iconName: "bookmark.circle", title: "我的收藏", bgColor: Color.accentColor)
                        }
                        
                        NavigationLink(destination: FeedBack()) {
                            SettingItemView(iconName: "applepencil", title: "提交反馈", bgColor: Color.accentColor)
                        }

                        NavigationLink(destination: AboutUsView()) {
                            SettingItemView(iconName: "person.bust", title: "关于我们", bgColor: Color.accentColor)
                        }
                    }
                    
                    Section {
                        HStack{
                            Spacer()
                            Button(action: {}) {
                                Text("退出登录")
                                    .foregroundColor(Color.primary)
                                    .font(.title2)
                            }
                            
                            Spacer()
                        }
                        .frame(height: 40)
                    }
                    
                }
                .listRowSeparator(.hidden)
                .navigationBarTitle("账户", displayMode: .inline)
                .toolbar {
                    Button("完成", action: close)
                        .foregroundColor(Color.primary)
                }
                
            }
            .navigationViewStyle(.stack)
            .accentColor(accentColorData[self.appSettings.accentColorSettings].color)
            
        }
        .background(
            Image("huawen2")
                .resizable()
                .scaledToFit()
                .frame(width: 400,height: 900)
                //.background(Color("LightGreen"))
                .opacity(0.3)
        )
    }
    
    var headPortrait: some View {
        let userDefault=UserDefaults.standard
//        mail=userDefault.string(forKey: "mail")!
//        userid=userDefault.integer(forKey: "userid")
//        password=userDefault.string(forKey: "password")!
//        avatar=userDefault.string(forKey:"avatar")!
//        username=userDefault.string(forKey: "username")!
        mail=""
        if(mail==""){
            mail="2039129107@qq.com"
            password="123456"
            userid=22
            avatar="https://musicstyle.oss-cn-shanghai.aliyuncs.com/images/1c9f7979c81c46a186eedfd24cb81e89/image.jpeg"
            username="默认用户"
        }
        
        return HStack {
            Image(uiImage: UIImage.fetchImage(from: avatar))
                .resizable()
                .frame(width: 60, height: 60.0).cornerRadius(30)
                .onTapGesture {
                    self.showingImagePicker = true
                }
               
            VStack(alignment: .leading, spacing: 4.0) {
                HStack{
                    if isEditingName {
                        TextField("输入新昵称", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(Color.primary)
                    } else {
                        Text(username)
                            .foregroundColor(Color.primary)
                    }
                    
                    Button(action: {
                        isEditingName.toggle()
                    }) {
                        if isEditingName {
                            Text("完成")
                                .foregroundColor(Color.secondary)
                        } else {
                            Text("编辑")
                                .foregroundColor(Color.secondary)
                                .onAppear{
                                    print("New username: \(username)")
                                    editdata() // 修改用户名
                                }
                        }
                    }
                }
                Text(mail)
                    .foregroundColor(Color.secondary)
            }
            .padding(.leading, 8.0)
        }
        .padding(.vertical, 8.0)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func editdata(){
        print("开始修改用户信息")
        let params = ["user_id": userid,"password": password,"username":username,"avatar":avatar] as [String : Any]
        let url = URL(string: "http://123.60.156.14:5000/modify_user_info")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("发生错误：\(error.localizedDescription)")
                return
            }
            if let data = data {
                print(data)
            }
        }.resume()
    }
    
    
    func close() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func loadImage() {
        print("开始得到图片url")
        guard let inputImage = inputImage else { return }
        let imageData = inputImage.pngData() // 将UIImage转换为png格式的Data
        //创建一个URLRequest对象并设置请求头和HTTP方法
        let url = URL(string: "http://123.60.156.14:5000/upload_files")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        //创建一个multipart/form-data格式的HTTPBody
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let httpBody = NSMutableData()
        httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
        httpBody.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.png\"\r\n".data(using: .utf8)!)
        httpBody.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        httpBody.append(imageData!)
        httpBody.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = httpBody as Data
        //创建一个URLSessionDataTask并发送请求
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                if let imageList = try? decoder.decode(ImageList.self, from: data) {
                    DispatchQueue.main.async {
                        let imagedata=imageList.data[0]
                        avatar = imagedata.url
                        print(avatar)
                        print("修改用户头像完成")
                        editdata()
                    }
                }
            }
        }
        task.resume()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
}

struct SettingItemView: View {
    
    // MARK: - icon
    var iconName: String
    
    // MARK: - title
    var title: String
    
    // MARK: - bg color
    var bgColor: Color
    
    // MARK: - Body
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .imageScale(.medium)
                .scaledToFit()
                .frame(width: 28, height: 28, alignment: .center)
                .background(bgColor)
                .foregroundColor(Color.white)
                .cornerRadius(6)
    
            Text(title)
                .foregroundColor(Color.primary)
                .font(.body)
                .padding(.leading, 4.0)
                
        }
        .padding(.vertical, 8.0)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AppSettings())
    }
}

//VStack{
//                    List{
//                        Section{
//                            NavigationLink(destination: AppearanceSetView()) {
//                                SettingItemView(iconName: "paintpalette.fill", title: "外观设置", bgColor: Color.accentColor)
//                            }
//                        }
//
//
//                        Section{
//                            NavigationLink(destination: HistoryView()) {
//                                SettingItemView(iconName: "record.circle", title: "历史记录", bgColor: Color.accentColor)
//                            }
//                        }
//
//                        Section{
//                            NavigationLink(destination: CollectionView()) {
//                                SettingItemView(iconName: "bookmark.circle", title: "我的收藏", bgColor: Color.accentColor)
//                            }
//                        }
//
//                        Section{
//                            NavigationLink(destination: FeedBack()) {
//                                SettingItemView(iconName: "applepencil", title: "提交反馈", bgColor: Color.accentColor)
//                            }
//                        }
//
//                        Section{
//                            NavigationLink(destination: AboutUsView()) {
//                                SettingItemView(iconName: "person.bust", title: "关于我们", bgColor: Color.accentColor)
//                            }
//                        }
//                    }
//                }
