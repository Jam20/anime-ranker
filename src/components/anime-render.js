import React from 'react'
import { Button } from 'react-daisyui'

export default function AnimeRenderer(props){

    const displayName = props.media.title.english ? props.media.title.english : props.media.title.userPreferred
    return(
        <div style={{display: 'flex', flexDirection: 'column'}}>
            <img src={props.media.coverImage.extraLarge} width={339} height={500}/>
            <Button style={{marginTop: "2vh"}} onClick={()=> {if(props.onClick) props.onClick()}}>{displayName}</Button>
        </div>
    )
}