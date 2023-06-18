import axios from "axios";

class ListManager {
  constructor(aniList, user) {
    this.userName = user
    this.initialList = aniList
    this.list = [aniList[0]]
    this.low = 0
    this.high = this.list.length - 1
  }


  static async deserialize(object) {
    const manager = new ListManager(await requestList(object.user))
    const unserializedList = object.list.map((id) =>
      manager.initialList.find((anime) => anime.media.id == id)
    )
    manager.list = unserializedList
    manager.high = manager.list.length - 1
    return manager
  }

  serialize() {
    const listIDs = this.list.map((value) => value.media.id)
    const object = {
      user: this.userName,
      list: listIDs
    }
    return JSON.stringify(object)
  }

  getNextComparison() {
    if (this.list.length < 2) return [this.initialList[0], this.initialList[1]]
    const mid = Math.floor((this.low + this.high) / 2)
    return [this.list[mid], this.initialList[this.list.length]]
  }

  resolveComparision(item) {
    const mid = Math.floor((this.low + this.high) / 2)
    if (mid == this.low) {
      if (item == this.list[mid]) this.list.splice(mid, 0, this.initialList[this.list.length])
      else if (mid == this.list.length - 1) this.list.push(this.initialList[this.list.length])
      else this.list.splice(mid + 1, 0, this.initialList[this.list.length])
      this.low = 0
      this.high = this.list.length - 1
      localStorage.setItem(`${this.userName}.animeList`, this.serialize())
    }
    else if (item == this.list[mid]) this.high = mid - 1
    else this.low = mid + 1
  }
}
async function requestList(user) {
  return (await axios.post('https://graphql.anilist.co/', {
    query: `
    {
      MediaListCollection(userName: "${user}",type: ANIME, status_in: COMPLETED) {
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
    `})).data.data.MediaListCollection.lists[0].entries
}
export async function getAnimeListManager(user) {
  const storedUser = JSON.parse(localStorage.getItem(`${user}.animeList`))
  if(storedUser != null) return ListManager.deserialize(storedUser)
  return new ListManager(await requestList(user), user)
}


