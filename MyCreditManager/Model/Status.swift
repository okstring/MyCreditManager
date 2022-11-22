//
//  Status.swift
//  MyCreditManager
//
//  Created by Ok Hyeon Kim on 2022/11/22.
//

import Foundation

enum Status {
    case main
    case inputName
    case removeName
    case inputCredit
    case removeCredit
    case showCredit
    case exit
}

extension Status: CustomStringConvertible {
    var description: String {
        switch self {
            case .main:
                return "원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기: X: 종료"
            case .inputName:
                return "추가할 학생의 이름을 입력해주세요"
            case .removeName:
                return "삭제할 학생의 이름을 입력해주세요"
            case .inputCredit:
                return "성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift A+\n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다."
            case .removeCredit:
                return "성적을 삭제할 학생의 이름, 과목, 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift"
            case .showCredit:
                return "평점을 알고싶은 학생의 이름을 입력해주세요"
            case .exit:
                return "프로그램을 종료합니다..."
        }
    }
}

enum SuccessStatus {
    case register(name: String)
    case unregister(name: String)
    case addCredit(name: String, subject: String, credit: Credit)
    case removeCredit(name: String, subject: String)
    case showCredit(creditBySubject: CreditCart)
}

extension SuccessStatus: CustomStringConvertible {
    var description: String {
        switch self {
            case .register(let name):
                return "\(name) 학생을 추가했습니다."
            case .unregister(let name):
                return "\(name) 학생을 삭제하였습니다."
            case .addCredit(let name, let subject, let credit):
                return "\(name) 학생의 \(subject) 과목이 \(credit.description)로 추가(변경)되었습니다."
            case .removeCredit(let name, let subject):
                return "\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다."
            case .showCredit(let creditCart):
                return creditCart.description
        }
    }
}

enum ErrorStatus: Error {
    case invalidInput
    case invalidRegister
    case registeredStudent(name: String)
    case invalidUnregister
    case unregistered(name: String)
    case invalidAddCredit
    case invalidRemoveCredit
    case invalidShowCredit
}

extension ErrorStatus: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .invalidInput:
                return "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
            case .invalidRegister:
                return "입력이 잘못되었습니다. 다시 확인해주세요."
            case .registeredStudent(let student):
                return "\(student) 학생은 이미 존재하는 학생입니다. 추가하지 않습니다."
            case .invalidUnregister:
                return "입력이 잘못되었습니다. 다시 확인해주세요."
            case .unregistered(let student):
                return "\(student) 학생을 찾지 못했습니다."
            case .invalidAddCredit:
                return "입력이 잘못되었습니다. 다시 확인해주세요."
            case .invalidRemoveCredit:
                return "입력이 잘못되었습니다. 다시 확인해주세요."
            case .invalidShowCredit:
                return "입력이 잘못되었습니다. 다시 확인해주세요."
        }
    }
}
