options = [
    ["hide-sport", "angel-hide-sport"],
    ["hide-hider", "angel-hide-hider"]
]

saveOptions = ->
    status = $("#status")
    for [id, key] in options
        select = document.getElementById(id)
        setting = select.children[select.selectedIndex].value
        chrome.storage.sync.set key: setting
        console.log key, "->", setting

    status.append "Options Saved."
    setTimeout(
        -> status.text ""
        5750
    )

restoreOptions = ->
    for [id, key] in options
        chrome.storage.sync.get(
            key
            (obj) ->
                setting = obj[key]
                select = document.getElementById id
                for child in select.children
                    if child.value == setting
                        child.selected = "true"
                        break
        )

document.addEventListener 'DOMContentLoaded', restoreOptions
document.querySelector('#save').addEventListener 'click', saveOptions
