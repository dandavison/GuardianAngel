options =
    "angel-hide-sport": false
    "angel-hide-hider": true


class Article

    constructor: (@el) ->
        @$el = $ @el
        wrapper = $ '<div class="angel-wrapper"></div>'
        @hider = $ '<a href="#" >X</a>'
        @$el.wrap wrapper
        @$el.before @hider

        hidden = !!Storage.get(@key())

        # Sync checkbox with stored value
        @hider.click() if hidden

        # Set event handlers
        @hider.click @toggleHideState
        @$el.find('a').mousedown (evt) =>
            Storage.set @key(), true
            $(evt.target).click()

        @render hidden

    toggleHideState: (evt) =>
        hidden = !Storage.get(@key())
        Storage.set @key(), hidden
        @render hidden
        evt.preventDefault()

    key: =>
        "angel-" + @$el.find('a').attr("href")

    render: (hidden) =>
        @$el.toggle !hidden
        @hider.toggle !hidden if options["angel-hide-hider"]


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


for article in $("li.inline-pic, li.pixie, li.mugshot, li.b3, li.wide-img, li.picture, li.l2, li.l5")
    view = new Article article

if options["angel-hide-sport"]
    console.log "hiding sport"
    $("#sport-nwf-picks").hide()
