//
//  SheetRepositoryView.swift
//  swiftDataPractice
//
//  Created by 青山凱 on 2024/01/01.
//

import SwiftUI

struct SheetRepositoryView: View {
    
    @Environment(UserStore.self) var store
    @Environment(\.dismiss) private var dismiss
    @State var isShow: Bool
    @State var userModel: UserModel
    
    var dbUser: UserModel? { store.value }

    var body: some View {
        
        VStack {
            Button("編集画面を閉じる") {
                dismiss()
            }
            .buttonStyle(.bordered)
            .padding(.vertical, 20)
            
            Text("現在の名前：\(dbUser?.name ?? "")")
            
            VStack(spacing: 5, content: {
                Text("名前を編集")
                TextField("名前", text: $userModel.name)
            })
            
            VStack(spacing: 5, content: {
                Text("年齢を編集")
                TextField("年齢", value: $userModel.age, format: .number)
                    .textFieldStyle(.roundedBorder)
            })
        }
        .task {
            Task.detached {
                try await store.loadValue(name: userModel.name)
            }
        }
        Spacer()
    }
}

//#Preview {
//    SheetRepositoryView()
//}
