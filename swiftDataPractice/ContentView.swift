//
//  ContentView.swift
//  swiftDataPractice
//
//  Created by 青山凱 on 2023/12/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var users: [UserModel]
    
    @State private var inputName: String = ""
    @State private var inputAge: String = ""
    @State private var sheet = false
    
    var body: some View {
        VStack {
            List(users) { user in
                HStack {
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
                            context.delete(user)
                        }
                }
                .sheet(isPresented: $sheet, content: {
                    SheetView(user: user, isShow: sheet)
                })
            }
            
            Button("追加する") {
                guard let age = Int(inputAge) else { return }
                let data = UserModel(name: inputName, age: age)
                context.insert(data)
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
}

#Preview {
    ContentView()
        .modelContainer(for: UserModel.self)
}
