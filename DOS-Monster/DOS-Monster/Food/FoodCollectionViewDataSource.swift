//
//  FoodCollectionViewDataSource.swift
//  DOS-Monster
//
//  Created by 김상혁 on 2022/10/04.
//

import UIKit

class FoodCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var foodCountMap: [Food: Int] = [:]
    private var foods: [Food] {
        return foodCountMap.keys.sorted { $0.satisfaction < $1.satisfaction }
    }
    
    private lazy var layoutItem: NSCollectionLayoutItem = {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1 / 2),
            heightDimension: .fractionalWidth(1 / 2)
        )
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)
        return layoutItem
    }()
    
    private lazy var layoutGroup: NSCollectionLayoutGroup = {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1 / 2)
        )
        
        let layoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: layoutSize,
            subitems: [layoutItem]
        )
        return layoutGroup
    }()
    
    private lazy var layoutSection: NSCollectionLayoutSection = {
        let sectionLayout = NSCollectionLayoutSection(group: layoutGroup)
        sectionLayout.interGroupSpacing = 10
        sectionLayout.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        return sectionLayout
    }()
    
    func append(foodCountMap: [Food: Int]) {
        self.foodCountMap = foodCountMap
    }
    
    func add(food: Food, count: Int) {
        guard let currentFoodCount = self.foodCountMap[food] else {
            foodCountMap[food] = 1
            return
        }
        foodCountMap[food] = currentFoodCount + count
    }
    
    func searchFood(at index: Int) -> Food? {
        return foods.indices ~= index ? foods[index] : nil
    }
//
//    func removeFood(at index: Int) {
//        foods.remove(at: index)
//    }
    
    func sectionProvider(_ section: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        return layoutSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodCountMap.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FoodCollectionViewCell.identifier,
            for: indexPath
        ) as? FoodCollectionViewCell else { return UICollectionViewCell() }
        
        // Cell Reuse 될 때 마다 sorted -> 비효율적
        let food = foods[indexPath.item]
        let count = foodCountMap[food] ?? 0
        let cellViewModel = FoodCollectionCellViewModel(food: food, count: count)
        cell.bind(to: cellViewModel)
        return cell
    }
}
