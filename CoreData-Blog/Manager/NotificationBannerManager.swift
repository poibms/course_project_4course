//
//  NotificationBannerManager.swift
//  CoreData-Blog
//

//

import NotificationBannerSwift

final class NotificationBannerManager
{
    static let shared = NotificationBannerManager()
    
    private init() {}
}

extension NotificationBannerManager
{
    func createNotification(with isFavorite: Bool,
                            selectedArticle: Article)
    {
        let notificationStyle = FavoriteStatus.selectStatus(with: isFavorite)
        let notificationBanner: GrowingNotificationBanner
        
        switch notificationStyle {
        case .success:
            notificationBanner = GrowingNotificationBanner(
                title: "You add to favourite",
                subtitle: "With this \(selectedArticle.title!) and can see this in bookmarks!",
                leftView: nil,
                rightView: nil,
                style: .danger,
                colors: nil
            )
        case .info:
            notificationBanner = GrowingNotificationBanner(
                title: "You remove from favourites",
                subtitle: "With this \(selectedArticle.title!) and can't see this in bookmarks!",
                leftView: nil,
                rightView: nil,
                style: .info,
                colors: nil
            )
        }
        notificationBanner.show()
    }
}
