
struct Nexus {
    
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
