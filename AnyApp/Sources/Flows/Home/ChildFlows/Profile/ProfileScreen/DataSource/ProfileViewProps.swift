//
//  ProfileViewProps.swift
//  AnyApp
//
//  Created by Андрей Соколов on 13.04.2024.
//
//
import Foundation

struct ProfileViewProps {
    enum Section: Hashable {
        case profile(Item)
        case settings([Item])
        
        var items: [Item] {
            switch self {
            case .profile(let item):
              return [item]
            case .settings(let items):
                return items
            }
        }
    }
    
    enum Item: Hashable {
        case profileShimmer(_ identifier: String = UUID().uuidString)
        case infoShimmer(_ identifier: String = UUID().uuidString)
        case profile(ProfileDetailView.Props)
        case info(InfoView.Props)
    }
    
    let sections: [Section]
}
