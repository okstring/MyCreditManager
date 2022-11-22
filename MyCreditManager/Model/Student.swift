//
//  Student.swift
//  MyCreditManager
//
//  Created by Ok Hyeon Kim on 2022/11/22.
//

import Foundation

struct Student {
    let name: String
    private(set) var creditCard: CreditCart

    init(name: String, creditCard: CreditCart = CreditCart()) {
        self.name = name
        self.creditCard = creditCard
    }

    mutating func updateCreditBySubject(subject: String, credit: Credit?) {
        self.creditCard.setCard(subject: subject, credit: credit)
    }
}

extension Student: Hashable, Equatable {
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
