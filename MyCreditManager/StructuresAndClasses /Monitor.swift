//
//  Monitor.swift
//  MyCreditManager
//
//  Created by Ok Hyeon Kim on 2022/11/22.
//

import Foundation

struct Monitor {
    func showDescription(_ status: Status) {
        print(status.description)
    }

    func showErrorDescription(_ status: ErrorStatus) {
        print(status.errorDescription ?? "")
    }

    func showErrorDescription(_ status: Error) {
        print(status.localizedDescription)
    }

    func showSuccessDescription(_ status: SuccessStatus) {
        print(status.description)
    }
}
