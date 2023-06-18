import React, { useEffect } from 'react';
import {createRoot} from 'react-dom/client'
import { useState } from 'react'
import { getAnimeListManager } from './data-access/anilist';
import AnimeRenderer from './components/anime-render'
import AnimeListItem from './components/anime-list-item'
import LoginScreen from './components/login-screen'
import style from "./styles/Home.module.css"
import './styles/globals.css'
import AnimeList from './components/anime-list';
import RankerScreen from './components/ranker-screen';


export default function Home() {
  const [list, setList] = useState(undefined)

  const onUsernameEntered = async (user) => {
    const newList = await getAnimeListManager(user)
    setList(newList)
  }

  const screen = list == undefined ? <LoginScreen onSubmit={onUsernameEntered} /> : <RankerScreen list={list} />
  return (
    <div className={style.container}>
        {screen}
    </div>
  )
}

const container = document.getElementById('root');
const root = createRoot(container); // createRoot(container!) if you use TypeScript
root.render(<Home/>);


