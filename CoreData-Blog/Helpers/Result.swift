//
//  Result.swift
//  CoreData-Blog
//

//

import Foundation

enum Result<Value>
{
    case success(Value)
    case failure(Error)
}
