//
//  Entity.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 05/08/23.
//

import Foundation

class Entity: Identifiable {
    var id = UUID()
    var createdAt = Date.now
    var label: String
    var password: String
    var additionalInfo: String
    
    init(label: String, password: String, additionalInfo: String = "") {
        self.label = label
        self.password = password
        self.additionalInfo = additionalInfo
    }
}

class Data: ObservableObject {
    @Published var entities = [Entity]()
}
