import Foundation
import UIKit



public class SimpleProxy {
  private let semaphore = dispatch_semaphore_create(0)
  
  public init() {
    
  }
  
  public func getMeme(meme: Meme) -> UIImage? {
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

public class CacheProxy {
  private let semaphore = dispatch_semaphore_create(0)
  private var images : [Meme : UIImage] = [:]
  
  public init() {
  }
  
  public func getMeme(meme: Meme) -> UIImage? {
    print("Trying to get \(meme)")
    var image: UIImage?
    
    if let cachedImage = images[meme] {
      print("We already got \(meme). No need to get remotely")
      return cachedImage
    }
    
    let url = NSURL(string: "http://apimeme.com/meme?\(meme.queryString())")
    
    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {
      (data, _, _) -> Void in
      
      guard let data = data else {
        dispatch_semaphore_signal(self.semaphore)
        return print("feelsbadman")
      }
      image = UIImage(data: data)
      print("Got \(image) from remote")
      self.images[meme] = image
      print("Stored it for next time")
      dispatch_semaphore_signal(self.semaphore)
    }
    
    task.resume()
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
    return image
  }
}