//
//  XCallbackURL+URL.swift
//  XCallbackURL
//
//  Copyright © 2019 Jason Nam (https://jasonnam.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public extension XCallbackURL {

    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = XCallbackURL.host
        urlComponents.path = "/\(action)"
        var queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        if let successCallbackURL = successCallbackURL {
            queryItems.append(.init(name: Parameter.success, value: successCallbackURL.absoluteString))
        }
        if let errorCallbackURL = errorCallbackURL {
            queryItems.append(.init(name: Parameter.error, value: errorCallbackURL.absoluteString))
        }
        if let cancelCallbackURL = cancelCallbackURL {
            queryItems.append(.init(name: Parameter.cancel, value: cancelCallbackURL.absoluteString))
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
