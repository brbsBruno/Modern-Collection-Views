//
//  MainModel.swift
//  POCCompositionalLayout
//
//  Created by Bruno Barbosa on 04/10/22.
//

import Foundation

struct MainViewModel {

    lazy var items: [Section] = {
        return generateItems()
    }()
}

enum SectionItem: Hashable {

    case video(Video)
    case article(Article)
}

class Section: Hashable {

    enum SectionType: Int, CaseIterable {

        case videos, articles
    }

    var id = UUID()
    var title: String
    var subtitle: String
    var type: SectionType
    var articles: [Article]?
    var videos: [Video]?

    init(title: String,
         subtitle: String,
         type: SectionType,
         articles: [Article]? = nil,
         videos: [Video]? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.type = type
        self.articles = articles
        self.videos = videos
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
}

struct Video: Hashable {

    let identifier = UUID()
    let title: String
    let url: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

struct Article: Hashable {

    let identifier = UUID()
    let title: String
    let date: Date
    let body: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    init(title: String, date: DateComponents, body: String) {
        self.title = title
        self.date = DateComponents(calendar: Calendar.current,
                                   year: date.year,
                                   month: date.month,
                                   day: date.day).date!
        self.body = body
    }
}

extension MainViewModel {

    func generateItems() -> [Section] {
        return [ Section(title: "Lorem ipsum dolor sit amet",
                         subtitle: "Fusce vitae iaculis ipsum",
                         type: .videos,
                         videos: [Video(title: "Mauris aliquam sodales erat, sed iaculis sem gravida nec",
                                        url: "https://"),
                                  Video(title: "Vestibulum pellentesque nisi efficitur sollicitudin ullamcorper",
                                        url: "https://")
                         ]),
                 Section(title: "Mauris ac augue non nisl accumsan maximus",
                         subtitle: "Nunc tempus pellentesque pellentesque",
                         type: .articles,
                         articles: [Article(title: "In eget luctus nibh",
                                            date: DateComponents(year: 2022, month: 1, day: 1),
                                            body: """
                                            Aenean et maximus risus, eget porttitor nisi. Duis ullamcorper efficitur dui a imperdiet. Phasellus faucibus bibendum ligula, sed feugiat turpis molestie id. Pellentesque interdum elit a est accumsan, et congue nunc commodo.
                                            """),
                                    Article(title: "Maecenas dapibus ante nisl, eu efficitur lorem eleifend eget",
                                            date: DateComponents(year: 2022, month: 2, day: 1),
                                            body: """
                                            Vivamus ac nulla ut orci bibendum posuere. Fusce lacinia ex nisi, nec rutrum risus semper nec. Cras blandit fermentum tellus sit amet accumsan. Praesent sit amet lobortis velit.
                                            """)
                         ]),
                 Section(title: "Nunc luctus egestas mi, eget maximus erat suscipit ac",
                         subtitle: "Aliquam lacinia luctus nulla ac congue",
                         type: .videos,
                         videos: [Video(title: "Phasellus a eros eget urna egestas varius ut in neque",
                                        url: "https://"),
                                  Video(title: "In in interdum leo",
                                        url: "https://"),
                                  Video(title: "Nullam vitae blandit ligula",
                                        url: "https://"),
                                  Video(title: "Maecenas bibendum nunc ut aliquam molestie",
                                        url: "https://")])
        ]
    }
}
