//
//  SafeCodeApp.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 25/07/23.
//

import SwiftUI

@main
struct SafeCodeApp: App {
    private var userData = Data()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
        }
    }
}
