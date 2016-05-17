

import UIKit


enum Meme {
    case CondescendingWonka(String, String)
    
    func name() -> String {
        switch self {
        case .CondescendingWonka(_, _):
            return "Condescending Wonka"
        }
    }
    
    func queryString() -> String {
        switch self {
        case .CondescendingWonka(let topText, let bottomText):
            let query = "meme=\(name())&top=\(topText)&bottom=\(bottomText)"
            return query.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())!
        }
    }
}

protocol MemeGenRequest {
    func getMeme(meme: Meme) -> UIImage?
}


class SimpleProxy: MemeGenRequest {
    private let semaphore = dispatch_semaphore_create(0)
    func getMeme(meme: Meme) -> UIImage? {
        print("Trying to get \(meme)")
        var image: UIImage?
        
        let url = NSURL(string: "http://apimeme.com/meme?\(meme.queryString())")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, _, _) -> Void in
            
            guard let data = data else {
                dispatch_semaphore_signal(self.semaphore)
                return print("feelsbadman")
            }
            image = UIImage(data: data)
            
            print("Got \(image) from remote \n")
            dispatch_semaphore_signal(self.semaphore)
        }
        
        task.resume()
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
        return image
    }
}



let simpleProxy = SimpleProxy()
let meme = simpleProxy.getMeme(.CondescendingWonka("Please", "Tell me about your proxies"))




