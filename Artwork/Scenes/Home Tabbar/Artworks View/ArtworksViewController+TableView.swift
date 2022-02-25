//
//  ArtworksViewController+TableView.swift
//  Artwork
//
//  Created by Jacob on 2/24/22.
//

import UIKit

extension ArtworksViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.outputs.artworksInGroup.value.count
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.outputs.artworksInGroup.value[safe: section]?.artworks.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArtworkCell = tableView.dequeueReusableCell(for: indexPath)
        guard let artworksInSection = viewModel.outputs.artworksInGroup.value[safe: indexPath.section],
              let artwork = artworksInSection.artworks[safe: indexPath.row] else { return cell }
        cell.setArtwork(artwork)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let artworksInSection = viewModel.outputs.artworksInGroup.value[safe: indexPath.section],
              let artwork = artworksInSection.artworks[safe: indexPath.row] else { return }
        viewModel.inputs.tableViewDidSelectArtwork(artwork: artwork)
    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        tableViewCellAnimateOnHighlight(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        tableViewCellAnimateOnUnHighlight(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let groupedArtworks = viewModel.outputs.artworksInGroup.value
        if indexPath.section >= groupedArtworks.count - 1,
           let artworks = groupedArtworks[safe: indexPath.section]?.artworks,
           indexPath.row >= artworks.count - 2 {
            viewModel.inputs.loadMoreArtworks()
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.outputs.artworksInGroup.value[safe: section]?.artworks.first?.artistTitle
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView,
                   moveRowAt sourceIndexPath: IndexPath,
                   to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section == destinationIndexPath.section {
            viewModel.inputs.tableViewMoveArtwork(from: sourceIndexPath, to: destinationIndexPath)
        } else {
            presentAlertMessage("Unable to move artwork, it must be with the same artist.")
        }
    }

    private func tableViewCellAnimateOnHighlight(indexPath: IndexPath) {
        guard let cell = tblView.cellForRow(at: indexPath) as? ArtworkCell else { return }
        UIView.animate(withDuration: 0.3) {
            cell.artworkView.transform = .init(scaleX: 0.9, y: 0.9)
        }
    }

    private func tableViewCellAnimateOnUnHighlight(indexPath: IndexPath) {
        guard let cell = tblView.cellForRow(at: indexPath) as? ArtworkCell else { return }
        UIView.animate(withDuration: 0.3) {
            cell.artworkView.transform = .identity
        }
    }
}
