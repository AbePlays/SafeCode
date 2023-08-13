//
//  EntityView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 06/08/23.
//

import CoreData
import SwiftUI

struct CredentialView: View {
    var credential: Credential
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var credentials: FetchedResults<Credential>
    
    @State private var showAlert = false
    @State private var copied = false
    @State private var showSheet = false
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Text("Your")
                    .foregroundColor(.gray)
                
                Text("Credential")
            }
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 10) {
                DetailCardView(text: credential.service ?? "", title: "Service")
                
                DetailCardView(text: credential.username ?? "", title: "User Name")
                
                DetailCardView(text: credential.password ?? "", title: "Password")
                
                DetailCardView(text: credential.createdAt?.formatted() ?? "", title: "Created On")
                
                if credential.updatedAt != nil {
                    DetailCardView(text: credential.updatedAt?.formatted() ?? "", title: "Last Updated On")
                }
                
                Spacer()
                
                Button {
                    showAlert = true
                } label: {
                    Text("Delete")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red)
                        .cornerRadius(8)
                }
            }
        }
        .alert("Are you sure?", isPresented: $showAlert) {
            Button("Delete", role: .destructive) {
                moc.delete(credential)
                try? moc.save()
                dismiss()
            }
        } message: {
            Text("Credential once deleted cannot be recovered!")
        }
        .navigationBarBackButtonHidden()
        .padding()
        .sheet(isPresented: $showSheet) {
            SaveCredentialView(credential: credential)
        }
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .accessibilityLabel(Text("Go Back"))
                        .foregroundColor(.black)
                }
            }
            
            ToolbarItem (placement: .navigationBarTrailing) {
                Button {
                    showSheet = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .accessibilityLabel(Text("Edit"))
                        .foregroundColor(.black)
                }
            }
        }
    }
}

//struct EntityView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            CredentialView()
//        }
//    }
//}
