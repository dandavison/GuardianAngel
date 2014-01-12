options = [
    ["hide-sport", "angel-hide-sport"],
    ["hide-hider", "angel-hide-hider"]
]

saveOptions = ->
    status = $("#status")
    for [id, key] in options
        select = document.getElementById(id)
        setting = select.children[select.selectedIndex].value
        status.append "#{ key }: #{ localStorage[key] } -> "
        localStorage[key] = setting
        status.append "#{ localStorage[key] } <br>"


#    status = document.getElementById("status")
    status.append "Options Saved."
    setTimeout(
        -> status[0].innerHTML = ""
        5750
    )

restoreOptions = ->
    for [id, key] in options
        setting = String localStorage[key]
        select = document.getElementById id
        for child in select.children
            if child.value == setting
                child.selected = "true"
                break

document.addEventListener 'DOMContentLoaded', restoreOptions
document.querySelector('#save').addEventListener 'click', saveOptions
