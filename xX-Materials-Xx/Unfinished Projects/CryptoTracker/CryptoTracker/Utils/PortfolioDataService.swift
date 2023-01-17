//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 04/01/2023.
//

import Foundation
import CoreData
class PortfolioDataService: ObservableObject {
    
    let container: NSPersistentContainer
    let containerName: String = "PortfolioContainer"
    let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading core data! \(error)")
            }
            self.getPortfolio()
        }
         print("=========== Current coins in codData in \(savedEntities.count) Element ===========")
    }
    
    // MARK: - Public
    func updatePortfolio(coin: CoinModel, amount: Double){
        if let entity = savedEntities.first(where: {$0.coinID == coin.id }) {
            if amount > 0{
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        }
        add(coin: coin, amount: amount)
    }
    
    //Private CRUD Functions    
    // MARK: - Add data to CoreData - C
    private func add(coin: CoinModel, amount: Double){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    // MARK: - Get data from CoreData - R
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error to fetch portfolio entities \(error)")
        }
    }
    // MARK: - Update entity func - U
    private func update(entity: PortfolioEntity, amount: Double){
        entity.amount = amount
        applyChanges()
    }
    // MARK: - Delete func - D
    private func delete(entity: PortfolioEntity){
        container.viewContext.delete(entity)
        applyChanges()
    }
    // MARK: - Core data saving action
    // We Save first then we call Get func to reload our Published array
    private func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to core data \(error)")
        }
    }
    private func applyChanges(){
        save()
        getPortfolio()
    }
    
    
}
