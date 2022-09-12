
# Adding CoreData to project

1) Create new data model (Command + N)
2) Add entities to the data model
3) Add properties to your entities
4) Modify relations if any "add relations, change type(to one or to many)"…this is optional step
5) Select both entities and from the right side menu change Codegen to “Manual/None”
6) From editor menu in the toolbar select **“Create NSManagedObject Subclass”**
7) Create wrapped var for every property in every entity 
Like this 👇🏼

```swift
  @NSManaged public var name: String?
  var wrappedName: String {name ?? "Unknown"}
```

8) Create “DataController” class (The container name is your CoreDate model name)

9) Initialize the data controller, to do that go to your **“{AppName}App.swift”** file and add following lines

add this line before body 

```swift
  @StateObject private var dataController = DataController()
```

And add this line to the content view inside window Group

```swift
  .environment(.managedObjectContext, dataController.container.viewContext)
```

10) Add Environment and FetchRequest to your content view by adding these two lines

```swift
  @Environment(.managedObjectContext) var moc
  @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<{EntityName}>
```

11) We can start save to the CoreDate Model by

```swift
  let newUser = CachedUser(context: moc)
  newUser.name = user.name
  Try? moc.save()
```


