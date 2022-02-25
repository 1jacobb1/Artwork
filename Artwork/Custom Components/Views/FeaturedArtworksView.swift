//
//  FeaturedArtworksView.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import UIKit

protocol FeaturedArtworksViewDelegate: AnyObject {
    func featuredArtworksView(_ source: FeaturedArtworksView,
                              didSelectArtwork artwork: Artwork)
}

class FeaturedArtworksView: UIView {

    // MARK: - UI
    var titleLbl = UILabel()
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    weak var delegate: FeaturedArtworksViewDelegate?
    internal var artworks: [Artwork] = []
    internal let collectionViewHeight: CGFloat = 250
    let mainHeight: CGFloat = 310

    init() {
        super.init(frame: .zero)
        setUpViews()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    deinit { deinitLog() }

    func setArtworks(_ artworks: [Artwork]) {
        self.artworks = artworks
        collectionView.reloadData()
    }
}

extension FeaturedArtworksView {

    func setUpViews() {
        setUpTitleLabel()
        setUpCollectionView()
    }

    private func setUpTitleLabel() {
        titleLbl.text = "Featured Artworks"
        titleLbl.font = .boldSystemFont(ofSize: 30)
        titleLbl.numberOfLines = 0

        addSubview(titleLbl)

        titleLbl.snp.makeConstraints { make in
            let leftRight = 15, top = 10
            make.top.equalToSuperview().offset(top)
            make.left.right.equalToSuperview().inset(leftRight)
        }
    }

    private func setUpCollectionView() {
        collectionView.register(FeaturedArtworkCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.delegate = self
        collectionView.dataSource = self

        addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            let top = 10, bottom = 10
            make.top.equalTo(titleLbl.snp.bottom).offset(top)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(bottom)
            make.height.equalTo(collectionViewHeight)
        }
    }
}

extension FeaturedArtworksView:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        let cell: FeaturedArtworkCell = collectionView.dequeueReusableCell(for: indexPath)
        guard let artwork = artworks[safe: indexPath.item] else { return cell }
        cell.setCellWithArtwork(artwork)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int)
    -> Int {
        artworks.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let artwork = artworks[safe: indexPath.item] else { return }
        delegate?.featuredArtworksView(self, didSelectArtwork: artwork)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath)
    -> CGSize {
        .init(width: 160, height: collectionViewHeight)
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FeaturedArtworkCell else { return }
        UIView.animate(withDuration: 0.3) {
            cell.roundedShadowView.transform = .init(scaleX: 0.9, y: 0.9)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FeaturedArtworkCell else { return }
        UIView.animate(withDuration: 0.3) {
            cell.roundedShadowView.transform = .identity
        }
    }
}
