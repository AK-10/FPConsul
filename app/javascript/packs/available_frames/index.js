const setModalContent = (available, datetime) => {
    const idName = undefined !== avilalble ? 'inactivate-frame-confirm-text' : 'activate-frame-confirm-text'
    let paragTag = document.getElementById(idName)
    console.log(paragTag)

    const performText = !available ? "有効" : "無効"

    paragTag.innerText = `${datetime}の予約枠を${performText}にしますか?`
}

const setDatetimeToTextField = datetime => {
     let textField = document.getElementById("available_frame-scheduled_time")
     textField.value = datetime
}

// const setDestroyHref = () => {
//     setHref =
// }

window.onload = () => {
    const triggerButtons = document.getElementsByClassName('available_frame-trigger-btn')

    Array.from(triggerButtons).forEach( btn => {
        btn.onclick = () => {
            console.log(btn.dataset)
            const available = btn.dataset.path !== undefined
            const datetime = btn.dataset.datetime
            setModalContent(available, datetime)
            setDatetimeToTextField(datetime)
        }
    })
}
