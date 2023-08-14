//
//  DetailCardView.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 13/08/23.
//

import SwiftUI

struct DetailCardView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var text: String
    var title: String
    
    @State private var copied = false
    
    func copyToClipboard() {
        UIPasteboard.general.string = text
        copied = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                copied = false
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(spacing: 5) {
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(text)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                
                Spacer()
                
                Button {
                    copyToClipboard()
                } label: {
                    Image(systemName: copied ? "checkmark" : "doc.on.doc")
                        .accessibilityLabel("Copy")
                        .foregroundColor(.primary)
                }
            }
            .padding()
        }
        .background(.gray.opacity(colorScheme == .dark ? 0.25 : 0.15))
        .cornerRadius(8)
    }
}

struct DetailCardView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCardView(text: "Netflix", title: "Service")
            .padding()
    }
}
