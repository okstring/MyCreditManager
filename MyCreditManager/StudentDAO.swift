//
//  StudentDAO.swift
//  MyCreditManager
//
//  Created by Ok Hyeon Kim on 2022/11/22.
//

import Foundation

class StudentDAO {
    typealias StudentDB = Set<Student>

    private var studentList: StudentDB

    init(studentList: StudentDB = StudentDB()) {
        self.studentList = studentList
    }

    @discardableResult
    func addStudent(name: String) throws -> Bool {
        guard isRegisterableStudent(name) else {
            throw ErrorStatus.registeredStudent(name: name)
        }

        let newStudent = Student(name: name)

        self.studentList.update(with: newStudent)

        return true
    }

    @discardableResult
    func removeStudent(name: String) throws -> Bool {
        guard isRegisteredStudent(name) else {
            throw ErrorStatus.unregistered(name: name)
        }

        let student = Student(name: name)

        self.studentList.remove(student)

        return true
    }

    @discardableResult
    func updateCredit(name: String, subject: String, credit: Credit) throws -> Bool {
        guard var selectStudent = studentList.first(where: { $0.name == name }) else {
            throw ErrorStatus.unregistered(name: name)
        }

        selectStudent.updateCreditBySubject(subject: subject, credit: credit)
        studentList.update(with: selectStudent)

        return true
    }

    @discardableResult
    func removeCredit(name: String, subject: String) throws -> Bool {
        guard var selectStudent = studentList.first(where: { $0.name == name }) else {
            throw ErrorStatus.unregistered(name: name)
        }

        selectStudent.updateCreditBySubject(subject: subject, credit: nil)
        studentList.update(with: selectStudent)

        return true
    }

    func fetchAllCredit(name: String) throws -> CreditCart {
        guard let selectStudent = studentList.first(where: { $0.name == name }) else {
            throw ErrorStatus.unregistered(name: name)
        }

        return selectStudent.creditCard
    }

    private func isRegisterableStudent(_ name: String) -> Bool {
        return !studentList.contains(where: { $0.name == name })
    }

    func isRegisteredStudent(_ name: String) -> Bool {
        return studentList.contains(where: { $0.name == name })
    }
}
