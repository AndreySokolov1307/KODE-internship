import Foundation

public extension URL {

    enum CustomURLError: Error, LocalizedError {
        case failedToExtractComponents(url: URL)
        case failedToCreateUrlFromComponents(components: URLComponents)
    }

    func with(queryItems: [URLQueryItem]) throws -> URL {
        guard !queryItems.isEmpty else { return self }
        if #available(iOS 16.0, *) {
            return appending(queryItems: queryItems)
        } else {
            guard var components = URLComponents(string: absoluteString) else {
                throw CustomURLError.failedToExtractComponents(url: self)
            }

            let queryItems = (components.queryItems ?? []) + queryItems

            components.queryItems = queryItems
            guard let newUrl = components.url else {
                throw CustomURLError.failedToCreateUrlFromComponents(components: components)
            }
            return newUrl
        }
    }
}

public extension URL.CustomURLError {
    var errorDescription: String? {
        switch self {
        case .failedToExtractComponents(let url):
            return "Failed to extract URL components from `\(url.absoluteString)`"
        case .failedToCreateUrlFromComponents(let components):
            return "Failed to create URL from components `\(components.string ?? "–")`"
        }
    }
}
