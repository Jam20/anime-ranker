import Vapor
import Html
import HtmlVaporSupport

let app = Application()
app.get(use: index)
app.get("users", use: getUser)
app.post("users", use: postUser)
try app.run()
