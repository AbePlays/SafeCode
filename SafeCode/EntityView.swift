//
//  EntityView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 06/08/23.
//

import SwiftUI

struct EntityView: View {
    let password: Credential
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var passwords: FetchedResults<Credential>
    
    @State private var showAlert = false
    @State private var copied = false
    @State private var showSheet = false
    
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
            
            Section {
                Button {
                    showAlert = true
                } label: {
                    Text("Delete")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.red)
                        .foregroundColor(.white)
                }
            }
        }
        .alert("Are you sure?", isPresented: $showAlert) {
            Button("Delete", role: .destructive) {
                moc.delete(password)
                try? moc.save()
                dismiss()
            }
        } message: {
            Text("Password once deleted cannot be recovered?")
        }
        .sheet(isPresented: $showSheet) {
            SaveEntityView(credential: password)
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

//struct EntityView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            EntityView(id: UUID())
//        }
//    }
//}
