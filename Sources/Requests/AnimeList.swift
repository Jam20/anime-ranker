//
//  File.swift
//  
//
//  Created by James Brouckman on 8/14/23.
//

import Foundation


func retrieveAnimeList(_ username: String) async throws -> [Anime] {
    let url = URL(string: "https://graphql.anilist.co/")!
   
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = try JSONEncoder().encode(AnilistQuery(username: username))
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let (data, _) = try await URLSession.shared.data(for: request)
    let result = try JSONDecoder().decode(QueryResult.self, from: data)
    
    return result.data.MediaListCollection.lists[0].entries.map { raw in
        let title = raw.media.title.english ?? raw.media.title.userPreferred
        return Anime(id: raw.media.id, title: title, imageURL: raw.media.coverImage.extraLarge)
    }
}

private struct QueryResult: Codable {
    let data: rawData
    struct rawData: Codable {
        let MediaListCollection: rawMediaListCollection
        struct rawMediaListCollection: Codable {
            let lists: [rawAniList]
            struct rawAniList: Codable {
                let entries: [rawAniListEntry]
                struct rawAniListEntry: Codable {
                   let media: rawAnime
               }
           }
       }
    }
}

private struct rawAnime: Codable {
    struct Title: Codable {
        let english: String?
        let userPreferred: String
    }
    struct AniListImage: Codable {
        let extraLarge: URL
    }
    let id: Int
    let title: Title
    let coverImage: AniListImage
}

private struct AnilistQuery: Codable {
    let query: String
    init(username: String) {
        self.query = """
            {
                MediaListCollection(userName: "\(username)", type: ANIME, status_in: COMPLETED) {
                lists {
                    entries {
                    media{
                        id
                        title {
                        english
                        userPreferred
                        }
                        coverImage{
                        extraLarge
                        }
                    }
                    }
                }
                }
            }
        """
    }
}
