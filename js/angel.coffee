class Article extends Backbone.View

    initialize: =>
        wrapper = $ '<div class="angel-wrapper"></div>'
        hider = $ '<input class="angel-hider" type="checkbox"/>'
        @$el.wrap wrapper
        @$el.before hider

        # Sync checkbox with stored value
        if !!Storage.get(@key())
            hider.click()

        hider.click @toggleHideState
        @render()

    toggleHideState: =>
        Storage.set @key(), !Storage.get(@key())
        console.log "toggleHideState #{ @key() } -> #{ Storage.get(@key()) }"
        @render()

    key: =>
        "angel-" + @$('a')[0].href

    render: =>
        @$el.toggle !Storage.get(@key())



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
