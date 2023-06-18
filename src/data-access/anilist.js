import axios from "axios";

class ListManager {
  constructor(aniList) {
    this.initialList = aniList
    this.list = [aniList[0]]
    this.currentIndex = 1
    this.low = 0
    this.high = this.list.length - 1
  }


  getNextComparison() {
    if(this.list.length < 2) return [this.initialList[0],this.initialList[1]]
    const mid = Math.floor((this.low + this.high) / 2)
    return [this.list[mid], this.initialList[this.currentIndex]]
  }

  resolveComparision(item) {
    const mid = Math.floor((this.low + this.high) / 2)
    if (mid == this.low) {
      if (item == this.list[mid]) this.list.splice(mid, 0, this.initialList[this.currentIndex])
      else if (mid == this.list.length - 1) this.list.push(this.initialList[this.currentIndex])
      else this.list.splice(mid + 1, 0, this.initialList[this.currentIndex])
      this.currentIndex = this.currentIndex + 1
      this.low = 0
      this.high = this.list.length - 1
    }
    else if (item == this.list[mid]) this.high = mid - 1
    else this.low = mid + 1
  }
}

export async function getAnimeListManager(user) {

  return new ListManager((await axios.post('https://graphql.anilist.co/', {
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
    `})).data.data.MediaListCollection.lists[0].entries)
}
