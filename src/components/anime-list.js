import React from "react";
import AnimeListItem from "./anime-list-item";
export default function AnimeList(props) {


    return (
        <div style={{ overflowY: "scroll", maxHeight: "100vh" }}>
            {props.list.list.map((anime, idx) => <AnimeListItem media={anime.media} key={props.list.list.length - idx} index={props.list.list.length - idx} />).reverse()}
        </div>
    )
}