//
//  SavedView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 05/08/23.
//

import SwiftUI

struct SavedView: View {
    @FetchRequest(sortDescriptors: []) var passwords: FetchedResults<Password>
    
    var body: some View {
        NavigationStack {
            VStack {
                if passwords.isEmpty {
                    Text("No passwords saved.")
                } else {
                    List(passwords) { password in
                        NavigationLink {
                            EntityView(password: password)
                        } label: {
                            Text(password.service ?? "")
                        }
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
    }
}
