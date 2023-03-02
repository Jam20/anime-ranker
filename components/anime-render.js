import { Button, Input, useTheme } from 'react-daisyui'
import Image from 'next/image'

export default function AnimeRenderer(props){

    const displayName = props.media.title.english ? props.media.title.english : props.media.title.userPreferred
    return(
        <div style={{display: 'flex', flexDirection: 'column'}}>
            <Image src={props.media.coverImage.extraLarge} width={339} height={500}/>
            <Button style={{marginTop: "2vh"}} onClick={()=> {if(props.onClick) props.onClick()}}>{displayName}</Button>
        </div>
    )
}