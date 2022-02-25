//
//  ArtworksViewController+Views.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import UIKit

extension ArtworksViewController {

    func setUpScene() {
        view.backgroundColor = .white
        configureNavigationButton()
        setUpTableView()
        setUpTableHeaderView()
    }

    private func configureNavigationButton() {
        navigationItem.rightBarButtonItem = editBtn
    }

    private func setUpTableView() {
        tblView.refreshControl = tblViewRefreshControl
        tblView.backgroundColor = .white
        tblView.register(ArtworkCell.self)
        tblView.delegate = self
        tblView.dataSource = self
        tblView.estimatedRowHeight = UITableView.automaticDimension
        tblView.rowHeight = UITableView.automaticDimension
        tblView.separatorStyle = .none

        view.addSubview(tblView)

        tblView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setUpTableHeaderView() {
        featuredView.delegate = self
        featuredView.frame.size.height = featuredView.mainHeight
        tblView.tableHeaderView = featuredView
    }
}
