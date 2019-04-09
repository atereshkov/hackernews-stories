//
//  JSONDecoderProtocol.swift
//  hackernews-stories
//
//  Created by Alexander Tereshkov on 4/9/19.
//  Copyright © 2019 Alexander Tereshkov. All rights reserved.
//

import Foundation

protocol JSONDecoderProtocol {
    func decodeJSON<T: Decodable>(type: T.Type, from data: Data) -> T?
}
