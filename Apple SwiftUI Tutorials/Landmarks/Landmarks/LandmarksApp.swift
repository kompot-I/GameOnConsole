//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Nikita  Zubov on 01.10.2022.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
