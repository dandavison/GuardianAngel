class Article extends Backbone.View

    initialize: =>
        @$el.prepend '<input class="angel-hider" type="checkbox"/>'
        @render()

    events:
        "click .angel-hider": "toggleHideState"

    toggleHideState: =>
        localStorage[@key()] = !localStorage[@key()]
        @render()

    key: =>
        @$('a')[0].href

    render: =>
        @$el.toggle !localStorage[@key()]


for article in $("li.inline-pic")
    view = new Article
        el: article
