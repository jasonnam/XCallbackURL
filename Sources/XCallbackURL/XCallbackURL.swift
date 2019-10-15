//
//  XCallbackURL.swift
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

public struct XCallbackURL {

    public static let host = "x-callback-url"

    public struct Parameter {

        public static let success = "x-success"
        public static let error = "x-error"
        public static let cancel = "x-cancel"
        public static let errorCode = "errorCode"
        public static let errorMessage = "errorMessage"
    }

    public let scheme: String
    public let action: String
    public let parameters: Parameters
    public let successCallbackURL: URL?
    public let errorCallbackURL: URL?
    public let cancelCallbackURL: URL?

    public init(scheme: String,
                action: String,
                parameters: Parameters = [:],
                successCallbackURL: URL? = nil,
                errorCallbackURL: URL? = nil,
                cancelCallbackURL: URL? = nil) {
        self.scheme = scheme
        self.action = action
        self.parameters = parameters
        self.successCallbackURL = successCallbackURL
        self.errorCallbackURL = errorCallbackURL
        self.cancelCallbackURL = cancelCallbackURL
    }
}
