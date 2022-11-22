//
//  String+isAlphanumeric.swift
//  MyCreditManager
//
//  Created by Ok Hyeon Kim on 2022/11/22.
//

import Foundation

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9\\+]", options: .regularExpression) == nil
    }
}
