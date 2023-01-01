//
//  RealmManger.swift
//  ToDoApp
//
//  Created by Omar Khattab on 06/12/2022.
//


import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published var tasks: [Task] = []

    // On initialize of the class, we'll open a Realm and get the tasks saved in the Realm
    init() {
        openRealm()
        getTasks()
    }

    // Function to open a Realm (like a box) - needed for saving data inside of the Realm
    func openRealm() {
        do {
            // Setting the schema version
            let config = Realm.Configuration(schemaVersion: 1)

            // Letting Realm know we want the defaultConfiguration to be the config variable
            Realm.Configuration.defaultConfiguration = config

            // Trying to open a Realm and saving it into the localRealm variable
            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }

    // Function to add a task
    func addTask(taskTitle: String) {
        if let localRealm = localRealm { // Need to unwrap optional, since localRealm is optional
            do {
                // Trying to write to the localRealm
                try localRealm.write {
                    // Creating a new Task
                    let newTask = Task(value: ["title": taskTitle, "completed": false])
                   
                    // Adding newTask to localRealm
                    localRealm.add(newTask)
                    
                    // Re-setting the tasks array
                    getTasks()
                    print("Added new task to Realm!", newTask)
                }
            } catch {
                print("Error adding task to Realm: \(error)")
            }
        }
    }
    
    // Function to get all tasks from Realm and setting them in the tasks array
    func getTasks() {
        if let localRealm = localRealm {
            
            // Getting all objects from localRealm and sorting them by completed state
            let allTasks = localRealm.objects(Task.self).sorted(byKeyPath: "completed")
            
            // Resetting the tasks array
            tasks = []
            
            // Append each task to the tasks array
            allTasks.forEach { task in
                tasks.append(task)
            }
        }
    }

    // Function to update a task's completed state
    func updateTask(id: ObjectId, completed: Bool) {
        if let localRealm = localRealm {
            do {
                // Find the task we want to update by its id
                let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                
                // Make sure we found the task and taskToUpdate array isn't empty
                guard !taskToUpdate.isEmpty else { return }

                // Trying to write to the localRealm
                try localRealm.write {
                    
                    // Getting the first item of the array and changing its completed state
                    taskToUpdate[0].completed = completed
                    
                    // Re-setting the tasks array
                    getTasks()
                    print("Updated task with id \(id)! Completed status: \(completed)")
                }
            } catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }

    // Function to delete a task
    func deleteTask(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                // Find the task we want to delete by its id
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                
                // Make sure we found the task and taskToDelete array isn't empty
                guard !taskToDelete.isEmpty else { return }
                
                // Trying to write to the localRealm
                try localRealm.write {
                    
                    // Deleting the task
                    localRealm.delete(taskToDelete)
                    
                    // Re-setting the tasks array
                    getTasks()
                    print("Deleted task with id \(id)")
                }
            } catch {
                print("Error deleting task \(id) to Realm: \(error)")
            }
        }
    }
}






//import Foundation
//import RealmSwift
//
//class RealmManger: ObservableObject {
//
//    private(set) var localRealm : Realm?
//
//    @Published private(set) var tasks : [Task] = [] // Published array to view
//
//    init(){
//        openRealm()
//        getTask()
//    }
//
//    // Realm Confiuration
//    func openRealm(){
//        do{
//            let config = Realm.Configuration(schemaVersion: 1)
//            Realm.Configuration.defaultConfiguration = config
//            localRealm = try Realm()
//        }catch{
//            print("Error \(error)")
//        }
//    }
//
//  // MARK: - Add CURD Functions
//
//    // Add Task to DB Function
//    func addTask(taskTitle: String){
//        if let localRealm = localRealm {
//            do{
//                try localRealm.write{
//                    let newTask = Task(value: ["title": taskTitle, "completed" : false])
//                    localRealm.add(newTask)
//                    getTask()  // This let us update task array every time we add task
//                    print("Added \(newTask)")
//                }
//            } catch{
//              print("Error Adding \(error)")
//            }
//        }
//    }
//
//    // Get task from DB function
//    func getTask(){
//        if let localRealm = localRealm {
//            let allTasks = localRealm.objects(Task.self).sorted(byKeyPath: "completed") // sort
//            tasks = []
//            allTasks.forEach { task in   // add sorted to tasks array
//                tasks.append(task)
//            }
//        }
//    }
//
//    // Update task in DB function
//    func updateTask(id: ObjectId, completed: Bool){
//        if let localRealm = localRealm {
//            do{
//                let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@" , id))
//                guard !taskToUpdate.isEmpty  else {return}
//                try localRealm.write{
//                    taskToUpdate[0].completed = completed
//                    getTask()
//                }
//            }catch{
//                print("Error updating \(error)")
//            }
//        }
//    }
//
//    // Delete task in DB function
//    func deleteTask(id: ObjectId){
//        if let localRealm = localRealm {
//            do{
//                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@" , id))
//                guard !taskToDelete.isEmpty  else {return}
//
//                try localRealm.write{
//                    localRealm.delete(taskToDelete)
//                    getTask()
//                }
//            } catch{
//                print("Error deleting \(error)")
//            }
//        }
//    }
//
//
//} // class end
