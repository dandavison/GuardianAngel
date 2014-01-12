class Article extends Backbone.View

    initialize: =>
        @$el.prepend '<input class="angel-hider" type="checkbox"/>'
        @listenTo @model, "change", @render

    events:
        "click .angel-hider": "toggleHideState"

    toggleHideState: =>
        @model.set "hidden", !@model.get("hidden")

    render: =>
        @$el.toggle !@model.get("hidden")


for article in $("li.inline-pic")
    view = new Article
        el: article
        model: new Backbone.Model
            hidden: false
