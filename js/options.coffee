options = [
    ["hide-sport", "angel-hide-sport"],
    ["hide-hider", "angel-hide-hider"]
]

saveOptions = ->
    status = $("#status")
    for [id, key] in options
        select = document.getElementById(id)
        setting = select.children[select.selectedIndex].value
        chrome.storage.local.set
            key: setting
            do (key, setting) -> ->
                chrome.extension.sendRequest({action: 'reload'});
                console.log "#{ key } -> #{ setting }"
                if chrome.runtime.lastError
                    console.log "ERROR: " + chrome.runtime.lastError
                chrome.storage.local.get(
                    key
                    do (key) -> (obj) ->
                        console.log "after set: #{ key } -> #{ obj[key] }"
                )

    status.append "Options Saved."
    setTimeout(
        -> status.text ""
        1750
    )

restoreOptions = ->
    for [id, key] in options
        chrome.storage.local.get(
            key
            do (id, key) -> (obj) ->
                setting = obj[key]
                select = document.getElementById id
                console.log "restore: #{ key } -> #{ setting }"
                for child in select.children
                    if child.value == setting
                        child.selected = "true"
                        break
        )

window.restoreOptions = restoreOptions

document.addEventListener 'DOMContentLoaded', restoreOptions
document.querySelector('#save').addEventListener 'click', saveOptions
