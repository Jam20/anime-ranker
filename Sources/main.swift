import Vapor
import Html
import HtmlVaporSupport


let app = Application()
private var fileUserStorage: FileUserStorage? = nil
if let fileLocation = ProcessInfo.processInfo.environment["USER_STORAGE"] {
    let url = URL(fileURLWithPath: fileLocation)
    if !FileManager.default.fileExists(atPath: fileLocation) {
        FileManager.default.createFile(atPath: fileLocation, contents: nil)
    }
    let fileStorage = FileStorage(fileLocation: url)
    fileUserStorage = try FileUserStorage(fileStorage)
    print("Using file storage at: \(fileLocation)")
}


private var fileAnimeStorage: FileAnimeStorage? = nil
if let fileLocation = ProcessInfo.processInfo.environment["ANIME_STORAGE"] {
    let url = URL(fileURLWithPath: fileLocation)
    if !FileManager.default.fileExists(atPath: fileLocation) {
        FileManager.default.createFile(atPath: fileLocation, contents: nil)
    }
    let fileStorage = FileStorage(fileLocation: url)

    fileAnimeStorage = try FileAnimeStorage(fileStorage)
    print("Using anime storage at: \(fileLocation)")
}

let userStorage: UserStorage = fileUserStorage ?? MemoryUserStorage()
let animeStorage: AnimeStorage = fileAnimeStorage ?? MemoryAnimeStorage()


app.get(use: index)
app.get("users", use: getUser)
app.post("users", use: postUser)
try app.run()
