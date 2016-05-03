EmojiToolbarMainView = require './emoji-toolbar-main-view'
EmojiToolbarHeaderView = require './emoji-toolbar-header-view.coffee'

{CompositeDisposable} = require 'atom'

{$} = require 'atom-space-pen-views'

module.exports = EmojiToolbar =
  # event subscriptions disposable
  subscriptions: null

  # elements
  bottomPanel: null
  emojiToolbarMainView: null
  emojiToolbarHeaderView: null

  activate: (state) ->
    @emojiToolbarMainView = new EmojiToolbarMainView state.emojiToolbarMainViewState
    @emojiToolbarHeaderView = new EmojiToolbarHeaderView state.emojiToolbarHeaderView
    @bottomPanel = atom.workspace.addBottomPanel item: @emojiToolbarHeaderView.getElement(), visible: false
    $(@bottomPanel.getItem()).after @emojiToolbarMainView.getElement()

    # add tooltips to the views
    @emojiToolbarMainView.addTooltips()

    # add events to the views
    @emojiToolbarMainView.addEvents()
    @emojiToolbarHeaderView.addEvents()

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'emoji-toolbar:toggle': => @toggle()

  deactivate: ->
    @bottomPanel.destroy()
    @subscriptions.dispose()
    @emojiToolbarMainView.destroy()
    @emojiToolbarHeaderView.destroy()

  serialize: ->
    emojiToolbarMainViewState: @emojiToolbarMainView.serialize()
    emojiToolbarHeaderView: @emojiToolbarHeaderView.serialize()

  toggle: ->
    if @bottomPanel.isVisible()
      @bottomPanel.hide()
    else
      @bottomPanel.show()
