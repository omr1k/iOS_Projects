//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Omar Khattab on 16/10/2022.
//

import CodeScanner
import SwiftUI
import UserNotifications


struct ProspectsView: View {
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    enum SortType {
        case name, recent
    }
    
    let filter: FilterType
    @State var sort: SortType = .recent
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var promoteSettings = false
    let contactedPerson = Image(systemName: "person.fill.checkmark")
    let uncontactedPerson = Image(systemName: "person.fill.xmark")
    @State private var showFilterDialog = false
    
    var everyOneScreenFalg : Bool{
        if filter == .none {
            return true
        }else{
            return false
        }
    }
    
    var filteredSortedProspects: [Prospect] {
        switch sort {
        case .name:
            return filteredProspects.sorted { $0.name < $1.name }
        case .recent:
            return filteredProspects.sorted { $0.date > $1.date }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    let random = ["Brittany Brown\nbrittany.brown@random.com", "Adina Woodward\nadina.woodward@random.com", "Euan Rankin\neuan.rankin@random.com", "Arman Lawrence\narman.lawrence@random.com", "Rumaysa Lang\nrumaysa.lang@random.com", "Pawel Kerr\npawel.kerr@random.com", "Ashlee Reilly\nashlee.reilly@random.com", "Tabitha Monroe\ntabitha.monroe@random.com", "Deen Key\ndeen.key@random.com", "Aasiyah Byrd\naasiyah.byrd@random.com", "Esmee Robinson\n@random.com", "Bill Archer\nbill.archer@random.com", "Umar Whitworth\numar.whitworth@random.com", "Azra Hernandez\nazra.hernandez@random.com", "Nadine Matthams\nnadine.matthams@random.com", "Mateo Pearce\nmateo.pearce@random.com", "Shelbie Santiago\nshelbie.santiago@random.com", "Md Stokes\n@md.stokesrandom.com", "Mathilde Macfarlane\nmathilde.macfarlane@random.com", "Jamila Fernandez\njamila.fernandez@random.com"]

    
    var body: some View {
        NavigationView {
            List(){
                ForEach(filteredSortedProspects) { prospect in
                    HStack{
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if prospect.isContacted{
                            Image(systemName: "person.fill.checkmark")
                                .foregroundColor(.green)
                        }else{
                            Image(systemName: "person.fill.xmark")
                                .foregroundColor(.red)
                        }
                        
                    }
                    .swipeActions (edge : .leading) {
                        if prospect.isContacted {
                            Button{
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                VStack{
                                    Text("sfdfs")
                                    Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                                  
                                }
                                
                            }
                            .tint(.green)
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
                .onDelete(perform: everyOneScreenFalg ? deleteRecord : nil)
            }
                .navigationTitle(title)
                .toolbar {
                    Button {
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                    Button {
                        showFilterDialog = true
                    } label: {
                        Label("Show", systemImage: "arrow.up.arrow.down.square")
                    }
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: self.random.randomElement()!, completion: handleScan)
                }
                .alert(isPresented: $promoteSettings) {
                    Alert (title: Text("Notification permission required"),
                           message: Text("Enable it from settings?"),
                           primaryButton: .default(Text("Settings"), action: {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }),
                           secondaryButton: .default(Text("Cancel")))
                }
                .confirmationDialog("select a filter", isPresented: $showFilterDialog, titleVisibility: .visible){
                    Button((self.sort == .name ? "✓ " : "") + "Name") { self.sort = .name
                        print("Current sorting val ===> \(sort)")}
                    Button((self.sort == .recent ? "✓ " : "") + "Most recent") { self.sort = .recent
                        print("Current sorting val ===> \(sort)") }
                }
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("rfgf")
                        promoteSettings.toggle()
                    }
                }
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
       isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
//            guard details.count == 2 else { return }

            let person = Prospect()
            
            if details.count == 2 {
                person.name = details[0]
                person.emailAddress = details[1]
            }
            else{
                person.name = result.string
            }
            
            

            prospects.add(person)
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func deleteRecord(at offsets: IndexSet) {
            for i in offsets.makeIterator() {
                print("index in fl \(i)")
                prospects.remove(index: i)
            }
    }
    
    
    
}  // end

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none).environmentObject(Prospects())
    }
}





//let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
//if !isRegisteredForRemoteNotifications {
//    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
//}
