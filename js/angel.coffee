class Article extends Backbone.View

    initialize: =>
        @$el.prepend '<input class="angel-hider" type="checkbox"/>'
        @listenTo @model, "change", @render
        @model.set "hidden", !!localStorage[@key()]

    events:
        "click .angel-hider": "toggleHideState"

    toggleHideState: =>
        val = !@model.get("hidden")
        @model.set "hidden", val
        localStorage[@key()] = val

    key: =>
        @$('a')[0].href

    render: =>
        @$el.toggle !@model.get("hidden")


for article in $("li.inline-pic")
    view = new Article
        el: article
        model: new Backbone.Model
