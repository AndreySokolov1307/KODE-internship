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
        case info([Item])
        
        var items: [Item] {
            switch self {
            case .profile(let item):
              return [item]
            case .info(let items):
                return items
            }
        }
    }
    
    enum Item: Hashable {
        case profileShimmer(_ identifier: String = UUID().uuidString)
        case infoShimmer(_ identifier: String = UUID().uuidString)
        // TODO: - views for cells
        case profile//(//TODO: -)
        case about
        case theme
        case support
        case logOut
    }
    
    let sections: [Section]
}
