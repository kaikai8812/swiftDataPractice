//
//  SheetView.swift
//  swiftDataPractice
//
//  Created by 青山凱 on 2023/12/27.
//

import SwiftUI

struct SheetView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State var user: UserModel
    @State var isShow: Bool
    
    var body: some View {
        VStack {
            Button("編集画面を閉じる") {
                dismiss()
            }
            .buttonStyle(.bordered)
            .padding(.vertical, 20)
            
            VStack(spacing: 5, content: {
                Text("名前を編集")
                TextField("名前", text: $user.name)
                    .textFieldStyle(.roundedBorder)
            })
            
            VStack(spacing: 5, content: {
                Text("年齢を編集")
                TextField("年齢", value: $user.age, format: .number)
                    .textFieldStyle(.roundedBorder)
            })
        }
        Spacer()
    }
}

#Preview {
    SheetView(user: .init(name: "testUser", age: 100), isShow: true)
        .modelContainer(for: UserModel.self)
}
