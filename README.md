# FlappyBird
University project CSC258 (Computer Organization) - flappy bird in assembly. This project was made with Stepan Khytushko.


## Index
   - [Demo](#Demo "Goto Demo")
   - [Game Features](#Game-Features "Goto Game-Features")
   - [Instalation](#Instalation "Goto Instalation")
   - [Controls](#Controls "Goto Controls")
   - [To-Do and Issues](#To-Do-and-Issues "Goto ToDo-and-Issues")

## Demo

https://user-images.githubusercontent.com/38252337/188291381-6f47898f-d900-4b63-8144-129b8f7f9d30.mp4

## Game Features

- The bird and obstacle objects are properly drawn (statically) on the screen
- The movement controls of the bird and obstacles (by the keyboard and timers) are properly implemented
- A basic version of the game (similar to the one shown in the video demo above) is properly implemented.
- More realistic physics
- Score
- Level

## Instalation
1. Install Mars 4.5 (http://courses.missouristate.edu/KenVollmar/MARS/download.html)
2. Add flappybird.c to Mars 
3. Add display 0x10008000 ($gp) with 256x256
4. Add keayboard
5. Press "Assemble", then "Run"

## Controls

There is only one button, which is active - f/F. Make sure that focused window is keayboard input. Press f/F, when you want to jump.

## To-Do and Issues

[x] On some operation systems there are no score and no restart button.