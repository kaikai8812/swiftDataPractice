//
//  ContentView.swift
//  swiftDataPractice
//
//  Created by 青山凱 on 2023/12/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(UserStore.self) var store
    
    @State private var inputName: String = ""
    @State private var inputAge: String = ""
    @State private var sheet = false
    
    var users: [UserModel] {
        store.values
    }
    
    var body: some View {
        VStack {
            List(users) { user in
                HStack(alignment: .top)  {
                    Text(user.name)
                    Text("\(String(user.age))歳")
                        .padding(.leading, 10)
                    Spacer()
                    Text("編集する")
                        .onTapGesture {
                            sheet.toggle()
                        }
                    Spacer()
                    Text("削除する")
                        .onTapGesture {
                            Task {
                                try await delete(user: user)
                            }
                        }
                }
                .sheet(isPresented: $sheet, content: {
                    SheetRepositoryView(isShow: sheet, userModel: user)
                })
            }
            .task {
                do {
                    try await store.loadAllValue()
                } catch {
                    print("エラーが発生してしまった！")
                }
            }
            
            Button("追加する") {
                guard let age = Int(inputAge) else { return }
                Task {
                    try await save(user: UserModel(name: inputName, age: age))
                }
            }
            
            TextField("名前", text: $inputName)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            TextField("年齢", text: $inputAge)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
        .padding()
    }
    
    private func save(user: UserModel) async throws {
        await store.setUser(user)
        try await store.loadAllValue()
    }
    
    private func delete(user: UserModel) async throws {
        await store.deleteUser(user)
        try await store.loadAllValue()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: UserModel.self, isAutosaveEnabled: false)
}
