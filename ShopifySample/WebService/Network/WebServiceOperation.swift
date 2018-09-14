//
// WebServiceOperation.swift
// https://github.com/angra007/AANetworking
// Copyright (c) 2013-16 Ankit Angra.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

open class WebServiceOperation {
    var url : String?
    var postData : Data?
    var completionHandler : WebServiceCompletionHandler?
    var processDownloadedData : ProcessDownloadCompletionHandler?
    var methodType : RequestMethodType?
    var contentType : RequestContentType?
    public init() {}
}

extension WebServiceOperation {
    /// This the method which is main method responsible to download JSON from server. As this is in NSOperation class it adds itself to the requestQueue. All the elements which are required to download are passed in Struct Resource. These elements are saved locally so that they can be used later
    ///
    /// - parameter resource:   This is the download resource. This will contain all the information to fetch data.
    /// - parameter completion: This is the completion Handler which will be called once we have some data or a error
    public func loadJSON (_ resource: Resource, completion:@escaping WebServiceCompletionHandler) {
        
        
        if isInternetActive () == true {
            url = resource.urlString
            postData = resource.data as Data?
            methodType = resource.methodType
            contentType = resource.contentType
            completionHandler = completion
            processDownloadedData = resource.parse
            load()
        }
        else {
            let noInternetError =  NSError (domain: "JSONError",code: -1000,userInfo: [NSLocalizedDescriptionKey: "Internet seems to be offline"])
            self.informCompletion(withData: nil, error: noInternetError)
        }
        
    }
    
    func isInternetActive () -> Bool {
        
        var reachable = false
        
        let internetStatus = Reachability()?.connection
        
        if internetStatus != .none {
            reachable = true
        }

        return reachable
    }
}

extension WebServiceOperation {
    
    func load () {

        // URL Validation
        let urlString = self.url
        guard !urlString!.isEmpty else {
            informCompletion(withData: nil, error: nil)
            return
        }
        let url = URL.init(string: urlString!)
        
        // This is to support GET and POST
        let JSONRequest  : WebRequest! = JSONRequestor ()
        if self.methodType == .get {
            JSONRequest.getRequest(url!, completion: {  (result, error) in
                self.handleDownloadCompletion(result, error: error)
            })
        }
        else if self.methodType == .post {
            JSONRequest.postRequest(withData: postData!, url: url!, contentType: contentType!,completion:  { (result, error) in
                self.handleDownloadCompletion(result, error: error)
            })
        }
    }
    
    func handleDownloadCompletion (_ result : JSONDictionary?, error : NSError?) {
        var object : AnyObject? = nil
        
        if let result = result {
            object = self.processDownloadedData?(result)
        }

        self.informCompletion(withData: object, error: error)
    }
    
    func informCompletion(withData result: AnyObject?, error: NSError?) {
        DispatchQueue.main.async {  
            self.completionHandler? (result,error)
        }
    }
}
