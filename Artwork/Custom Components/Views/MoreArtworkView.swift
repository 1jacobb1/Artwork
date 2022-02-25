//
//  MoreArtworkView.swift
//  Artwork
//
//  Created by Jacob on 2/25/22.
//

import UIKit

protocol MoreArtworkViewDelegate: AnyObject {
    func moreArtworkViewDidSelectArtwork(_ source: MoreArtworkView,
                                         artwork: Artwork,
                                         moreArtwork: [Artwork])
}

class MoreArtworkView: UIView {

    var moreWorkLbl = UILabel()
    var collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewLayout())

    var artworks: [Artwork] = []
    weak var delegate: MoreArtworkViewDelegate?

    init() {
        super.init(frame: .zero)
        setUpView()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    deinit { deinitLog() }

    func setArtworks(_ artworks: [Artwork]) {
        self.artworks = artworks
        collectionView.reloadData()
        isHidden = artworks.isEmpty
    }
}

extension MoreArtworkView {

    func setUpView() {
        setUpMoreWorkLabel()
        setUpCollectionView()
    }

    private func setUpMoreWorkLabel() {
        moreWorkLbl.text = "More artworks from the artist"
        moreWorkLbl.font = .boldSystemFont(ofSize: 18)

        addSubview(moreWorkLbl)

        moreWorkLbl.snp.makeConstraints { make in
            let leftRight = 15
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(leftRight)
        }
    }

    private func setUpCollectionView() {
        collectionView.register(MoreArtworkCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.delegate = self
        collectionView.dataSource = self

        addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            let top = 5, bottom = 15, height = 130
            make.top.equalTo(moreWorkLbl.snp.bottom).offset(top)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(bottom)
            make.height.equalTo(height)
        }
    }
}

extension MoreArtworkView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        artworks.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MoreArtworkCell = collectionView.dequeueReusableCell(for: indexPath)
        guard let artwork = artworks[safe: indexPath.item] else { return cell }
        cell.setCellWithArtwork(artwork)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath)
    -> CGSize {
        .init(width: 120, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let artwork = artworks[safe: indexPath.item] else { return }
        var artworks = self.artworks.filter { $0.id != artwork.id }
        delegate?.moreArtworkViewDidSelectArtwork(self, artwork: artwork, moreArtwork: artworks)
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MoreArtworkCell else { return }
        UIView.animate(withDuration: 0.3) {
            cell.roundedShadowView.transform = .init(scaleX: 0.9, y: 0.9)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MoreArtworkCell else { return }
        UIView.animate(withDuration: 0.3) {
            cell.roundedShadowView.transform = .identity
        }
    }
}
