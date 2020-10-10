//
//  State.swift
//  PointFree
//
//  Created by Srinivasan Rajendran on 2020-10-05.
//

import Foundation

struct AppState {
    var count = 0
    var favouritePrimes: [Int] = []
    var activityFeed: [Activity] = []

    struct Activity {
       let timestamp: Date = Date()
       let type: ActivityType

       enum ActivityType {
           case addedFavorites(Int)
           case removedFavorites(Int)
       }
    }
}

extension AppState {
    var favouritePrimesState: FavouritePrimesState {
        get {
            return FavouritePrimesState(favouritePrimes: self.favouritePrimes, activityFeed: self.activityFeed)
        }
        set {
            self.favouritePrimes = newValue.favouritePrimes
            self.activityFeed = newValue.activityFeed
        }
    }
}

struct FavouritePrimesState {
   var favouritePrimes: [Int] = []
    var activityFeed: [AppState.Activity] = []
}



enum CounterAction {
   case incrTapped
   case decrTapped
}

enum PrimeModalAction {
   case saveFavPrimesTapped
   case removeFavPrimesTapped
}

enum FavPrimesAction {
   case deleteFavPrimes(IndexSet)
}

enum AppAction {
   case counter(CounterAction)
   case primeModal(PrimeModalAction)
   case favPrimes(FavPrimesAction)

    var counter: CounterAction? {
        get {
            guard case let .counter(value) = self else {
                return nil
            }
            return value
        }
        set {
            guard case .counter = self, let newValue = newValue else { return }
            self = .counter(newValue)
        }
    }

    var primeModal: PrimeModalAction? {
        get {
            guard case let .primeModal(value) = self else {
                return nil
            }
            return value
        }
        set {
            guard case .primeModal = self, let newValue = newValue else { return }
            self = .primeModal(newValue)
        }
    }

    var favPrimes: FavPrimesAction? {
        get {
            guard case let .favPrimes(value) = self else {
                return nil
            }
            return value
        }
        set {
            guard case .favPrimes = self, let newValue = newValue else { return }
            self = .favPrimes(newValue)
        }
    }
}

