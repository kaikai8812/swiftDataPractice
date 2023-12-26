//
//  SampleModel.swift
//  swiftDataPractice
//
//  Created by 青山凱 on 2023/12/26.
//

import Foundation
import SwiftData

@Model
class UserModel {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
