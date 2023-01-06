//
//  UserModel.swift
//  CoreData-Blog
//

//

final class UserModel {
    let login: String?
    let password: String?

    // MARK: - Init
    init(login: String? = nil, password: String? = nil) {
        self.login = login
        self.password = password
    }

    init(from user: User) {
        self.login = user.login
        self.password = user.password
    }
}

