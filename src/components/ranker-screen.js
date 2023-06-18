import React, { useState } from "react";
import AnimeRenderer from "./anime-render";
import style from "../styles/Home.module.css"
import AnimeList from "./anime-list";


export default function RankerScreen(props) {
    const [left, setLeft] = useState(props.list.getNextComparison()[0])
    const [right, setRight] = useState(props.list.getNextComparison()[1])

    const onSelection = (selection) => () => {
        props.list.resolveComparision(selection)
        const [newLeft, newRight] = props.list.getNextComparison()
        setLeft(newLeft)
        setRight(newRight)
    }

    return (
        <div className={style.container}>
            <AnimeList list={props.list} />
            <div style={{ display: 'flex', flexDirection: 'row', justifyContent: 'space-evenly', width: '80vw' }}>
                <AnimeRenderer media={left.media} onClick={onSelection(left)} />
                <AnimeRenderer media={right.media} onClick={onSelection(right)} />
            </div>
        </div>

    )
}