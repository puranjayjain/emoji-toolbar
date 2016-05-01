EmojiToolbarView = require './emoji-toolbar-view'

{CompositeDisposable} = require 'atom'

module.exports = EmojiToolbar =
  # event subscriptions disposable
  subscriptions: null

  # elements
  footerPanel: null
  emojiToolbarView: null

  activate: (state) ->
    @emojiToolbarView = new EmojiToolbarView state.emojiToolbarViewState
    @footerPanel = atom.workspace.addFooterPanel item: @emojiToolbarView.getElement()

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'emoji-toolbar:toggle': => @toggle()

  deactivate: ->
    @footerPanel.destroy()
    @subscriptions.dispose()
    @emojiToolbarView.destroy()

  serialize: ->
    emojiToolbarViewState: @emojiToolbarView.serialize()

  toggle: ->
    if @footerPanel.isVisible()
      @footerPanel.hide()
    else
      @footerPanel.show()
