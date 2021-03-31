//
//  NetworkReachabilityService.swift
//  Wagr-Assignment
//
//  Created by Steven Andrews on 2021-03-27.
//

import Network

// Notifies observing objects when the network reachability status changes
protocol NetworkReachabilityObserver: class {
    func statusDidChange(status: NWPath.Status)
}

class NetworkReachabilityService {
    
    // MARK: - Structs
    
    struct NetworkChangeObservation {
        weak var observer: NetworkReachabilityObserver?
    }
    
    // MARK: - Private Properties
    
    private static let _shared = NetworkReachabilityService()
    
    private var monitor = NWPathMonitor()
    private var observations = [ObjectIdentifier: NetworkChangeObservation]()
    
    // MARK: - Internal Properties
    
    var currentStatus: NWPath.Status {
        get {
            return monitor.currentPath.status
        }
    }
    
    // MARK: - Initializers
    
    init() {
        monitor.pathUpdateHandler = { [unowned self] path in
            for (id, observations) in self.observations {
                
                //If any observer is nil, remove it from the list of observers
                guard let observer = observations.observer else {
                    self.observations.removeValue(forKey: id)
                    continue
                }
                
                DispatchQueue.main.async {
                    observer.statusDidChange(status: path.status)
                }
            }
        }
        monitor.start(queue: DispatchQueue.global(qos: .background))
    }
    
    // MARK: - Static Methods
    
    class func shared() -> NetworkReachabilityService {
        return _shared
    }
    
    // MARK: - Internal Methods
    
    func addObserver(observer: NetworkReachabilityObserver) {
        let id = ObjectIdentifier(observer)
        observations[id] = NetworkChangeObservation(observer: observer)
    }
    
    func removeObserver(observer: NetworkReachabilityObserver) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }
    
}
