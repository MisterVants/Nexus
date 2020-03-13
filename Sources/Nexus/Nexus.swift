
struct Nexus {
    
    enum APIKeyPolicy {
        case includeAsHeaderParameter
        case includeAsQueryParameter
    }
    
    public static var apiKeyPolicy: APIKeyPolicy = .includeAsHeaderParameter
    
    public private(set) static var apiKey: String?
    
    public static func setApiKey(_ apiKey: String) {
        guard Nexus.apiKey == nil else {
            // TODO: log error
            return
        }
        guard !apiKey.isEmpty else {
            fatalError("")
        }
        Nexus.apiKey = apiKey
    }
}
