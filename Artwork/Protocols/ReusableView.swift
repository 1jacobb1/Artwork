//
//  ReusableView.swift
//  Artwork
//
//  Created by Jacob on 2/23/22.
//

import UIKit

// https://medium.com
// /@gonzalezreal
// /ios-cell-registration-reusing-with-swift-protocol-extensions-and-generics-c5ac4fb5b75e
// https://medium.com/@gonzalezreal/ios-cell-registration-reusing-with-swift-protocol-extensions-and-generics
protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Dequeue failed: \(T.defaultReuseIdentifier)!")
        }
        return cell
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Dequeue failed: \(T.defaultReuseIdentifier)!")
        }
        return cell
    }

    func register<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>()
    -> T where T: ReusableView {
        guard let sectionView = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier)
                as? T else {
                    fatalError("Dequeue failed: \(T.defaultReuseIdentifier)!")
                }
        return sectionView
    }
}

