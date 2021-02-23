//
//  Payment.swift
//  Payments
//
//  Created by Vigen Simonyan on 2/22/21.
//

import Foundation

struct Payment: Codable {
    var amount: Double?
    var created: Date?
    var currency: String?
    var desc: String?
}

extension Payment {
    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case created = "created"
        case currency = "currency"
        case desc = "desc"
    }
    
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
    
            if let amount = try? container.decode(Double.self, forKey: .amount) {
                self.amount = amount
            } else if let amount = try? container.decode(String.self, forKey: .amount) {
                self.amount = Double(amount)
            }
            
            if let created = try? container.decode(TimeInterval.self, forKey: .created), created > 0 {
                self.created = Date(timeIntervalSince1970: created)
            } else if let amount = try? container.decode(String.self, forKey: .created),
                      let timeInterval = Double(amount) {
                self.created = Date(timeIntervalSince1970: timeInterval)
            }
            
            if let currency = try? container.decode(String.self, forKey: .currency), !currency.isEmpty {
                self.currency = currency
            }
            
            if let desc = try? container.decode(String.self, forKey: .desc), !desc.isEmpty {
                self.desc = desc
            }
        }
}
