options = [
    ["hide-sport", "angel-hide-sport"],
    ["allow-unhiding", "angel-allow-unhiding"]
]

saveOptions = ->
    for [id, key] in options
        select = document.getElementById(id)
        setting = select.children[select.selectedIndex].value
        localStorage[key] = setting

    status = document.getElementById("status")
    status.innerHTML = "Options Saved."
    setTimeout(
        -> status.innerHTML = ""
        750
    )

restoreOptions = ->
    for [id, key] in options
        setting = localStorage[key]
        continue if not setting
        select = document.getElementById(id)
        for child in select.children
            if child.value == settings
                child.selected = "true"
                break

document.addEventListener 'DOMContentLoaded', restoreOptions
document.querySelector('#save').addEventListener 'click', saveOptions
