import React, { useState } from "react";
import AnimeRenderer from "./anime-render";
import style from "../styles/Home.module.css"
import AnimeList from "./anime-list";
import { Button } from "react-daisyui";


export default function RankerScreen(props) {
    const [left, setLeft] = useState(props.list.getNextComparison()[0])
    const [right, setRight] = useState(props.list.getNextComparison()[1])

    const onSelection = (selection) => () => {
        props.list.resolveComparision(selection)
        const [newLeft, newRight] = props.list.getNextComparison()
        setLeft(newLeft)
        setRight(newRight)
    }

    const exportCurrentList = () => {
        const serializedList = props.list.serialize()
        const blob = new Blob([serializedList], { type: "application/json" });
        const href = URL.createObjectURL(blob);

        // create "a" HTLM element with href to file
        const link = document.createElement("a");
        link.href = href;
        link.download = 'list.json';
        document.body.appendChild(link);
        link.click();

        // clean up "a" element & remove ObjectURL
        document.body.removeChild(link);
        URL.revokeObjectURL(href);
    }

    return (

        <div className={style.container}>
            <AnimeList list={props.list} />
            <div style={{display:'inline-grid'}}>
                <h1 className={style.animeLeftHeader}>{props.list.initialList.length - props.list.list.length} Anime Left to Sort</h1>
                <div style={{ display: 'flex', flexDirection: 'row', justifyContent: 'space-evenly', width: '80vw' }}>
                    <AnimeRenderer media={left.media} onClick={onSelection(left)} />
                    <AnimeRenderer media={right.media} onClick={onSelection(right)} />
                </div>
            </div>
        </div>

    )
}