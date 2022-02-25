//
//  HomeTabBarViewController.swift
//  Artwork
//
//  Created by Jacob on 2/22/22.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    /**
     List of ViewControllers used as tab
     */
    var artWorksVC: ArtworksViewController

    var viewModel: HomeTabBarViewModelTypes

    init(viewModel: HomeTabBarViewModelTypes) {
        self.viewModel = viewModel

        let artworksVm = ArtworksViewModel(networkProvider: viewModel.outputs.networkProvider)
        artWorksVC = ArtworksViewController(viewModel: artworksVm)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    deinit { deinitLog() }

    override func loadView() {
        super.loadView()
        setUpScene()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setUpScene() {
        view.backgroundColor = .white
        setUpViewControllers()
    }

    private func setUpViewControllers() {

        artWorksVC.tabBarItem.image = UIImage(systemName: "house")
        artWorksVC.tabBarItem.title = "Home"

        viewControllers = [UINavigationController(rootViewController: artWorksVC)]
    }
}
