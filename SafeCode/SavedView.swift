//
//  SavedView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 05/08/23.
//

import SwiftUI

struct SavedView: View {
    @EnvironmentObject var userData: Data
    
    var body: some View {
        NavigationStack {
            VStack {
                if userData.entities.isEmpty {
                    Text("No passwords saved.")
                } else {
                    let sortedEntities = userData.entities.sorted(by: { a, b in
                        a.createdAt > b.createdAt
                    })
                    List(sortedEntities) { entity in
                        Text(entity.label)
                    }
                }
            }
            .navigationTitle("Saved Passwords")
        }
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
            .environmentObject(Data())
    }
}
