//
//  HomeTabBarViewModel.swift
//  Artwork
//
//  Created by Jacob on 2/22/22.
//

protocol HomeTabBarViewModelInputs {

}

protocol HomeTabBarViewModelOutputs {
    var networkProvider: Networkable { get }
}

protocol HomeTabBarViewModelTypes {
    var inputs: HomeTabBarViewModelInputs { get }
    var outputs: HomeTabBarViewModelOutputs { get }
}

class HomeTabBarViewModel: HomeTabBarViewModelTypes,
                           HomeTabBarViewModelInputs,
HomeTabBarViewModelOutputs {

    var inputs: HomeTabBarViewModelInputs { self }
    var outputs: HomeTabBarViewModelOutputs { self }

    var networkProvider: Networkable

    init(networkProvider: Networkable) {
        self.networkProvider = networkProvider
    }

    deinit { debugPrint("Deinit \(String(describing: self))") }
}
