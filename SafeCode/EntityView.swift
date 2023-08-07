//
//  EntityView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 06/08/23.
//

import SwiftUI

struct EntityView: View {
    let id: UUID
    @FetchRequest(sortDescriptors: []) var passwords: FetchedResults<Password>
    
    @State private var copied = false
    @State private var showSheet = false
    
    var password: Password {
        if let savedPassword = passwords.first(where: { password in
            password.id == id
        }) {
            return savedPassword
        } else {
            fatalError("Core Data could not find record of Id \(id)")
        }
    }
    
    var body: some View {
        List {
            HStack {
                Text("Service: ")
                    .bold()
                Text(password.service ?? "")
            }
            
            HStack {
                Text("Username: ")
                    .bold()
                Text(password.username ?? "")
            }
            
            HStack {
                Text("Password: ")
                    .bold()
                
                HStack {
                    Text(password.password ?? "")
                    Button {
                        // Copy to clipboard
                        UIPasteboard.general.string = password.password
                        withAnimation {
                            copied = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                copied = false
                            }
                        }
                    } label: {
                        Image(systemName: copied ? "checkmark" : "doc.on.doc")
                            .accessibilityLabel(copied ? "Copied" : "Copy")
                    }
                }
            }
            
            HStack {
                Text("Created On: ")
                    .bold()
                
                Text(password.createdAt?.formatted() ?? "")
            }
            
            HStack {
                Text("Last Updated On: ")
                    .bold()
                Text(password.updatedAt?.formatted() ?? "")
            }
        }
        .sheet(isPresented: $showSheet) {
            SaveEntityView(
                id: id,
                onSave: {
                    showSheet = false
                }
            )
        }
        .toolbar {
            ToolbarItem (placement: .navigationBarTrailing) {
                Button {
                    showSheet = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .accessibilityLabel(Text("Edit"))
                }
            }
        }
    }
}

struct EntityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EntityView(id: UUID())
        }
    }
}
