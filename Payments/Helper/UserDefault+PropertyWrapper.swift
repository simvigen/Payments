//
//  UserDefault+PropertyWrapper.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/23/21.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let container: UserDefaults = .standard

    var wrappedValue: Value? {
        get {
            return container.object(forKey: key) as? Value
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}
