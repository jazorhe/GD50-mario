# GD50-mario


## Overview


## Lecture Notes


### tiles0


### tiles1


### character 1


### character 2


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
