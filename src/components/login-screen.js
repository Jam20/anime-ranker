import React, { useState } from 'react'
import { Button, Input } from 'react-daisyui'
import style from "../styles/Home.module.css"

export default function LoginScreen(props) {
    const [user, setUser] = useState(undefined)

    const onSubmit = () => {
        if (props.onSubmit) props.onSubmit(user)
    }

    return (
        <div className={style.loginPage}>
            <h1>Anime Ranker Utility</h1>
            <div>
                <Input placeholder='AniList Username' size='lg' className={style.userNameInput} onChange={(val) => { setUser(val.target.value) }} />
                <Button color='primary' dataTheme='dark' onClick={onSubmit}>Get Ani List</Button>
            </div>
        </div>
    )
}
