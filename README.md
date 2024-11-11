Wrote a dead-simple TTS screen reader script for Linux desktops because I couldn't find a good one.
Has two required dependencies: eSpeak for the TTS engine itself, and xsel for the text highlighting functionality.

Use it by setting up a custom keybind to run the script (e.g. for Cinnamon desktops copy and paste: bash -c "[directory of the script]/ttsreader-v2.sh" into a custom keyboard shortcut via the Keyboard app), and then highlighting text and pressing the keybind to read the highlighted text.
You can set custom eSpeak parameters in the ttsreader_args.txt file that the script creates in the home directory on first use.
For help with eSpeak arguments, type espeak --help or espeak -h in the terminal and it will give you a list of arguments you can use.
The version of ttsreader_args.txt the script generates by default already has some parameters set that you can modify however you'd like.

If you get a terminal pop-up telling you you're missing dependencies, please install those. They're both very small packages and are required for the script to function.
I have ensured all of the code is human readable and fully commented. Good luck! :D
