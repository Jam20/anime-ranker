import Head from 'next/head'
import { Inter } from '@next/font/google'
import { useEffect, useState } from 'react'
import axios from 'axios'
import { Button, Input, useTheme } from 'react-daisyui'
import style from "@/styles/Home.module.css"
import Image from 'next/image'
import AnimeRenderer from '@/components/anime-render'



export default function Home() {
  const [user, setUser] = useState(undefined)
  const [list, setList] = useState(undefined)
  const [left, setLeft] = useState(undefined)
  const [right, setRight] = useState(undefined)

  const onUsernameEntered = async () => {
    const newList = (await axios.post('https://graphql.anilist.co/', {query : `
    {
      MediaListCollection(userName: "Jam20",type: ANIME, status_in: COMPLETED) {
        lists {
          entries {
            media{
              id
              title {
                english
                userPreferred
              }
              coverImage{
                large
              }
            }
          }
        }
      }
    }
    `})).data.data.MediaListCollection.lists[0].entries
    setList(newList)
    setLeft(newList[0])
    setRight(newList[newList.length-1])
  }



  return (
    <>
    <Head>
      <title>Anime Ranker</title>
    </Head>
    <div className={style.container}>
      {left == undefined && right ==undefined ? 
        <div>
          <Input placeholder='AniList Username' size='lg' className={style.userNameInput} onChange={(val) => {setUser(val)}}/>
          <Button color='primary' dataTheme='dark' onClick={onUsernameEntered}>Get Ani List</Button>
        </div> :
        <div style={{display: 'flex', flexDirection: 'row', justifyContent: 'space-evenly', width: '100vw'}}>
          <AnimeRenderer media={left.media}/>
          <AnimeRenderer media={right.media}/>
        </div>
      }


    </div>
    </>

  )
}

