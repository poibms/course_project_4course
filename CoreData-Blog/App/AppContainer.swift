//
//  AppContainer.swift
//  CoreData-Blog
//

//

import Foundation

let app = AppContainer()

final class AppContainer
{    
    let router  = AppRouter()
    let stack = CoreDataStack(modelName: K.Model.modelName)
} 
