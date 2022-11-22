//
//  CreditManager.swift
//  MyCreditManager
//
//  Created by Ok Hyeon Kim on 2022/11/22.
//

import Foundation

struct CreditManager {
    let computer: StudentDAO
    let monitor: Monitor

    init(computer: StudentDAO = StudentDAO(),
         moditor: Monitor = Monitor()) {
        self.computer = computer
        self.monitor = moditor
    }

    func start() {
        while true {
            monitor.showDescription(.main)

            guard let input = ask(),
                  let status = InputType(rawValue: input) else {
                monitor.showErrorDescription(.invalidInput)
                continue
            }

            switch status {
                case .register:
                    monitor.showDescription(.inputName)

                    guard let studentName = ask() else {
                        monitor.showErrorDescription(.invalidRegister)
                        continue
                    }

                    register(name: studentName)

                case .unregister:
                    monitor.showDescription(.removeName)

                    guard let studentName = ask() else {
                        monitor.showErrorDescription(.invalidUnregister)
                        continue
                    }

                    unregister(name: studentName)

                case .addCredit:
                    monitor.showDescription(.inputCredit)

                    guard let (studentName, subject, credit) = askAddCredit() else {
                        monitor.showErrorDescription(.invalidAddCredit)
                        continue
                    }

                    updateCredit(name: studentName, subject: subject, credit: credit)

                case .removeCredit:
                    monitor.showDescription(.removeCredit)

                    guard let (studentName, subject) = askRemoveCredit() else {
                        monitor.showErrorDescription(.invalidRemoveCredit)
                        continue
                    }

                    removeCredit(name: studentName, subject: subject)

                case .showCredit:
                    monitor.showDescription(.showCredit)

                    guard let studentName = ask() else {
                        monitor.showErrorDescription(.invalidShowCredit)
                        continue
                    }

                    showCredit(name: studentName)

                case .exit:
                    monitor.showDescription(.exit)
                    return
            }
        }
    }

    private func register(name: String) {
        do {
            try computer.addStudent(name: name)
            monitor.showSuccessDescription(.register(name: name))
        } catch let error {
            monitor.showErrorDescription(error)
        }
    }

    private func unregister(name: String) {
        do {
            try computer.removeStudent(name: name)
            monitor.showSuccessDescription(.unregister(name: name))
        } catch let error {
            monitor.showErrorDescription(error)
        }
    }

    private func updateCredit(name: String, subject: String, credit: Credit) {
        do {
            try computer.updateCredit(name: name, subject: subject, credit: credit)
            monitor.showSuccessDescription(.addCredit(name: name, subject: subject, credit: credit))
        } catch let error {
            monitor.showErrorDescription(error)
        }
    }

    private func removeCredit(name: String, subject: String) {
        do {
            try computer.removeCredit(name: name, subject: subject)
            monitor.showSuccessDescription(.removeCredit(name: name, subject: subject))
        } catch let error {
            monitor.showErrorDescription(error)
        }
    }

    private func showCredit(name: String) {
        do {
            let creditCard = try computer.fetchAllCredit(name: name)
            monitor.showSuccessDescription(.showCredit(creditBySubject: creditCard))
        } catch let error {
            monitor.showErrorDescription(error)
        }
    }

    private func ask() -> String? {
        guard let input = readLine(),
              input.split(separator: " ").joined().isAlphanumeric else {
            return nil
        }

        return input
    }

    private func askAddCredit() -> (name: String, subject: String, credit: Credit)? {
        guard let input = readLine() else {
            return nil
        }

        let inputArray = input.split(separator: " ").map({ String($0) })

        guard inputArray.count == 3, inputArray.joined().isAlphanumeric else {
            return nil
        }

        let name = inputArray[0]
        let subject = inputArray[1]
        guard let credit = Credit(rawValue: String(inputArray.last ?? "")) else {
            return nil
        }

        return (name, subject, credit)
    }

    private func askRemoveCredit() -> (name: String, subject: String)? {
        guard let input = readLine() else {
            return nil
        }

        let inputArray = input.split(separator: " ").map({ String($0) })

        guard inputArray.count == 2, inputArray.joined().isAlphanumeric else {
            return nil
        }

        let name = inputArray[0]
        let subject = inputArray[1]

        return (name, subject)
    }
}
