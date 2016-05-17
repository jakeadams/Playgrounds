

import UIKit

let simpleProxy = SimpleProxy()
let wonka = simpleProxy.getMeme(.CondescendingWonka(top: "Please", bottom: "Tell me about your proxies"))





let cacheProxy = CacheProxy()
let tsa = cacheProxy.getMeme(.TsaDouche(top: "I'm afraid", bottom: "I have to search your cache"))

let tsa2 = cacheProxy.getMeme(.TsaDouche(top: "I'm afraid", bottom: "I have to search your cache"))


let tsa3 = cacheProxy.getMeme(.TsaDouche(top: "Looks to me", bottom: "Like you're hiding something"))