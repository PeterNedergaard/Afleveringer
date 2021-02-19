class Player {
  int playerX, playerY, playerSpeed;
  int timer, oldTimer;
  int score = 0, health = 100;

  boolean enemyOnPlayer, playerOnFood, death;
  boolean moveUp, moveDown, moveLeft, moveRight;

  Player(int tempPlayerX, int tempPlayerY, int tempPlayerSpeed) {
    playerX = tempPlayerX;
    playerY = tempPlayerY;
    playerSpeed = tempPlayerSpeed;
  }

  void playerMove() {
    timer = millis();
    if (timer < oldTimer + playerSpeed)return;
    
    //I do this instead of using keyPressed(), because keyPressed() acts weird when trying to hold down one of the arrow keys,
    //where this method makes the player move smoothly.
    
    if (keyCode == UP)moveUp = true;
    else moveUp = false;
    if (moveUp == true)playerY -= 1;

    if (keyCode == DOWN)moveDown = true;
    else moveDown = false;
    if (moveDown == true)playerY += 1;

    if (keyCode == LEFT)moveLeft = true;
    else moveLeft = false;
    if (moveLeft == true)playerX -= 1;

    if (keyCode == RIGHT)moveRight = true;
    else moveRight = false;
    if (moveRight == true)playerX += 1;

    if (playerY < 0)playerY = 0;
    if (playerY > amountOfFields-1)playerY = amountOfFields-1;
    if (playerX > amountOfFields-1)playerX = amountOfFields-1;
    if (playerX < 0)playerX = 0;

    oldTimer = timer;
  }



  void gameOver() {
    if (health < 1) {
      rectMode(CENTER);
      fill(0);
      rect(width/2, height/2, 700, 250);
      textAlign(CENTER);
      textSize(100);
      fill(255);
      text("GAME OVER", width/2, height/2);
      textSize(25);
      text("PRESS |ENTER| TO TRY AGAIN", width/2, height/2+50);
      textSize(20);
      text("YOUR SCORE: " + score, width/2, height/2+100);

      if (keyPressed) {
        if (key != ENTER)return;
        initEnemy();
        initFood();
        health = 100;
        score = 0;
        playerX = amountOfFields/2;
        playerY = amountOfFields/2;
      }
    }
  }
}
