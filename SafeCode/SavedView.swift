//
//  SavedView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 05/08/23.
//

import SwiftUI

struct SavedView: View {
    @FetchRequest(sortDescriptors: []) var passwords: FetchedResults<Credential>
    
    @State private var searchText = ""
    
    var searchResults: [Credential] {
        if searchText.isEmpty {
            return Array(passwords)
        } else {
            return passwords.filter { password in
                return password.service?.contains(searchText) ?? false
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if searchResults.isEmpty {
                    Text("No passwords saved.")
                } else {
                    List(searchResults) { password in
                        NavigationLink {
                            EntityView(password: password)
                        } label: {
                            Text(password.service ?? "")
                        }
                    }
                }
            }
            .navigationTitle("Saved Passwords")
            .searchable(text: $searchText, placement: .toolbar)
        }
        
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}
