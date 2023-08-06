//
//  EntityView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 06/08/23.
//

import SwiftUI

struct EntityView: View {
    let entity: Entity
    
    @State private var copied = false
    
    var body: some View {
        List {
            HStack {
                Text("Label: ")
                    .bold()
                Text(entity.label)
            }
            
            HStack {
                Text("Password: ")
                    .bold()
                
                HStack {
                    Text(entity.password)
                    Button {
                        // Copy to clipboard
                        UIPasteboard.general.string = entity.password
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
                            .accessibilityLabel(Text(copied ? "Copied" : "Copy"))
                    }
                }
            }
            
            HStack {
                Text("Additional Info: ")
                    .bold()
                
                Text(entity.additionalInfo.count > 0 ? entity.additionalInfo : "-")
            }
            
            HStack {
                Text("Created On: ")
                    .bold()
                
                Text(entity.createdAt.formatted())
            }
        }
        .toolbar {
            ToolbarItem (placement: .navigationBarTrailing) {
                Button {
                    
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
            EntityView(entity: Entity(label: "Netflix", password: "123456", additionalInfo: "Some Info"))
        }
    }
}
