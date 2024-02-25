# Anki Automation Scripts
This is a set of scripts to automate (some of) the painful processes in managing an Anki deck.


## Automate Hidden Cloze Rendering
If you use some form of automation such as [Obsidian to Anki](https://github.com/ObsidianToAnki/Obsidian_to_Anki) to create [Cloze (Hide All)](https://ankiweb.net/shared/info/1709973686) cards, you might notice that the cloze cards are only hidden once you manually render the card (press E + Escape) when reviewing the cards.

This script automates the process of rendering the cloze cards by simulating keyboard input, so that you don't have to manually render them.

Dependencies: Linux, `Xdotool` (and therefore `X11`)
