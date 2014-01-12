for key in ["angel-hide-hider", "angel-hide-sport"]
    chrome.storage.sync.get(
        key
        (obj) -> console.log key, obj
    )


class Article extends Backbone.View

    initialize: =>
        # console.log @el
        wrapper = $ '<div class="angel-wrapper"></div>'
        @hider = $ '<a href="#" >X</a>'
        @$el.wrap wrapper
        @$el.before @hider

        hidden = !!Storage.get(@key())

        # Sync checkbox with stored value
        @hider.click() if hidden

        @hider.click @toggleHideState
        @render hidden

    toggleHideState: =>
        hidden = !Storage.get(@key())
        Storage.set @key(), hidden
        console.log "toggleHideState #{ @key() } -> #{ hidden }"
        @render hidden

    key: =>
        "angel-" + @$('a')[0].href

    render: (hidden) =>
        @$el.toggle !hidden
        chrome.storage.sync.get(
            "angel-hide-hider"
            (obj) -> @hider.toggle !hidden if obj["angel-hide-hider"]
        )

Storage =
    set: (key, value) ->
        # If localStorage is full, clear it and try again.
        try
            localStorage.setItem(key, value)
        catch error
            if error.name == 'QUOTA_EXCEEDED_ERR'
                localStorage.clear()
                localStorage.setItem(key, value)
            else
                throw error

    get: (key) ->
        value = localStorage.getItem(key)
        if value == 'true'
            return true
        else if value == 'false'
            return false
        else
            return value

    remove: (key) ->
        localStorage.removeItem(key)


for article in $("li.inline-pic, li.pixie, li.mugshot")
    view = new Article
        el: article

chrome.storage.sync.get(
    "angel-hide-sport"
    (obj) -> $("#sport-nwf-picks").hide() if obj["angel-hide-sport"]
)
