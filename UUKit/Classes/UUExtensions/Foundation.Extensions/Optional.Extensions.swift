//
//  File.swift
//  Pods-UUKit_Example
//
//  Created by uxiu.me on 2018/12/7.
//

import Foundation

extension Optional where Wrapped == String {
    /// 配合String的isBlank共同使用，判断字符串是否为空
    var isBlank: Bool {
        return self?.isBlank ?? true
    }
}

extension Optional where Wrapped: Collection {
    
    public var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
    
}

extension Optional {
    /// 值为空返回true
    public var isNone: Bool {
        return self == nil
    }
    
    /// 值非空返回true
    public var isSome: Bool {
        return self != nil
    }
    
    /// Executes the closure `some` if and only if the optional has a value
    public func on(some: () throws -> Void) rethrows {
        if self != nil { try some() }
    }
    
    /// Executes the closure `none` if and only if the optional has no value
    public func on(none: () throws -> Void) rethrows {
        if self == nil { try none() }
    }
    
//    /// Logout if there is no user anymore
//    self.user.on(none: { AppCoordinator.shared.logout() })
//    
//    /// self.user is not empty when we are connected to the network
//    self.user.on(some: { AppCoordinator.shared.unlock() })
}

extension Optional {
    /// Return the value of the Optional or the `default` parameter
    /// - param: The value to return if the optional is empty
    public func or(_ default: Wrapped) -> Wrapped {
        return self ?? `default`
    }
    
    /// Returns the unwrapped value of the optional *or*
    /// the result of an expression `else`
    /// I.e. optional.or(else: print("Arrr"))
    public func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    /// Returns the unwrapped value of the optional *or*
    /// the result of calling the closure `else`
    /// I.e. optional.or(else: { 
    /// ... do a lot of stuff
    /// })
    public func or(else: () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    /// Returns the unwrapped contents of the optional if it is not empty
    /// If it is empty, throws exception `throw`
    public func or(throw exception: Error) throws -> Wrapped {
        guard let unwrapped = self else { throw exception }
        return unwrapped
    }
}

extension Optional where Wrapped == Error {
    /// Only perform `else` if the optional has a non-empty error value
    public func or(_ else: (Error) -> Void) {
        guard let error = self else { return }
        `else`(error)
    }
}

extension Optional {
/// before
//        do {
//            try throwingFunction()
//        } catch let error {
//            print(error)
//        }
    public func should(_ do: () throws -> Void) -> Error? {
        do {
            try `do`()
            return nil
        } catch let error {
            return error
        }
    }
/// after
//    should { try throwingFunction) }.or(print($0))
    
}

extension Optional {
    /// Maps the output *or* returns the default value if the optional is nil
    /// - parameter fn: The function to map over the value
    /// - parameter or: The value to use if the optional is empty
    public func map<T>(_ fn: (Wrapped) throws -> T, default: T) rethrows -> T {
        return try map(fn) ?? `default`
    }
    
    /// Maps the output *or* returns the result of calling `else`
    /// - parameter fn: The function to map over the value
    /// - parameter else: The function to call if the optional is empty
    public func map<T>(_ fn: (Wrapped) throws -> T, else: () throws -> T) rethrows -> T {
        return try map(fn) ?? `else`()
    }
    
//    let optional1: String? = "appventure"
//    let optional2: String? = nil
//    
//    // Without
//    print(optional1.map({ $0.count }) ?? 0)
//    print(optional2.map({ $0.count }) ?? 0)
//    
//    // With 
//    print(optional1.map({ $0.count }, default: 0)) // prints 10
//    print(optional2.map({ $0.count }, default: 0)) // prints 0
    
//    let optional: String? = nil
//    print(optional.map({ $0.count }, else: { "default".count })
}

extension Optional {
    /// Tries to unwrap `self` and if that succeeds continues to unwrap the parameter `optional`
    /// and returns the result of that.
    public func and<B>(_ optional: B?) -> B? {
        guard self != nil else { return nil }
        return optional
    }

    /// Executes a closure with the unwrapped result of an optional.
    /// This allows chaining optionals together.
    public func and<T>(then: (Wrapped) throws -> T?) rethrows -> T? {
        guard let unwrapped = self else { return nil }
        return try then(unwrapped)
    }
    
    /// Zips the content of this optional with the content of another
    /// optional `other` only if both optionals are not empty
    public func zip2<A>(with other: Optional<A>) -> (Wrapped, A)? {
        guard let first = self, let second = other else { return nil }
        return (first, second)
    }

    /// Zips the content of this optional with the content of another
    /// optional `other` only if both optionals are not empty
    public func zip3<A, B>(with other: Optional<A>, another: Optional<B>) -> (Wrapped, A, B)? {
        guard let first = self,
            let second = other,
            let third = another else { return nil }
        return (first, second, third)
    }
    
//    // Compare
//    if user != nil, let account = userAccount() ...
//    
//    // With
//    if let account = user.and(userAccount()) ...

    
    
//    protocol UserDatabase {
//        func current() -> User?
//        func spouse(of user: User) -> User?
//        func father(of user: User) -> User?
//        func childrenCount(of user: User) -> Int
//    }
//    
//    let database: UserDatabase = ...
//    
//    // Imagine we want to know the children of the following relationship:
//    // Man -> Spouse -> Father -> Father -> Spouse -> children
//    
//    // Without
//    let childrenCount: Int
//    if let user = database.current(), 
//    let father1 = database.father(user),
//    let father2 = database.father(father1),
//    let spouse = database.spouse(father2),
//    let children = database.childrenCount(father2) {
//        childrenCount = children
//    } else {
//    childrenCount = 0
//    }
//    
//    // With
//    let children = database.current().and(then: { database.spouse($0) })
//        .and(then: { database.father($0) })
//        .and(then: { database.spouse($0) })
//        .and(then: { database.childrenCount($0) })
//        .or(0)
    
}


extension Optional {
    /// Returns the unwrapped value of the optional only if
    /// - The optional has a value
    /// - The value satisfies the predicate `predicate`
    public func filter(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let unwrapped = self, predicate(unwrapped) else { return nil }
        return self
    }
    ///   Normal Swift
    //    if let aUser = user, user.id < 1000 { aUser.upgradeToPremium() }
    //    
    ///   Using `filter`
    //    user.filter({ $0.id < 1000 })?.upgradeToPremium()

    /// Returns the wrapped value or crashes with `fatalError(message)`
    public func expect(_ message: String) -> Wrapped {
        guard let value = self else { fatalError(message) }
        return value
    }
    ///   Normal Swift    
    //    func updateLabel() {
    //        guard let label = valueLabel else {
    //            fatalError("valueLabel not connected in IB")
    //        }
    //        label.text = state.title
    //    }
    //    
    ///   Using `expect`
    //    func updateLabel() {
    //        valueLabel.expect("valueLabel not connected in IB").text = state.title
    //    }
    
    
    
}

//下面是例子🌰，解注释可以查看
//protocol XMLImportNode {
//    func firstChild(with tag: String) -> XMLImportNode?
//    func children(with tag: String) -> [XMLImportNode]
//    func attribute(with name: String) -> String?
//}
//
//typealias DatabaseUser = String
//typealias DatabaseSoftware = String
//protocol Database {
//    func user(for id: String) throws -> DatabaseUser
//    func software(for id: String) throws -> DatabaseSoftware
//    func insertSoftware(user: DatabaseUser, name: String, id: String, type: String, amount: Int) throws
//    func updateSoftware(software: DatabaseSoftware, amount: Int) throws
//}
//
//extension Optional {
//    
//    enum ParseError: Error {
//        case msg(String)
//    }
//    
//    func parseGamesFromXMLNormal(from root: XMLImportNode, into database: Database) throws {
//        guard let users = root.firstChild(with: "users")?.children(with: "user") else {
//            throw ParseError.msg("No Users")
//        }
//        for user in users {
//            guard let software = user.firstChild(with: "software")?.children(with: "package"),
//                let userId = user.attribute(with: "id"),
//                let dbUser = try? database.user(for: userId)
//                else { throw ParseError.msg("Invalid User") }
//            for package in software {
//                guard let type = package.attribute(with: "type"),
//                    type == "game",
//                    let name = package.attribute(with: "name"),
//                    let softwareId = package.attribute(with: "id"),
//                    let amountString = package.attribute(with: "amount")
//                    else { throw ParseError.msg("Invalid Package") }
//                if let existing = try? database.software(for: softwareId) {
//                    try database.updateSoftware(software: existing, 
//                                                amount: Int(amountString) ?? 0)
//                } else {
//                    try database.insertSoftware(user: dbUser, name: name, 
//                                                id: softwareId, 
//                                                type: type, 
//                                                amount: Int(amountString) ?? 0)
//                }
//            }
//        }
//    }
//    //Lets apply what we learned above:
//    
//    func parseGamesFromXML(from root: XMLImportNode, into database: Database) throws {
//        for user in try root.firstChild(with: "users")
//            .or(throw: ParseError.msg("No Users")).children(with: "user") {
//                let dbUser = try user.attribute(with: "id")
//                    .and(then: { try? database.user(for: $0) })
//                    .or(throw: ParseError.msg("Invalid User"))
//                for package in (user.firstChild(with: "software")?
//                    .children(with: "package")).or([]) {
//                        guard (package.attribute(with: "type")).filter({ $0 == "game" }).isSome
//                            else { continue }
//                        try package.attribute(with: "name")
//                            .zip3(with: package.attribute(with: "id"), 
//                                  another: package.attribute(with: "amount"))
//                            .map({ (tuple) -> Void in
//                                switch try? database.software(for: tuple.1) {
//                                case let e?: try database.updateSoftware(software: e, 
//                                                                         amount: Int(tuple.2).or(0))
//                                default: try database.insertSoftware(user: dbUser, name: tuple.0, 
//                                                                     id: tuple.1, type: "game", 
//                                                                     amount: Int(tuple.2).or(0))
//                                }
//                            }, or: { throw ParseError.msg("Invalid Package") })
//                }
//        }
//    }
//}
////If we look at this, then there're two things that immediately come to mind:
