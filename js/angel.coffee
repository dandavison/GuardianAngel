class Article extends Backbone.View

    initialize: =>
        hider = $ '<input class="angel-hider" type="checkbox"/>'
        @$el.before hider
        hider.click @toggleHideState
        @render()

    toggleHideState: =>
        localStorage[@key()] = !localStorage[@key()]
        @render()

    key: =>
        "angel-" + @$('a')[0].href

    render: =>
        @$el.toggle !localStorage[@key()]


for article in $("li.inline-pic, li.pixie")
    console.log article
    view = new Article
        el: article
