//
//  SafeCodeApp.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 25/07/23.
//

import SwiftUI

@main
struct SafeCodeApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
