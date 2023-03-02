import Head from 'next/head'
import { useEffect, useState } from 'react'
import axios from 'axios'
import { Button, Input, useTheme } from 'react-daisyui'
import style from "@/styles/Home.module.css"
import AnimeRenderer from '@/components/anime-render'
import AnimeListItem from '@/components/anime-list-item'


class ListManager {
  constructor(aniList){
    this.initialList = aniList
    this.list = [aniList[0]]
    this.currentIndex = 1
    this.low = 0
    this.high = this.list.length - 1
  }


  getNextComparison() {
    const mid = Math.floor((this.low + this.high)/2)
    return [this.list[mid],this.initialList[this.currentIndex]]
  }

  resolveComparision(item){
    const mid = Math.floor((this.low + this.high)/2)
    if(mid == this.low){
      if(item == this.list[mid]) this.list.splice(mid, 0, this.initialList[this.currentIndex])
      else if(mid == this.list.length - 1) this.list.push(this.initialList[this.currentIndex])
      else this.list.splice(mid+1, 0, this.initialList[this.currentIndex])
      this.currentIndex = this.currentIndex + 1
      this.low = 0
      this.high = this.list.length - 1
    }
    else if(item == this.list[mid]) this.high = mid-1
    else this.low = mid+1
  }
}

export default function Home() {
  const [user, setUser] = useState(undefined)
  const [list, setList] = useState(undefined)
  const [left, setLeft] = useState(undefined)
  const [right, setRight] = useState(undefined)

  const onUsernameEntered = async () => {
    const newList = (await axios.post('https://graphql.anilist.co/', {query : `
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
    setList(new ListManager(newList))
    setLeft(newList[0])
    setRight(newList[1])
  }

  const onLeftPress = () => {
    list.resolveComparision(left)
    const [newLeft, newRight] = list.getNextComparison()
    setLeft(newLeft)
    setRight(newRight)
    console.log(list.list)
  }
  const onRightPress = () => {
    list.resolveComparision(right)
    const [newLeft, newRight] = list.getNextComparison()
    setLeft(newLeft)
    setRight(newRight)
    console.log(list.list)

  }

  return (
    <>
    <Head>
      <title>Anime Ranker</title>
    </Head>
    <div className={style.container}>
      <div style={{overflowY:"scroll", maxHeight:"100vh"}}>
        { list &&
        list.list.map((anime, idx)=><AnimeListItem media={anime.media} index={list.list.length - idx}/>).reverse()
        }
      </div>
      <div className={style.container}>
        {left == undefined && right ==undefined ? 
          <div>
            <Input placeholder='AniList Username' size='lg' className={style.userNameInput} onChange={(val) => {setUser(val.target.value)}}/>
            <Button color='primary' dataTheme='dark' onClick={onUsernameEntered}>Get Ani List</Button>
          </div> :
          <div style={{display: 'flex', flexDirection: 'row', justifyContent: 'space-evenly', width: '80vw'}}>
            <AnimeRenderer media={left.media} onClick={onLeftPress}/>
            <AnimeRenderer media={right.media} onClick={onRightPress}/>
          </div>
        }
      </div>
    </div>
    </>

  )
}

