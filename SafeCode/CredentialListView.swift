//
//  CredentialListView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 12/08/23.
//

import SwiftUI

struct CredentialListView: View {
    @FetchRequest(sortDescriptors: []) var creds: FetchedResults<Credential>
    
    var credentials: [Credential]
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(credentials) { credential in
                NavigationLink {
                    CredentialView(credential: credential)
                } label: {
                    VStack {
                        HStack {
                            VStack(spacing: 5) {
                                Text(credential.service ?? "")
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(credential.username ?? "")
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            Image(systemName: "chevron.right")
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
        }
    }
}

struct CredentialListView_Previews: PreviewProvider {
    static var previews: some View {
        CredentialListView(credentials: [])
    }
}
