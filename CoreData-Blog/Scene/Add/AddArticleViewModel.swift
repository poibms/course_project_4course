//
//  AddArticleViewModel.swift
//  CoreData-Blog
//

//

import UIKit

// MARK: - Initialize
final class AddArticleViewModel
{
    weak var delegate: AddArticleViewModelDelegate?
    private let service: IHomeService

    init(service: IHomeService)
    {
        self.service = service
    }
}

// MARK: - Protocol
extension AddArticleViewModel: AddArticleViewModelProtocol
{
    func addArticle(with title: String,
                    content: String,
                    image: UIImage,
                    category: String)
    {
        do {
            try validateArticle(title: title, content: content)
            try service.addArticle(with: title, content, image, category)
            notify(.isAdded(.success(true)))
        } catch {
            notify(.isAdded(.failure(error)))
        }
    }
}

// MARK: - Handle Output Helper
extension AddArticleViewModel
{
    private func notify(_ output: AddArticleViewModelOutput)
    {
        delegate?.handleOutput(output)
    }
}

// MARK: - Validation
extension AddArticleViewModel
{
    private func validateArticle(title: String,
                                 content: String) throws
    {
        guard !title.isEmpty else { throw ValidateError.isTitleEmpty }
        guard title.count >= 3 else { throw ValidateError.titleTooShort }
        guard !content.isEmpty else { throw ValidateError.isContentEmpty }
        guard content.count >= 3 else { throw ValidateError.contentTooShort }
    }
}
