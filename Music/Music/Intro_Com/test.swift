//
//  test.swift
//  Music
//
//  Created by 周紫蕾 on 2023/4/9.
//

//import SwiftUI
//struct UserProfileView: View {
//    @State private var isEditingName = false
//    @State private var newName = ""
//    @State private var selectedImage: UIImage?
//    var body: some View {
//        VStack {
//            Button(action: {
//                // 选择头像的代码
//            }) {
//                if let image = selectedImage {
//                    Image(uiImage: image)
//                        .resizable()
//                        .frame(width: 100, height: 100)
//                        .clipShape(Circle())
//                } else {
//                    Image(systemName: "person.circle.fill")
//                        .resizable()
//                        .frame(width: 100, height: 100)
//                }
//            }
//            if isEditingName {
//                TextField("输入新昵称", text: $newName)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//            } else {
//                Text("用户昵称")
//            }
//            Button(action: {
//                isEditingName.toggle()
//            }) {
//                if isEditingName {
//                    Text("完成")
//                } else {
//                    Text("编辑")
//                }
//            }
//        }
//    }
//}
//struct ImagePicker: UIViewControllerRepresentable {
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var image: UIImage?
//    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//        let parent: ImagePicker
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let image = info[.originalImage] as? UIImage {
//                parent.image = image
//            }
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
//    }
//}
//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView()
//    }
//}
