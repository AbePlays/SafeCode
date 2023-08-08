//
//  SaveEntityView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 05/08/23.
//

import SwiftUI

struct SaveEntityView: View {
    var id: UUID?
    var password: String?
    let onSave: () -> ()
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: []) var passwords: FetchedResults<Password>
    
    @State private var label = ""
    @State private var service = ""
    @State private var username = ""
    @State private var editPassword = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", text: $service)
                } header: {
                    Text("Service")
                }
                
                Section {
                    TextField("", text: $username)
                } header: {
                    Text("Username")
                }
                
                if (id == nil) {
                    Section {
                        Text(password ?? "")
                    } header: {
                        Text("Your Password")
                    }
                } else {
                    Section {
                        TextField("", text: $editPassword)
                    } header: {
                        Text("Password")
                    }
                }
                
                Button {
                    if let currentPassword = passwords.first(where: { password in
                        password.id == id
                    }) {
                        currentPassword.username = username
                        currentPassword.password = editPassword
                        currentPassword.service = service
                        currentPassword.updatedAt = Date.now
                    } else {
                        let newPassword = Password(context: moc)
                        
                        newPassword.id = UUID()
                        newPassword.username = username
                        newPassword.password = password
                        newPassword.service = service
                        newPassword.createdAt = Date.now
                        newPassword.updatedAt = Date.now
                    }
                    
                    try? moc.save()
                    showAlert = true
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(service.isEmpty || username.isEmpty)
            }
            .alert("Password Saved Successfully", isPresented: $showAlert) {
                Button("OK") {
                    onSave()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(id == nil ? "Save your password" : "Edit your password")
            .onAppear {
                if id != nil {
                    if let savedPassword = passwords.first(where: { password in
                        password.id == id
                    }) {
                        service = savedPassword.service ?? ""
                        username = savedPassword.username ?? ""
                        editPassword = savedPassword.password ?? ""
                    } else {
                        fatalError("Core Data does not contain an entry with id \(id!)")
                    }
                }
            }
            .toolbar() {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct SaveEntityView_Previews: PreviewProvider {
    static var previews: some View {
        SaveEntityView(password: "123456", onSave: {})
    }
}
