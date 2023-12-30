//
//  UserStore.swift
//  swiftDataPractice
//
//  Created by 青山凱 on 2023/12/30.
//

import Foundation
import Observation

@Observable
final class UserStore {
    private(set) var values: [UserModel] = []
    
    private static let shared: UserStore = .init()
    
    func loadAllValue() async throws {
        let values = try await UserRepository.shared.loadAllValue()
        self.values = values
    }
    
    func setUser(_ user: UserModel) async{
        try! await UserRepository.shared.saveUser(user: user)
    }
    
    func deleteUser(_ user: UserModel) async {
        try! await UserRepository.shared.deleteUser(user: user)
    }
}


