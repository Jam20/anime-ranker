import { Button, Input, useTheme } from 'react-daisyui'
import Image from 'next/image'

export default function AnimeRenderer(props){

    return(
        <div style={{display: 'flex', flexDirection: 'column'}}>
            <Image src={props.media.coverImage.large} width={256} height={512}/>
            <Button>{props.media.title.english}</Button>
        </div>
    )
}