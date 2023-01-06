//
//  ValidateError+Ex.swift
//  CoreData-Blog
//

//

import Foundation

extension ValidateError: LocalizedError
{
    var errorDescription: String? {
        switch self {
        case .isTitleEmpty:
            return "Title empty."
        case .titleTooShort:
            return "`title too short`."
        case .isContentEmpty:
            return "Description empty."
        case .contentTooShort:
            return "Description too short."
        }
    }
}
