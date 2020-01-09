const setModalContent = (isAvailable, datetime) => {
    let paragTag = document.getElementById('available_frame-request-confirm-text')
    const performText = isAvailable ? "有効" : "無効"
    paragTag.innerText = `${datetime}の予約枠を${performText}にしますか?`
}

const setDatetimeToTextField = (datetime) => {
     let textField = document.getElementById("available_frame-scheduled_time")
     textField.value = datetime
}

const triggerButtons = document.getElementsByClassName('available_frame-trigger-button')

triggerButtons.forEach( btn => {
    btn.onclck = () => {
        const isAvailable = btn.dataset.is_available
        const datetime = btn.dataset.datetime
        setModalContent(isAvailable, datetime)
        setDatetimeToTextField(datetime)
    }
})
