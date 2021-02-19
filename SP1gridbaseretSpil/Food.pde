class Food {
  int foodX, foodY, foodSpeed, time, oldTime;

  Food(int tmpfoodSpeed, int tmpfoodX, int tmpfoodY) {
    foodSpeed = tmpfoodSpeed;
    foodX = tmpfoodX;
    foodY = tmpfoodY;
  }



  void move() {
    time = millis();
    if (time < oldTime + foodSpeed) return; //food speed based on amount of time passed. Same idea as enemy movement

    int moveRand = (int)random(11);

    if (moveRand > 5)foodX += 1;
    else foodX -= 1;

    if (moveRand % 2 == 0)foodY +=1;
    else foodY -= 1;

    if (foodX > amountOfFields-1)foodX = amountOfFields-1;
    if (foodX < 0)foodX = 0;
    if (foodY > amountOfFields-1)foodY = amountOfFields-1;
    if (foodY < 0)foodY = 0;

    oldTime = time;
  }



  boolean collision() {
    if (foodX == myPlayer.playerX && foodY == myPlayer.playerY) {
      foodX = (int)random(1, amountOfFields);
      foodY = (int)random(1, amountOfFields);
      foodSpeed = randomSpeed();
      myPlayer.score += 5;

      return true;
    } else return false;
  }



  int randomSpawnX() {
    int spawnX;
    spawnX = (int)random(amountOfFields);

    while (spawnX < amountOfFields/3 && spawnX > amountOfFields - amountOfFields/3) {
      spawnX = (int)random(amountOfFields);
    }
    return spawnX;
  }



  int randomSpawnY() {
    int spawnY;
    spawnY = (int)random(amountOfFields);

    while (spawnY < amountOfFields/3 && spawnY > amountOfFields - amountOfFields/3) {
      spawnY = (int)random(amountOfFields);
    }
    return spawnY;
  }



  int randomSpeed() {
    return (int)random(500, 700);
  }
}
