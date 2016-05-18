

/*:
 
 ### Simple proxy that makes a network call
 
*/
let simpleProxy = SimpleProxy()
let wonka = simpleProxy.getMeme(.CondescendingWonka(top: "Please", bottom: "Tell me about your proxies"))




/*:
 
 ### Proxy that caches the response
 
 */
let cacheProxy = CacheProxy()

// Will make network call
let tsa = cacheProxy.getMeme(.TsaDouche(top: "I'm afraid", bottom: "I have to search your cache"))

// Will make network call
let tsaCommingToGetYou = cacheProxy.getMeme(.TsaDouche(top: "Looks to me", bottom: "Like you're hiding something"))

// Will use the cached version
let tsaCached = cacheProxy.getMeme(.TsaDouche(top: "I'm afraid", bottom: "I have to search your cache"))




let failureProxy = SimpleProxy()
let myFailure = failureProxy.getMeme(.Borked)