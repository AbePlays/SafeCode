//
//  SaveEntityView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 05/08/23.
//

import SwiftUI

struct SaveEntityView: View {
    var id = UUID()
    var label = ""
    var additionalInfo = ""
    let password: String
    let onSave: () -> ()
    @EnvironmentObject var userData: Data
    
    @Environment(\.dismiss) var dismiss
    @State private var editLabel = ""
    @State private var showAlert = false
    @State private var editAdditionalInfo = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", text: $editLabel)
                } header: {
                    Text("Label")
                }
                
                Section {
                    TextEditor(text: $editAdditionalInfo)
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
                        label: editLabel, password: password, additionalInfo: editAdditionalInfo
                    )
                    
                    let updatedEntities = userData.entities
                    
                    if let index = updatedEntities.firstIndex(where: { entity in
                        entity.id == id
                    }) {
                        updatedEntities[index].label = editLabel
                        updatedEntities[index].additionalInfo = editAdditionalInfo
                        updatedEntities[index].createdAt = Date.now
                        print(updatedEntities)
                        userData.entities = updatedEntities
                    } else {
                        userData.entities.append(entity)
                    }
                    
                    showAlert = true
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(editLabel.count == 0)
            }
            .alert("Entity Saved Successfully", isPresented: $showAlert) {
                Button("OK") {
                    onSave()
                }
            }
            .onAppear(perform: {
                editLabel = label
                editAdditionalInfo = additionalInfo
            })
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
        SaveEntityView(label: "BOOM", password: "123456", onSave: {})
            .environmentObject(Data())
    }
}
