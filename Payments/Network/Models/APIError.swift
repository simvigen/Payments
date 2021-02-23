//
//  APIError.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/22/21.
//

import Foundation

struct APIError: Codable {
    var errorCode: Int
    var errorMsg: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMsg = "error_msg"
    }
}

extension APIError: CustomStringConvertible {
    var description: String {
        return "Error code: \(errorCode)\n message: \(errorMsg)"
    }
}
