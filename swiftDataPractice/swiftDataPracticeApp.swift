//
//  swiftDataPracticeApp.swift
//  swiftDataPractice
//
//  Created by 青山凱 on 2023/12/26.
//

import SwiftUI
import SwiftData

@main
struct swiftDataPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: UserModel.self)
        }
    }
}
