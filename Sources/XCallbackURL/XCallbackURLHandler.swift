//
//  XCallbackURLHandler.swift
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

open class XCallbackURLHandler {

    open weak var delegate: XCallbackURLHandlerDelegate?

    public let scheme: String

    public init(scheme: String) {
        self.scheme = scheme
    }

    open func handle(_ xCallbackURL: XCallbackURL) {
        var successCallback: SuccessCallback?
        var errorCallback: ErrorCallback?
        var cancelCallback: CancelCallback?

        if let successCallbackURL = xCallbackURL.successCallbackURL {
            successCallback = { [weak self] parameters in
                guard var urlComponents = URLComponents(url: successCallbackURL, resolvingAgainstBaseURL: false) else { return }
                var queryItems = urlComponents.queryItems ?? []
                queryItems.append(contentsOf: (parameters ?? [:]).map { .init(name: $0, value: $1) })
                urlComponents.queryItems = queryItems
                guard let url = urlComponents.url else { return }
                self?.open(url)
            }
        }
        if let errorCallbackURL = xCallbackURL.errorCallbackURL {
            errorCallback = { [weak self] error in
                guard var urlComponents = URLComponents(url: errorCallbackURL, resolvingAgainstBaseURL: false) else { return }
                var queryItems = urlComponents.queryItems ?? []
                queryItems.append(.init(name: XCallbackURL.Parameter.errorCode, value: .init(error.code)))
                queryItems.append(.init(name: XCallbackURL.Parameter.errorMessage, value: error.message))
                urlComponents.queryItems = queryItems
                guard let url = urlComponents.url else { return }
                self?.open(url)
            }
        }
        if let cancelCallbackURL = xCallbackURL.cancelCallbackURL {
            cancelCallback = { [weak self] in
                self?.open(cancelCallbackURL)
            }
        }

        delegate?.handleXCallbackURL(
            action: xCallbackURL.action,
            parameters: xCallbackURL.parameters,
            successCallback: successCallback,
            errorCallback: errorCallback,
            cancelCallback: cancelCallback
        )
    }

    open func xCallbackURL(fromURL url: URL) -> Result<XCallbackURL, XCallbackURLHandlerError> {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return .failure(.invalidURL(url))
        }
        guard urlComponents.scheme == scheme && urlComponents.host == XCallbackURL.host else {
            return .failure(.notXCallbackURL(url))
        }

        var parameters: Parameters = [:]
        var successCallbackURL: URL?
        var errorCallbackURL: URL?
        var cancelCallbackURL: URL?

        for queryItem in urlComponents.queryItems ?? [] {
            let name = queryItem.name
            let value = queryItem.value ?? ""
            let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            switch name {
            case XCallbackURL.Parameter.success:
                if let url = URL(string: encodedValue) {
                    successCallbackURL = url
                } else {
                    return .failure(.invalidSuccessCallbackURL(value))
                }
            case XCallbackURL.Parameter.error:
                if let url = URL(string: encodedValue) {
                    errorCallbackURL = url
                } else {
                    return .failure(.invalidErrorCallbackURL(value))
                }
            case XCallbackURL.Parameter.cancel:
                if let url = URL(string: encodedValue) {
                    cancelCallbackURL = url
                } else {
                    return .failure(.invalidCancelCallbackURL(value))
                }
            default:
                parameters[name] = value
            }
        }

        return .success(
            .init(
                scheme: scheme,
                action: url.lastPathComponent,
                parameters: parameters,
                successCallbackURL: successCallbackURL,
                errorCallbackURL: errorCallbackURL,
                cancelCallbackURL: cancelCallbackURL
            )
        )
    }

    open func open(_ url: URL) {
        delegate?.openCallbackURL(url)
    }
}
