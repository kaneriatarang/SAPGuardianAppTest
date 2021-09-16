//
//  API.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import Foundation

protocol API {
    var domain: String { get }
    
    func buildRequest(http: HTTP, additionalQuery: [String: String]?) -> URLRequest
}

extension API {
    
    func buildRequest(http: HTTP, additionalQuery: [String: String]? = nil) -> URLRequest {
        
        let urlString: String
        let encodedPath = http.path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        urlString = domain + encodedPath
        
        var urlComps = URLComponents(string: urlString)
        var queryList = http.queryList
        if let dic = additionalQuery {
            queryList?.merge(dic){(current, _) in current }
        }
        
        if let querys = queryList {
            urlComps?.setQueryItems(with: querys)
        }
               
        let url = (urlComps?.url)!
        var urlRequest = URLRequest(url: url)
        
        //Http method and body
        urlRequest.httpMethod = http.method.text
        urlRequest.httpBody = http.method.body
       
        //Handled only json type
        if let type = http.method.bodyType {
            urlRequest.setValue(type.rawValue, forHTTPHeaderField: HttpHeaderField.contentType.rawValue)
            urlRequest.setValue(type.rawValue, forHTTPHeaderField: HttpHeaderField.acceptType.rawValue)
        }
        
        return urlRequest
    }
    
}

extension URLRequest {

    /// Returns a cURL command for a request
    /// - return A String object that contains cURL command or "" if an URL is not properly initalized.
    func stringRequest() -> String {

        guard
            let url = url,
            let httpMethod = httpMethod,
            url.absoluteString.utf8.count > 0
            else {
                return ""
        }

        var curlCommand = "⚡️⚡️ API Hit ⚡️⚡️\n\n"

        // URL
        curlCommand = curlCommand.appendingFormat("URL : '%@' \n", url.absoluteString)

        // Method if different from GET
        curlCommand = curlCommand.appendingFormat("Method : %@ \n", httpMethod)
        
        // Headers
        let allHeadersFields = allHTTPHeaderFields!
        let allHeadersKeys = Array(allHeadersFields.keys)
        let sortedHeadersKeys  = allHeadersKeys.sorted(by: <)
        curlCommand = sortedHeadersKeys.count > 0 ? curlCommand.appendingFormat("Headers : \n") : curlCommand.appendingFormat("")
        for key in sortedHeadersKeys {
            curlCommand = curlCommand.appendingFormat("'%@: %@' \n", key, self.value(forHTTPHeaderField: key)!)
        }
        
        // HTTP body
        if let httpBody = httpBody, httpBody.count > 0 {
            let httpBodyString = String(data: httpBody, encoding: String.Encoding.utf8)!
            let escapedHttpBody = URLRequest.escapeAllSingleQuotes(httpBodyString)
            curlCommand = curlCommand.appendingFormat("Http Body: \n '%@' \n", escapedHttpBody)
        }
        
//        curlCommand = curlCommand.appendingFormat("Api Hit Time: '%@' \n", TimeUtil.global.currentDateTime())
        curlCommand = curlCommand.appendingFormat("Api Hit Timestamp: \(Date().timeIntervalSince1970) \n")
        
        return curlCommand
    }

    /// Escapes all single quotes for shell from a given string.
    static func escapeAllSingleQuotes(_ value: String) -> String {
        return value.replacingOccurrences(of: "'", with: "'\\''")
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
    
        return prettyPrintedString
    }
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
