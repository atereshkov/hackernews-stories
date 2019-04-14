//
//  URLConstructor.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/14/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

class URLConstructor: URLConstructorProtocol {
    
    private let link: String
    private let baseURL: URL
    
    init(link: String, baseURL: URL) {
        self.link = link
        self.baseURL = baseURL
    }
    
    /// Constructs URL from link and base URL, as there can be different cases when parsed URL doesn't have host or scheme
    func constructURL() -> URL? {
        var resultLink = String(link)
        guard let parsedURL = URL(string: resultLink) else { return nil }
        if parsedURL.host == nil, let baseHost = baseURL.host {
            resultLink = baseHost + "/" + resultLink
        }
        if parsedURL.scheme == nil, let baseScheme = baseURL.scheme {
            resultLink = baseScheme + "://" + resultLink
        }
        return URL(string: resultLink)
    }
    
}
