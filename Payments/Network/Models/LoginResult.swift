//
//  LoginResult.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/22/21.
//

import Foundation

struct LoginResult: Codable {
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
}

extension LoginResult: CustomStringConvertible {
    var description: String {
        return "token: \(token)"
    }
}
