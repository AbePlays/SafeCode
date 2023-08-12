//
//  SaveEntityView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 05/08/23.
//

import CoreData
import SwiftUI

struct SaveEntityView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    var credential: Credential
    
    @State private var service = ""
    @State private var username = ""
    @State private var editPassword = ""
    @State private var showAlert = false
    
    func savePassword() {
        if (credential.username ?? "").isEmpty {
            credential.createdAt = Date.now
        } else {
            credential.updatedAt = Date.now
        }
        
        credential.service = service
        credential.username = username
        credential.password = editPassword
        
        try? moc.save()
        showAlert = true
    }
    
    func isSaveDisabled() -> Bool {
        return service.isEmpty || username.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                VStack(spacing: 5) {
                    Text((credential.username ?? "").isEmpty  ? "Save" : "Edit")
                        .fontWeight(.semibold)
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("your credential")
                        .fontWeight(.semibold)
                        .font(.title)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack(spacing: 20) {
                    Input(text: $service, label: "Service")
                    
                    Input(text: $username, label: "User Name")
                    
                    Input(text: $editPassword, label: "Password", isDisabled: (credential.username ?? "").isEmpty)
                    
                    Button {
                        savePassword()
                    } label: {
                        Text("Save")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding([.vertical], 10)
                            .background(isSaveDisabled() ? Color("disabled") : .black)
                            .cornerRadius(8)
                    }
                    .disabled(isSaveDisabled())
                    .padding(.top, 10)
                }
                
                Spacer()
            }
            .alert("Credential saved successfully", isPresented: $showAlert) {
                Button("Ok") {
                    dismiss()
                }
            }
            .onAppear {
                editPassword = credential.password ?? ""
            }
            .padding()
            .toolbar() {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.primary)
                }
            }
        }
    }
}
