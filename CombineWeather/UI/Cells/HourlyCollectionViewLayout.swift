//
//  HourlyCollectionViewLayout.swift
//  CombineWeather
//
//  Created by Durbalo, Andrii on 04.01.2021.
//

import Foundation
import UIKit

class HourlyCollectionViewLayout: UICollectionViewLayout {

    //MARK: - properties

    private var cache: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat = 0

    var itemHeight: CGFloat {
        return collectionView?.frame.size.height ?? 0
    }

    var itemWidth: CGFloat = 100 {
        didSet {
            invalidateLayout()
        }
    }

    //MARK: - override

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {

        super.prepare()

        configureBaseLayout()
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.values.filter { return $0.frame.intersects(rect) }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath]
    }

    //MARK: - private

    private func configureBaseLayout() {

        guard let collectionView = collectionView else {
            return
        }

        cache.removeAll()

        var yOffset: CGFloat = 0

        for section in 0 ..< collectionView.numberOfSections {

            var xOffset: CGFloat = 0

            for item in 0 ..< collectionView.numberOfItems(inSection: section) {

                let indexPath = IndexPath(item: item, section: section)
                let frame = CGRect(x: xOffset, y: yOffset, width: itemWidth, height: itemHeight)

                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame

                cache[indexPath] = attributes
                contentHeight = frame.maxY
                contentWidth = frame.maxX
                xOffset += itemWidth
            }

            yOffset += itemHeight
        }
    }
}
