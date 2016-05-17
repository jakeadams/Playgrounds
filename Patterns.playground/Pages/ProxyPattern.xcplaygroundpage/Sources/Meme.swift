import Foundation

public enum Meme: Hashable {
  case CondescendingWonka(top: String, bottom: String)
  case TsaDouche(top: String, bottom: String)
  
  public var hashValue: Int {
    switch self {
    case .CondescendingWonka(let topText, let bottomText):
      return topText.hashValue + bottomText.hashValue
    case .TsaDouche(let topText, let bottomText):
      return topText.hashValue + bottomText.hashValue
    }
  }
  
  public func name() -> String {
    switch self {
    case .CondescendingWonka(_, _):
      return "Condescending Wonka"
    case .TsaDouche(_, _):
      return "TSA Douche"
    }
  }
  
  public func queryString() -> String {
    switch self {
    case .CondescendingWonka(let topText, let bottomText):
      let query = "meme=\(name())&top=\(topText)&bottom=\(bottomText)"
      return query.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())!
      
    case .TsaDouche(let topText, let bottomText):
      let query = "meme=\(name())&top=\(topText)&bottom=\(bottomText)"
      return query.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())!
    }
  }
  
  
}

public func == (lhs: Meme, rhs: Meme) -> Bool {
  return lhs.hashValue == rhs.hashValue
}