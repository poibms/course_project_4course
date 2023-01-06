//
//  ValidateError.swift
//  CoreData-Blog
//

//

import Foundation

enum ValidateError: Error
{
    case isTitleEmpty
    case titleTooShort
    case isContentEmpty
    case contentTooShort
}
