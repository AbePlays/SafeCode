//
//  ContentView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 25/07/23.
//

import SwiftUI

enum Tabs {
    case home
    case saved
}

struct ContentView: View {
    @State private var currentTab: Tabs = .home
    
    var body: some View {
        TabView(selection: $currentTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tabs.home)
            
            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "tray")
                }
                .tag(Tabs.saved)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
