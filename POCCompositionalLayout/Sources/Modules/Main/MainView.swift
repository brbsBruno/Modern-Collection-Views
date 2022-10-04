//
//  MainView.swift
//  POCCompositionalLayout
//
//  Created by Bruno Barbosa on 29/09/22.
//

import UIKit

class MainView: UIView {

    // MARK: - Private properties

    private enum SectionLayoutKind: Int, CaseIterable {
        case horizontal, vertical
    }

    private var dataSource: UICollectionViewDiffableDataSource<SectionLayoutKind, Int>! = nil

    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: generateCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MainCollectionViewCell.self,
                                forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        return collectionView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViewCode()
        configureDataSource()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewCode()
        configureDataSource()
    }

    // MARK: - Private methods

    private func generateCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            guard let sectionLayoutKind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }

            switch sectionLayoutKind {
            case .horizontal: return self.generateHorizontalLayoutSection()
            case .vertical: return self.generateVerticalLayoutSection()
            }
        }
    }

    private func generateHorizontalLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2,
                                                     leading: 2,
                                                     bottom: 2,
                                                     trailing: 2)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = NSDirectionalEdgeInsets(top: 20,
                                                        leading: 20,
                                                        bottom: 20,
                                                        trailing: 20)
        return section
    }

    private func generateVerticalLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2,
                                                     leading: 2,
                                                     bottom: 2,
                                                     trailing: 2)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20,
                                                        leading: 20,
                                                        bottom: 20,
                                                        trailing: 20)
        return section
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionLayoutKind, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView,
             indexPath: IndexPath, identifier: Int) -> UICollectionViewCell in

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier,
                                                                for: indexPath) as? MainCollectionViewCell else {                return UICollectionViewCell()
            }

            cell.label.text = "\(indexPath.section), \(indexPath.item)"
            return cell
        }

        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<SectionLayoutKind, Int> {
        let itemsPerSection = 10
        var snapshot = NSDiffableDataSourceSnapshot<SectionLayoutKind, Int>()
        SectionLayoutKind.allCases.forEach {
            snapshot.appendSections([$0])
            let itemOffset = $0.rawValue * itemsPerSection
            let itemUpperbound = itemOffset + itemsPerSection
            snapshot.appendItems(Array(itemOffset..<itemUpperbound))
        }
        return snapshot
    }
}

extension MainView {

    // MARK: - View Code

    private func setupViewCode() {
        buildHierarchy()
        setupConstraints()
    }

    private func buildHierarchy() {
        addSubview(collectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

