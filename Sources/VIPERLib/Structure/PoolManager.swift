//
//  PoolManager.swift
//
//
//  Created by Vitalis Girsas on 30/1/24.
//

import Foundation
// ...........
public class PoolManager {
    // ...........
    internal enum Element: String {
        case controller = "Controller"
        case presenter = "Presenter"
        case interactor = "Interactor"
        case router = "Router"
        case services = "Services"
    }
    // ...........
    fileprivate enum Result {
        case success
        case fail
    }
    
    // MARK: - PROPERTIES 🔰 PRIVATE
    // ////////////////////////////////////
    private static var poolList = [Pool]()
    private static var servicePoolList = Set<String>()
    
    //  MARK: - METHODS 🔄 INTERNAL
    // ///////////////////////////////////////////
    internal static func add(element: Element, name: String, id: String) {
        // Check if item already exists
        guard let existingPool = poolList.first(where: { $0.id == id }) else {
            // Create a new pool and add to the list
            let moduleName = stripModuleName(from: name, for: element)
            let pool = Pool(id: id, moduleName: moduleName, element: element)
            poolList.append(pool)
            return
        }
        // Add if exists
        existingPool.add(element)
    }
    // ...........
    internal static func registerServiceCreation(withId id: String) {
        servicePoolList.insert(id)
    }
    
    // MARK: - METHODS 🌐 PUBLIC
    // ///////////////////////////////////////////
    public static func printPoolLog() {
        guard VIPER.isPringingDebug else {
            return
        }
        log(.debug, "VIPERLib: POOL COUNT: \(poolList.count)")
        log(.debug, "VIPERLib: SERVICES POOL COUNT: \(servicePoolList.count)")
    }
    
    // MARK: - METHODS 🔰 PRIVATE
    // ////////////////////////////////////
    private static func didFinish(with result: Result, id: String, andModuleName name: String) {
        // Remove all with id
        removeAll(withId: id)
        // Handle result
        switch result {
        case .success:
            // Check if printing releases enabled
            guard VIPER.isPringingReleases else {
                return
            }
            log(.info, "VIPERLib: MODULE RELEASED: \(name)")
            // ...........
        case .fail:
            log(.error, "VIPERLib: MODULE LEAK: \(name)")
        }
    }
    // ...........
    private static func removeAll(withId id: String) {
        poolList.removeAll { $0.id == id }
        servicePoolList.remove(id)
    }
    // ...........
    private static func stripModuleName(from name: String, for element: Element) -> String {
        if let range = name.range(of: Element.controller.rawValue) {
            let firstPart = name[name.startIndex..<range.lowerBound]
            return String(firstPart)
        }
        return name
    }
}
// MARK: -
// .............................................................................................
extension PoolManager {
    // ...........
    internal final class Pool {
        // MARK: - PROPERTIES 🔰 PRIVATE
        // ////////////////////////////////////
        fileprivate let id: String
        fileprivate let moduleName: String
        fileprivate var elements: Set<Element> = []
        
        // MARK: - INITS
        // ////////////////////////////////////
        fileprivate init(id: String, moduleName: String, element: Element) {
            // Set properties
            self.id = id
            self.moduleName = moduleName
            self.elements.insert(element)
            // Start timer
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                // Check self
                guard let `self` = self else { return }
                // Print FAIL message
                PoolManager.didFinish(with: .fail, id: self.id, andModuleName: moduleName)
            }
        }
        
        //  MARK: - METHODS 🔄 INTERNAL
        // ///////////////////////////////////////////
        internal func add(_ element: Element) {
            // Inser item
            self.elements.insert(element)
            // Check if all collected
            validateElements()
        }
        
        // MARK: - METHODS 🔰 PRIVATE
        // ////////////////////////////////////
        private func validateElements() {
            // Check if all the elements collected
            guard Set([.controller, .presenter, .interactor, .router]).isSubset(of: elements) else {
                return
            }
            // Check services record
            guard !(servicePoolList.contains(self.id) && !elements.contains(.services)) else {
                return
            }
            // Print SUCCESS message
            PoolManager.didFinish(with: .success, id: self.id, andModuleName: self.moduleName)
        }
    }
}
