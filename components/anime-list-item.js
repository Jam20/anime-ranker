import { Button, Input, useTheme } from 'react-daisyui'
import Image from 'next/image'

export default function AnimeListItem(props){

    const displayName = props.media.title.english ? props.media.title.english : props.media.title.userPreferred
    return(
        <div style={{display: 'flex', paddingLeft:"16px", flexDirection: 'row'}}>
            <h2 style={{width:"3vw"}} >{props.index}</h2>
            <div style={{display: 'flex', flexDirection: 'column',paddingLeft:"8px", paddingRight:"8px",borderRight:'5px solid #333333', width:'15vw'}}>
                <Image src={props.media.coverImage.extraLarge} width={51} height={75}/>
                <h3>{displayName}</h3>
            </div>
        </div>

    )
}