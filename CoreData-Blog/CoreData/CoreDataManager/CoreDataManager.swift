//
//  CoreDataManager.swift
//  CoreData-Blog
//

//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Blog")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("SAVED")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: - Add new user
    func addNewUser(by userModel: UserModel) {
        let user = User(context: persistentContainer.viewContext)
        user.login = userModel.login
        user.password = userModel.password
        persistentContainer.viewContext.insert(user)
        saveContext()
    }

    // MARK: - Get users
    func getUsers() -> [UserModel] {
        var usersModels = [UserModel]()
        do {
            let users = try persistentContainer.viewContext.fetch(User.fetchRequest())
            users.forEach { user in
                usersModels.append(UserModel(from: user))
            }
        } catch (let error) {
            print(error)
        }
        return usersModels
    }
}

