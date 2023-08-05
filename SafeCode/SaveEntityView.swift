//
//  SaveEntityView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 05/08/23.
//

import SwiftUI

struct SaveEntityView: View {
    let password: String
    let onSave: () -> ()
    @EnvironmentObject var userData: Data
    
    @Environment(\.dismiss) var dismiss
    @State private var label = ""
    @State private var showAlert = false
    @State private var additionalInfo = ""
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", text: $label)
                } header: {
                    Text("Label")
                }
                
                Section {
                    TextEditor(text: $additionalInfo)
                } header: {
                    Text("Additional Info (Optional)")
                }
                
                Section {
                    Text("\(password)")
                } header: {
                    Text("Your Password")
                }
                
                Button {
                    let entity = Entity(
                        label: label, password: password, additionalInfo: additionalInfo
                    )
                    
                    userData.entities.append(entity)
                    showAlert = true
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(label.count == 0)
            }
            .alert("Password Saved Successfully", isPresented: $showAlert) {
                Button("OK") {
                    onSave()
                }
            }
            .navigationTitle("Save your password")
            .navigationBarTitleDisplayMode(.inline)
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
