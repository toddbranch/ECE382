# L20 Assignment - Pong

## Pong in C

Write a C program that implements a subset of the functionality of the video "pong" game.

- Define the height/width of the screen as constants.
- Create a structure that contains the ball's parameters (x/y position, x/y velocity, radius).  Note: you may want to use more than one structure (i.e. nested structures) to do this.
- Make a function that creates a ball based on parameters passed into it.
- Make another function that updates the position of the ball (input is a ball structure, output is the updated ball structure).
    - This function must handle the "bouncing" of the ball when it hits the edges of the screen.
    - When it hits an edge, you flip the sign on the x or y velocity to make the ball move a different direction.
    - This function should call four other "collision detection" functions; one for each of the screen edges.
    - The "collision detection" functions return a `char` (1 for true, 0 for false - `#define` these values) to indicate whether or not there is a collision.
- You must create three separate files: header, implementation, and your `main.c`.

## Turn-In Requirements (E-mail)

- Source code files (`main.c`, header, and implementation).
- Simulator screenshots.
- Answers to the following questions:
    - How did you verify your code functions correctly?
    - How could you make the "collision detection" helper functions only visible to your implementation file (i.e. your `main.c` could not call those functions directly)?

## Hints

I don't expect you to implement an actual pong game!  The way you verify functionality should be by creating code that moves your ball and monitoring how the variables change after each move to ensure functionality.  Don't forget edge cases (i.e. when your ball hits the well, etc.)!

**[Here is my pong.h!](pong_h.html)**

### Initializing a struct

You may want to create a type of constructor function that initializes a `struct` for you.  This can be tricky, depending on the compiler you use.
```
struct vector2d {
    int x;
    int y;
};

typedef struct vector2d vector2d_t;

// This will not work in CCS!  
// You cannot do inline initialization with variables
// (i.e. {1, 2} will work, {x, y} will not work)
vector2d_t initVector(int x, int y)
{
    vector2d_t newVector = {x, y};
    
    return newVector;
}

// This will work in CCS
vector2d_t initVector(int x, int y)
{
    vector2d_t newVector; 
    newVector.x = x;
    newVector.y = y;
    
    return newVector;
}
```
