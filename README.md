# Simon Game
Simon is a short term memory skill development game.The game was designed to help improve memory as well as concentration skills in a fun way. The game was also developed to make it easy to understand, yet challenging to play. The game has four led pads which display a sequence of white color for a short period of time. The player has to memorize the order of sequence and guess the sequence correctly within a time constraint.
The original version of the game has a touch sensitive pad to track the player’s response. For the online version, a game controller called the “D-pad” will be used to take the player’s input.
## Installation Guide
### Setting Up Ripes Software
Ripes is a visual computer architecture software. This software is necessary to play the Simon game. Follow the steps below to download Ripes software:
1. Click on the link below to navigate to the Ripes’s software installation download page.
https://github.com/mortbopet/Ripes/releases

2. Now, based on which system Ripes is being downloaded, click on the appropriate link to download the software. For example, Mac users click on “Ripes-v.2.2.6-mac-x86_64.zip”, Windows users click on “Ripes-v.2.2.6-win-x86_64.zip” and Linux user click on “Ripes-v.2.2.6-linux-x86_64.Appimage.”

3. Once the download is completed navigate to the ripes application on the computer and click on it.
4. This should open the Ripes environment where the game will be played.


Now that the Ripes software is successfully downloaded on the player’s computer, it is now important to set up the Simon Game.

### Setting Up Simon Game
Follow the steps below to set-up the Simon game
1. Ripes software uses assembly code to run the game. To set up the game, download the simon.s file to your local desktop.
2. Open the ripes application and navigate to the menu bar. In the menu bar, click on the files tab, this should open a list of options. Select “Load Program” from the dropdown list.
3. Now, select the File type to “source file”. After that, click “open” and navigate to the “simon.s” file saved on the desktop.
4. Select the “I/O” section of the ripes. In this section, double click on the “D-pad” and “Led Matrix” and such that it pops out of the window. Refer to image below to see how the “D-pad” and the “Led Matrix” should look after the double click.
5. Now, click on the “Editor” tab, which is located just above the “I/O” tab.

The setup for the Simon Game is now complete. Now, head to the next section to understand the rules and how to play the game?!

# HOW TO PLAY?
Now that the Ripes software is completely set-up, the game is ready to play!!
1. To start the game, click on the “>>” button. This will display a prompt in the console and ask the user to enter the number of players in the game. There is no limit on how many players can play together. For example, if a group of 10 friends are playing the game, enter 10 or if only a single player is playing the game, enter 1.
2. After entering the number of players, the console will display which player’s turn it is. For example, for the first player it will display, “It is time to play! Go ahead player 1.” It is after this, the leds on the led pad will start flashing. It is the player's responsibility to remember the sequence of flash!
3.  After all leds are flashed, the console will display a message saying, “Start Guessing!”. At this point, the player will use the D-pad to guess the sequence. The image below shows the “D-pad” button for each corresponding Led.
4. Each player will have to respond using the “D-pad” correctly. If the player inputs a wrong sequence, then all the light of all the LEDs will turn white.
5. After the player is done guessing, the next player will be prompted to guess.

# How to end the Game?
1. After all the players are done playing their respective turns, the console will display the Game summary.
2. Game summary consists of each player’s status during that particular round. Look at the image below for a sample.
3. Console will then ask the player/players if they want to continue and play another round. If the player wants to play again, enter “0”, otherwise enter any other number or alphabet.

# TROUBLESHOOTING
If the user faces any issue while setting up, make sure that all the steps were followed appropriately and in order. If unable to resolve the issue, try uninstalling Ripes and restarting the Installation steps. Also, refer to ripes official GitHub webpage if the problem still persists. https://github.com/mortbopet/Ripes.
