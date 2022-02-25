//
//  ArtworksViewController.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import UIKit
import SnapKit
import ReactiveCocoa

protocol ArtworksViewControllerDelegate: AnyObject {
    func artworksViewControllerOpenDetailForSelectedArtwork(_ source: ArtworksViewController,
                                                            artwork: Artwork,
                                                            moreArtworks: [Artwork])
}

class ArtworksViewController: UIViewController {

    // MARK: - UI
    var editBtn = UIBarButtonItem()
    var tblViewRefreshControl = UIRefreshControl()
    var tblView = UITableView()
    var tblHeaderView = UIView()
    var featuredView = FeaturedArtworksView()

    // MARK: - Properties
    weak var delegate: ArtworksViewControllerDelegate?
    var viewModel: ArtworksViewModelTypes

    init(viewModel: ArtworksViewModelTypes) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        editBtn = UIBarButtonItem(image: .systemSquareAndPencil,
                                         style: .plain,
                                         target: self,
                                         action: #selector(editButtonDidClick))
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    deinit { deinitLog() }

    override func loadView() {
        super.loadView()
        setUpScene()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
        tblView.tableHeaderView?.layoutIfNeeded()
        title = "Artworks"
    }
}
