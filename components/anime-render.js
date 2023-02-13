import { Button, Input, useTheme } from 'react-daisyui'
import Image from 'next/image'

export default function AnimeRenderer(props){


    return(
        <div style={{display: 'flex', flexDirection: 'column'}}>
            <Image src={props.media.coverImage.extraLarge} width={339} height={500}/>
            <Button style={{marginTop: "2vh"}} onClick={()=> {if(props.onClick) props.onClick()}}>{props.media.title.english}</Button>
        </div>
    )
}