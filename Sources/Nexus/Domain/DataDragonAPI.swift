//
//  File.swift
//  
//
//  Created by André Vants Soares de Almeida on 04/03/20.
//

import Foundation

// TODO: Protocols to separate data and images apis
public struct DataDragonAPI: APIDomain {
    public init() {}
    public var hostname: String = "ddragon.leagueoflegends.com"
    let provider: Provider = SimpleProvider() // Only for experimenting, refactor later
    
    public func getRealm(for region: Region, completion: @escaping (Response<Realm>) -> Void) {
        get(.realm(region), type: .none, completion: completion)
    }
    
    public func getLanguages(completion: @escaping (Response<[String]>) -> Void) {
        get(.languages, type: .none, completion: completion)
    }
    
    public func getVersions(completion: @escaping (Response<[String]>) -> Void) {
        get(.versions, type: .none, completion: completion)
    }
    
    public func getChampions(version: String, locale: String, completion: @escaping (Response<DataAsset<Champion>>) -> Void) {
        get(.champions, type: .versionedData(version, locale), completion: completion)
    }
    
    public func getChampionDetails(byID championID: String, version: String, locale: String, completion: @escaping (Response<DataAsset<Champion>>) -> Void) {
        get(.championDetail(championID), type: .versionedData(version, locale), completion: completion)
    }
    
    public func getItems(version: String, locale: String, completion: @escaping (Response<DataAsset<Item>>) -> Void) {
        get(.items, type: .versionedData(version, locale), completion: completion)
    }
    
    public func getSummonerSpells(version: String, locale: String, completion: @escaping (Response<DataAsset<SummonerSpell>>) -> Void) {
        get(.summonerSpells, type: .versionedData(version, locale), completion: completion)
    }
    
//    public func getProfileIcons(version: String, locale: String, completion: @escaping (Response<ProfileIconDto>) -> Void) {
//
//    }
    
//    public func getMaps(version: String, locale: String, completion: @escaping (Response<MapDto>) -> Void) {
//
//    }
    
    public func getRunesReforged(version: String, locale: String, completion: @escaping (Response<[RunesReforged.Path]>) -> Void) {
        get(.runesReforged, type: .versionedData(version, locale), completion: completion)
    }
    
    public func getChampionThumbnail(byID championID: String, version: String, completion: @escaping (Response<Data>) -> Void) {
        get(.championThumbnail(championID), type: .versionedImage(version), completion: completion)
    }
    
    private func get<T: Decodable>(_ resource: StaticDataResource, type: ResourceType, completion: @escaping (Response<T>) -> Void) {
        request(resource, type: type, completion: completion)
    }
    
    private func get<T: Decodable>(_ resource: ImageResource, type: ResourceType, completion: @escaping (Response<T>) -> Void) {
        request(resource, type: type, completion: completion)
    }
    
    // Put this in protocol?
    private func request<T: Decodable>(_ resource: APIMethod, type: ResourceType, completion: @escaping (Response<T>) -> Void) {
        do {
            let url = resource.endpointPath(from: type.pathURL(from: try self.asURL()))
            let request = APIRequest(url: url, method: resource)
            provider.perform(request, completion: completion)
        } catch {
            fatalError()
        }
    }
}

enum ResourceType {
    case versionedData(_ version: String, _ locale: String)
    case versionedImage(_ version: String)
    case image
    case none
    
    func pathURL(from baseURL: URL) -> URL {
        switch self {
        case .versionedData(let version, let locale):
            return baseURL.appendingPathComponents("cdn", version, "data", locale)
        case .versionedImage(let version):
            return baseURL.appendingPathComponents("cdn", version, "img")
        case .image:
            return baseURL.appendingPathComponents("cdn", "img")
        default:
            return baseURL
        }
    }
}
