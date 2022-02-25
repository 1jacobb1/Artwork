//
//  ArtworkDetailViewController.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import UIKit

protocol ArtworkDetailViewControllerDelegate: AnyObject {
    func artworkDetailViewControllerBackToArtworks(_ source: ArtworkDetailViewController)
    func artworkDetailViewControllerOpenOtherArtworkDetail(_ source: ArtworkDetailViewController,
                                                           artwork: Artwork,
                                                           moreArtwork: [Artwork])
}

class ArtworkDetailViewController: UIViewController {

    // MARK: - UI
    var backButtonItem = UIBarButtonItem()
    var shareButtonItem = UIBarButtonItem()
    var scrollView = UIScrollView()
    var roundedShadowView = UIView()
    var artDisplayImgView = UIImageView()
    var titleLbl = UILabel()
    var artistLbl = UILabel()
    var descriptionLbl = UILabel()
    var moreArtworkView = MoreArtworkView()

    weak var delegate: ArtworkDetailViewControllerDelegate?
    var viewModel: ArtworkDetailViewModelTypes

    init(viewModel: ArtworkDetailViewModelTypes) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        backButtonItem = UIBarButtonItem(image: .systemLeftArrow,
                                         style: .plain,
                                         target: self,
                                         action: #selector(didClickBackButtonItem))
        shareButtonItem = UIBarButtonItem(image: .systemSquareAndArrowUp,
                                          style: .plain,
                                          target: self,
                                          action: #selector(didClickShareButtonItem))
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
    }
}

