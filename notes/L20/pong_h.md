```
/*
 * pong.h
 * Author: Todd Branchflower
 * Date: 11 Oct 2013
 * Description: Implements a subset of the pong game
 */

#ifndef _PONG_H
#define _PONG_H

#define SCREEN_WIDTH 500
#define SCREEN_HEIGHT 500

typedef struct {
    int x;
    int y;
} vector2d_t;

typedef struct {
    vector2d_t position;
    vector2d_t velocity;
    unsigned char radius;
} ball_t;

ball_t createBall(int xPos, int yPos, int xVel, int yVel, unsigned char radius);

ball_t moveBall(ball_t ballToMove);

#endif
```
