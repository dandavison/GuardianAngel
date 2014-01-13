# For now, options are hardcoded. They should really be set in the
# options page and shared with the content script via localStorage or
# thr chrome.storage API.
options =
    "angel-hide-sport": false
    "angel-hide-hider": true


class Article
    # A hideable article

    constructor: (@el) ->
        @$el = $ @el
        wrapper = $ '<div class="angel-wrapper"></div>'
        @hider = $ '<a href="#" >X</a>'
        @$el.wrap wrapper
        @$el.before @hider

        hidden = !!Storage.get(@key())

        # Sync checkbox with stored value
        @hider.click() if hidden

        # Click on the X toggles hide state and re-renders the
        # article.
        @hider.click (evt) =>
            hidden = !Storage.get(@key())
            Storage.set @key(), hidden
            @render hidden
            evt.preventDefault()

        # Click on the article link registers the article to be hidden
        # and then visits the article.
        @$el.find('a').mousedown (evt) =>
            Storage.set @key(), true
            $(evt.target).click()

        @render hidden

    key: =>
        "angel-" + @$el.find('a').attr("href")

    render: (hidden) =>
        @$el.toggle !hidden
        @hider.toggle !hidden if options["angel-hide-hider"]


Storage =
    # A wrapper around localStorage that preserves boolean values.

    set: (key, value) ->
        localStorage.setItem(key, value)

    get: (key) ->
        value = localStorage.getItem(key)
        if value == 'true'
            return true
        else if value == 'false'
            return false
        else
            return value


for article in $("li.inline-pic, li.pixie, li.mugshot, li.b3, li.wide-img, li.picture, li.l2, li.l5")
    new Article article

if options["angel-hide-sport"]
    $("#sport-nwf-picks").hide()
