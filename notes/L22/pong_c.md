```
 * pong.c
 *
 * Implementation of pong.h
 */

#include "pong.h"

ball_t createBall(int xPos, int yPos, int xVel, int yVel, unsigned char radius)
{
    vector2d_t position = {xPos, yPos};
    vector2d_t velocity = {xVel, yVel};

    ball_t newBall = {position, velocity, radius};

    return newBall;
}

ball_t didBallHitLeftOrRight(ball_t ballToTest);
ball_t didBallHitTopOrBottom(ball_t ballToTest);


ball_t moveBall(ball_t ballToMove)
{
    ballToMove.position.x += ballToMove.velocity.x;
    ballToMove.position.y += ballToMove.velocity.y;

    ballToMove = didBallHitLeftOrRight(ballToMove);
    ballToMove = didBallHitTopOrBottom(ballToMove);

    return ballToMove;
}

ball_t didBallHitLeftOrRight(ball_t ballToTest)
{
    if (ballToTest.position.x - ballToTest.radius < 0)
    {
        ballToTest.position.x = (-ballToTest.position.x + 2*ballToTest.radius);
        ballToTest.velocity.x = -ballToTest.velocity.x;
    }
    else if (ballToTest.position.x + ballToTest.radius > SCREEN_WIDTH)
    {
        ballToTest.position.x = (2*SCREEN_WIDTH - ballToTest.position.x - 2*ballToTest.radius);
        ballToTest.velocity.x = -ballToTest.velocity.x;
    }

    return ballToTest;
}

ball_t didBallHitTopOrBottom(ball_t ballToTest)
{
    if (ballToTest.position.y - ballToTest.radius < 0)
    {
        ballToTest.position.y = (-ballToTest.position.y + 2*ballToTest.radius);
        ballToTest.velocity.y = -ballToTest.velocity.y;
    }
    else if (ballToTest.position.y + ballToTest.radius > SCREEN_HEIGHT)
    {
        ballToTest.position.y = (2*SCREEN_HEIGHT - ballToTest.position.y - 2*ballToTest.radius);
        ballToTest.velocity.y = -ballToTest.velocity.y;
    }

    return ballToTest;
}
```
