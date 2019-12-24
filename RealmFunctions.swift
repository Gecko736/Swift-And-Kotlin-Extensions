import Foundation
import RealmSwift

extension Realm {
    public static let realm = try! Realm()
    
    public static func create<O: Object>(_ object: O) {
        write { realm.add(object) }
    }
    
    public static func read() {
        // load objects from Realm into static arrays
    }
    
    public static func update<O: Object>(_ object: O) {
        write { realm.add(object, update: .modified) }
    }
    
    public static func delete<O: Object>(_ object: O) {
        write { realm.delete(object) }
    }
    
    public static func write(_ transaction: @escaping () -> ()) {
        if realm.isInWriteTransaction { transaction() }
        else {
            do { try realm.write { transaction() } }
            catch { print(error) }
        }
    }
}
