# GD50-mario
This part of the course we have already been through in CS50 assignment. However, the overall structure of the game components can be done in a better way. This is basically an advanced version of what we have achieved.

<img src="img/title.png" width="700">


## Overview
**Topics:**
-   Tile Maps
-   2D Animation
-   Procedural Level Generation
-   Platformer Physics
-   Basic AI
-   Powerups

**Our Goal**

<img src="img/our-goal.png" width="700">


## Initial CS50 Notes:


## GD50 Lecture Notes

### tiles0: "Static Tiles"


-   Sprite Sheet with Ground and Sky
-   Loop x and y, with table in table in table
-   Set ground height
-   Draw Sprites


### tiles1: "Scrolling Tiles"
-   Camera Control

    ```lua
    love.graphics.translate(x, y)
    ```

### character 0: "The Stationary Hero"


### character 1: "The Moving Hero"


### character 2: "The Tracked Hero"


### character 3


### character 4


### level0


### level1


### level2



## Assignment
### Objectives
-   [ ] Read and understand all of the Super Mario Bros. source code from Lecture 4.
-   [ ] Program it such that when the player is dropped into the level, they’re always done so above solid ground.
-   [ ] In LevelMaker.lua, generate a random-colored key and lock block (taken from keys_and_locks.png in the graphics folder of the distro). The key should unlock the block when the player collides with it, triggering the block to disappear.
-   [ ] Once the lock has disappeared, trigger a goal post to spawn at the end of the level. Goal posts can be found in flags.png; feel free to use whichever one you’d like! Note that the flag and the pole are separated, so you’ll have to spawn a GameObject for each segment of the flag and one for the flag itself.
-   [ ] When the player touches this goal post, we should regenerate the level, spawn the player at the beginning of it again (this can all be done via just reloading PlayState), and make it a little longer than it was before. You’ll need to introduce params to the PlayState:enter function that keeps track of the current level and persists the player’s score for this to work properly.



## Submission


## Useful Links
-   [LÖVE2d](https://love2d.org/wiki/love)
-   [Push Module for Lua](https://github.com/Ulydev/push)
-   [Lua Knife](https://github.com/airstruck/knife)
-   [GitHub: Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
-   [Embed youtube to markdown, GitLab, GitHub](http://embedyoutube.org/)
