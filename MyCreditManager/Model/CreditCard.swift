//
//  CreditCard.swift
//  MyCreditManager
//
//  Created by Ok Hyeon Kim on 2022/11/22.
//

import Foundation

class CreditCart {
    var creditBySubject: [String: Credit]

    subscript(subject: String) -> Credit? {
        return self.creditBySubject[subject]
    }

    init(creditBySubject: [String : Credit] = [String: Credit]()) {
        self.creditBySubject = creditBySubject
    }

    func setCard(subject: String, credit: Credit?) {
        self.creditBySubject[subject] = credit
    }
}

extension CreditCart: CustomStringConvertible {
    var description: String {
        var sumScore: Float = 0.0

        let str = creditBySubject
            .map({
                sumScore += $0.value.score
                return "\($0.key): \($0.value.description)"
            })
            .joined(separator: "\n")
            .appending("\n평점 : \(String(format: "%.2f", sumScore / Float(creditBySubject.count)))")

        return str
    }
}
