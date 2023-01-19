//
//  DeleteFromCoreDataFunction.swift
//  FriendFace
//
//  Created by Omar Khattab on 17/09/2022.
//

import Foundation

struct DeleteCoreDataEntity{
    func delete(entityName: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName1)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        let batchDelete = try! moc.execute(deleteRequest) as? NSBatchDeleteResult
        guard let deleteResult = batchDelete?.result as? [NSManagedObjectID] else { return }
        let deletedObjects: [AnyHashable: Any] = [NSDeletedObjectsKey: deleteResult]
        NSManagedObjectContext.mergeChanges(
            fromRemoteContextSave: deletedObjects,
            into: [moc]
        )
    }
}
