import moment from "moment"

const setModalContent = (available, datetime) => {
    const idName = available ? 'inactivate-frame-confirm-text' : 'activate-frame-confirm-text'
    let paragTag = document.getElementById(idName)

    // example of datetime -> "2020-01-23T10:30:00.000+09:00"
    const formattedDate = moment(datetime, "YYYY-MM-DDThh:mm:ss.000+09:00").format("YYYY年MM月DD日 hh時mm分")
    const performText = !available ? "有効" : "無効"
    paragTag.innerText = `${formattedDate}の予約枠を${performText}にしますか?`
}

const setDatetimeToTextField = datetime => {
    let textField = document.getElementById("available_frame-scheduled_time")
    textField.value = datetime
}

const setDestroyHref = (path) => {
    let destroyLink = document.getElementById("destroy-frame-link")
    destroyLink.setAttribute("href", path)
}

window.onload = () => {
    const triggerButtons = document.getElementsByClassName('available_frame-trigger-btn')

    Array.from(triggerButtons).forEach( btn => {
        btn.onclick = () => {
            const available = btn.dataset.path !== undefined
            const datetime = btn.dataset.datetime
            const path = btn.dataset.path

            setModalContent(available, datetime, path)
            setDatetimeToTextField(datetime)
            if (available) {
                setDestroyHref(path)
            }
        }
    })
}
