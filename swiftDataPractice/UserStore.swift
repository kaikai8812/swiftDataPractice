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
    private(set) var value: UserModel?
    
    private static let shared: UserStore = .init()
    
    func loadAllValue() async throws {
        let values = try await UserRepository.shared.loadAllValue()
        self.values = values
    }
    
    func loadValue(name: String) async throws {
        let value = try await UserRepository.shared.loadValue(name: name)
        self.value = value
    }
    
    func setUser(_ user: UserModel) async {
        try! await UserRepository.shared.saveUser(user: user)
    }
    
    func deleteUser(_ user: UserModel) async {
        try! await UserRepository.shared.deleteUser(user: user)
    }
    
    func editUser(editUserModel: UserModel, name: String?, age: Int?) {
        UserRepository.shared.editUser(oridinalUser: editUserModel, name: name, age: age)
    }
}


