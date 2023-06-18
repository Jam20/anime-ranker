import React from 'react';
import ReactDOM from 'react-dom';
import { useEffect, useState } from 'react'
import axios from 'axios'
import { Button, Input, useTheme } from 'react-daisyui'
import style from "./styles/Home.module.css"
import globalStyle from './styles/globals.css'
import { getAnimeListManager } from './data-access/anilist';
import AnimeRenderer from './components/anime-render'
import AnimeListItem from './components/anime-list-item'


export default function Home() {
  const [user, setUser] = useState(undefined)
  const [list, setList] = useState(undefined)
  const [left, setLeft] = useState(undefined)
  const [right, setRight] = useState(undefined)

  const onUsernameEntered = async () => {
    const newList = await getAnimeListManager(user)
    setList(newList)
    setLeft(newList.initialList[0])
    setRight(newList.initialList[1])
  }

  const onSelection = (selection) => () => {
    list.resolveComparision(selection)
    const [newLeft, newRight] = list.getNextComparison()
    setLeft(newLeft)
    setRight(newRight)
    console.log(list.list)
  }

  return (
    <div className={style.container}>
      <div style={{overflowY:"scroll", maxHeight:"100vh"}}>
        { list &&
        list.list.map((anime, idx)=><AnimeListItem media={anime.media} index={list.list.length - idx}/>).reverse()
        }
      </div>
      <div className={style.container}>
        {left == undefined || right == undefined ? 
          <div>
            <Input placeholder='AniList Username' size='lg' className={style.userNameInput} onChange={(val) => {setUser(val.target.value)}}/>
            <Button color='primary' dataTheme='dark' onClick={onUsernameEntered}>Get Ani List</Button>
          </div> :
          <div style={{display: 'flex', flexDirection: 'row', justifyContent: 'space-evenly', width: '80vw'}}>
            <AnimeRenderer media={left.media} onClick={onSelection(left)}/>
            <AnimeRenderer media={right.media} onClick={onSelection(right)}/>
          </div>
        }
      </div>
    </div>
  )
}

ReactDOM.render(
  <Home/>,
document.getElementById('root')
);
