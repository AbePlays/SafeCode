//
//  SaveEntityView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 05/08/23.
//

import CoreData
import SwiftUI

struct SaveCredentialView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    var credential: Credential?
    var password: String?
    
    @State private var service = ""
    @State private var username = ""
    @State private var editPassword = ""
    @State private var showAlert = false
    
    func savePassword() {
        if password != nil {
            //  Create
            let newCredential = Credential(context: moc)
            newCredential.id = UUID()
            newCredential.service = service
            newCredential.username = username
            newCredential.password = password
            newCredential.createdAt = Date.now
        } else if credential != nil {
            //  Update
            credential?.updatedAt = Date.now
            credential?.service = service
            credential?.username = username
            credential?.password = editPassword
        } else {
            fatalError("This should never occur")
        }
        
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
                    Text(password != nil  ? "Save" : "Edit")
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
                    
                    Input(text: $editPassword, label: "Password", isDisabled: password != nil)
                    
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
                editPassword = (password == nil ? credential?.password ?? "" : password) ?? ""
                service = credential?.service ?? ""
                username = credential?.username ?? ""
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

struct SaveCredentialView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        var credential: Credential {
            let cred = Credential(context: moc)
            cred.id = UUID()
            cred.password = "123456"
            cred.createdAt = Date.now
            cred.updatedAt = Date.now
            cred.service = "Netflix"
            cred.username = "Abe"
            
            return cred
        }
        
        return NavigationStack {
            SaveCredentialView(credential: credential)
        }
        
    }
}
