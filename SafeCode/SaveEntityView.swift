//
//  SaveEntityView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 05/08/23.
//

import SwiftUI

struct SaveEntityView: View {
    let password: String
    @EnvironmentObject var userData: Data
    
    @Environment(\.dismiss) var dismiss
    @State private var label = ""
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
                    TextField("", text: $additionalInfo)
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
                    print(userData.entities.count)
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(label.count == 0)
            }
            .navigationTitle("Save your password")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SaveEntityView_Previews: PreviewProvider {
    static var previews: some View {
        SaveEntityView(password: "123456")
    }
}
