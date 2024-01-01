//
//  UserRepository.swift
//  swiftDataPractice
//
//  Created by 青山凱 on 2023/12/30.
//

import Foundation
import SwiftData

class UserRepository {
    
    private var modelContext: ModelContext
    
    init() {
        let schema = Schema([UserModel.self])
        let modelConfiguration = ModelConfiguration(schema: schema)
        let modelContainer = try! ModelContainer(
            for: UserModel.self,
            configurations: modelConfiguration
        )
        
        modelContext = ModelContext(modelContainer)
    }
    
    static let shared: UserRepository = .init()
    
    func loadAllValue() async throws -> [UserModel] {
        // モデルの取得
//        try await Task.sleep(nanoseconds: UInt64(5 * 1_000_000_000))
        let fetchDescriptor = FetchDescriptor<UserModel>()
        let fetchedItems = try! modelContext.fetch(fetchDescriptor)
        return fetchedItems
    }
    
    func loadValue(name: String) async throws -> UserModel? {
        try await Task.sleep(nanoseconds: UInt64(3 * 1_000_000_000))
        let fetchDescriptor = FetchDescriptor<UserModel>()
        let fetchedItems = try! modelContext.fetch(fetchDescriptor)
        
        return fetchedItems.first { fetchedUser in
            fetchedUser.name == name
        }
    }
    
    func saveUser(user: UserModel) {
        print("これが保存されているよ！\(user.name)")
        modelContext.insert(user)
        do {
            try modelContext.save()
            print("contextのセーブが完了しました")
        } catch {
            print("データ保存が失敗しました")
        }
    }
    
    func deleteUser(user: UserModel) {
        modelContext.delete(user)
        do {
            try modelContext.save()
            print("contextのセーブが完了しました")
        } catch {
            print("データ保存が失敗しました")
        }
    }
    
    func editUser(oridinalUser: UserModel, name: String?, age: Int?) {
        let newUser = UserModel(name: name ?? oridinalUser.name, age: age ?? oridinalUser.age)
        modelContext.insert(newUser)
        
        do {
            try modelContext.save()
            print("contextのセーブが完了しました")
        } catch {
            print("データ保存が失敗しました")
        }
    }
    
}
