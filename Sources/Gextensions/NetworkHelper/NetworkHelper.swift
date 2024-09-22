//
//  File.swift
//  
//
//  Created by Mohamed Aglan on 7/23/24.
//

import Foundation

public class NetworkHelper {
    
    public static func getSize(url: URL?, request: URLRequest? = nil, completion: @escaping (_ size: Int64) -> Void) {
        DispatchQueue.global().async {
            var headRequest: URLRequest?
            if let url = url {
                headRequest = URLRequest(url: url)
            }
            
            if let request = request {
                headRequest = request
            }
            
            guard var headRequest = headRequest else {
                completion(-1)
                return
            }
            
            headRequest.httpMethod = "HEAD"
            headRequest.timeoutInterval = 10
            headRequest.addValue("", forHTTPHeaderField: "Accept-Encoding")
            
            let task = URLSession.shared.dataTask(with: headRequest) { (data, res, error) in
                if error != nil {
                    return
                }
                
                if let r = res as? HTTPURLResponse {
                    let contentLength = Int64(r.allHeaderFields["Content-Length"] as? String ?? "-1") ?? -1
                    let size = contentLength > 2048 ? contentLength : -1
                    DispatchQueue.main.async {
                        completion(size)
                    }
                }
            }
            task.resume()
        }
    }
    
    public static func getSize(urls: [URL?], completion: @escaping (_ size: Int64) -> Void) {
        let urlsWasSend = urls.count
        var urlsWasReceive = 0
        var totalSize: Int64 = 0
        
        for url in urls {
            getSize(url: url) { size in
                urlsWasReceive += 1
                if size > 0 {
                    totalSize += size
                }
                if urlsWasSend == urlsWasReceive {
                    completion(totalSize)
                }
            }
        }
    }
}
