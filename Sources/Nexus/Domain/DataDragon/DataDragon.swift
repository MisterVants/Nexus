//
//  DataDragon.swift
//
//  Copyright (c) 2020 André Vants
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

open class DataDragon {
    
    enum ResourceType {
        case versionedData(_ version: String, _ locale: String)
        case versionedImage(_ version: String)
        case image
        case none
        
        var isNone: Bool {
            guard case .none = self else { return false }
            return true
        }
        
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
    
    typealias TypeProvider = (String, String) -> ResourceType
    
    open private(set) var region: Region
    
    open var currentVersion: String? {
        overrideVersion ?? autoversion?.version
    }
    
    open var currentLocale: String? {
        overrideLocale ?? autoversion?.locale
    }
    
    public private(set) var autoversion: (version: String, locale: String)?
    
    public private(set) var overrideVersion: String?
    public private(set) var overrideLocale: String?
    
    private let api: DataDragonAPI
    private let versionedData: TypeProvider = { .versionedData($0, $1) }
    private let versionedImage: TypeProvider = { v, _ in .versionedImage(v) }
    
    init(region: Region, api: DataDragonAPI = DataDragonAPI()) {
        self.region = region
        self.api = api
    }
    
    open func selectRegion(_ region: Region) {
        guard region != self.region else { return }
        self.autoversion = nil
        self.region = region
    }
    
    open func selectVersion(_ version: String?) {
        self.overrideVersion = version
    }
    
    open func selectLocale(_ locale: String?) {
        self.overrideLocale = locale
    }
    
    // MARK: Unversioned Data
    
    open func getRealm(for region: Region, completion: @escaping (Response<Realm>) -> Void) {
        api.getRealm(for: region, completion: completion)
    }
    
    open func getLanguages(completion: @escaping (Response<[String]>) -> Void) {
        api.getLanguages(completion: completion)
    }
    
    open func getVersions(completion: @escaping (Response<[String]>) -> Void) {
        api.getVersions(completion: completion)
    }
    
    // MARK: Versioned Data
    
    open func getLocalizedStrings(completion: @escaping (Response<DataAsset<String>>) -> Void) {
        getData(.localizedStrings, typeProvider: versionedData, completion: completion)
    }
    
    open func getChampions(completion: @escaping (Response<ChampionDto>) -> Void) {
        getData(.champions, typeProvider: versionedData, completion: completion)
    }
    
    open func getChampionDetails(byID championID: String, completion: @escaping (Response<DataAsset<Champion>>) -> Void) {
        getData(.championDetail(championID), typeProvider: versionedData, completion: completion)
    }
    
    open func getItems(completion: @escaping (Response<DataAsset<Item>>) -> Void) {
        getData(.items, typeProvider: versionedData, completion: completion)
    }
    
    open func getSummonerSpells(completion: @escaping (Response<DataAsset<SummonerSpell>>) -> Void) {
        getData(.summonerSpells, typeProvider: versionedData, completion: completion)
    }
    
    open func getProfileIcons(completion: @escaping (Response<DataAsset<ProfileIcon>>) -> Void) {
        getData(.profileIcon, typeProvider: versionedData, completion: completion)
    }
    
    open func getMaps(completion: @escaping (Response<DataAsset<Minimap>>) -> Void) {
        getData(.maps, typeProvider: versionedData, completion: completion)
    }
    
    open func getRunesReforged(completion: @escaping (Response<[RunesReforged.Path]>) -> Void) {
        getData(.runesReforged, typeProvider: versionedData, completion: completion)
    }

    // MARK: Unversioned Images
     
    open func getSplashArt(byID championID: String, skinIndex: Int, completion: @escaping (Response<Data>) -> Void) {
        api.getSplashArt(byID: championID, skinIndex: skinIndex, completion: completion)
    }
    
    open func getLoadingScreenArt(byID championID: String, skinIndex: Int, completion: @escaping (Response<Data>) -> Void) {
        api.getLoadingScreenArt(byID: championID, skinIndex: skinIndex, completion: completion)
    }
    
    open func getRuneReforgedIcon(path: String, completion: @escaping (Response<Data>) -> Void) {
        api.getRuneReforgedIcon(path: path, completion: completion)
    }
    
    open func getRuneReforgedPathIcon(path: String, completion: @escaping (Response<Data>) -> Void) {
        api.getRuneReforgedPathIcon(path: path, completion: completion)
    }
    
    // MARK: Versioned Images
    
    open func getChampionThumbnail(byID championID: String, completion: @escaping (Response<Data>) -> Void) {
        getImage(.championThumbnail(championID), typeProvider: versionedImage, completion: completion)
    }
    
    open func getPassiveImage(filename: String, version: String, completion: @escaping (Response<Data>) -> Void) {
        getImage(.passive(filename), typeProvider: versionedImage, completion: completion)
    }
    
    open func getSpellImage(filename: String, version: String, completion: @escaping (Response<Data>) -> Void) {
        getImage(.spell(filename), typeProvider: versionedImage, completion: completion)
    }
    
    open func getItemImage(byID itemID: String, version: String, completion: @escaping (Response<Data>) -> Void) {
        getImage(.item(itemID), typeProvider: versionedImage, completion: completion)
    }
    
    open func getSummonerSpellImage(byID spellID: String, version: String, completion: @escaping (Response<Data>) -> Void) {
        getImage(.summonerSpell(spellID), typeProvider: versionedImage, completion: completion)
    }
    
    open func getProfileIconImage(byID profileIconID: String, version: String, completion: @escaping (Response<Data>) -> Void) {
        getImage(.profileIcon(profileIconID), typeProvider: versionedImage, completion: completion)
    }
    
    open func getMinimapImage(mapID: String, version: String, completion: @escaping (Response<Data>) -> Void) {
        getImage(.minimap(mapID), typeProvider: versionedImage, completion: completion)
    }
    
    open func getSpriteSheet(filename: String, version: String, completion: @escaping (Response<Data>) -> Void) {
        getImage(.spriteSheet(filename), typeProvider: versionedImage, completion: completion)
    }
    
    open func getScoreboardIcon(byType iconType: ScoreboardIcon, completion: @escaping (Response<Data>) -> Void) {
        getImage(.scoreboardIcon(iconType), typeProvider: versionedImage, completion: completion)
    }
    
    // MARK: Automanaged Data Access
    
    func getData<T: Decodable>(_ resource: StaticData, typeProvider: @escaping TypeProvider, completion: @escaping (Response<T>) -> Void) {
        requestVersioned(resource, typeProvider: typeProvider, completion: completion)
    }
    
    func getImage<T: Decodable>(_ resource: ImageAsset, typeProvider: @escaping TypeProvider, completion: @escaping (Response<T>) -> Void) {
        requestVersioned(resource, typeProvider: typeProvider, completion: completion)
    }
    
    func requestVersioned<T: Decodable>(_ resource: APIResource, typeProvider: @escaping TypeProvider, completion: @escaping (Response<T>) -> Void) {
        if let version = currentVersion, let locale = currentLocale {
            api.request(resource, type: typeProvider(version, locale), completion: completion)
        } else {
            api.getRealm(for: region) { response in
                do {
                    let realm = try response.result.get()
                    self.autoversion = (realm.version, realm.localeDefault)
                    self.api.request(resource, type: typeProvider(realm.version, realm.localeDefault), completion: completion)
                } catch {
                    completion(Response(error: NexusError.automanagedVersionLoadFail(error)))
                }
            }
        }
    }
}
