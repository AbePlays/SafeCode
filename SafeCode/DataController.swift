//
//  DataController.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 06/08/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Credential")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load \(error.localizedDescription)")
            }
        }
    }
}
