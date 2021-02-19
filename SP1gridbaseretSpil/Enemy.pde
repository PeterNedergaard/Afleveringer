class Enemy {
  int enemyX, enemyY, enemySpeed, time, oldTime, healthTime;

  Enemy(int tmpEnemySpeed, int tmpEnemyX, int tmpEnemyY) {
    enemySpeed = tmpEnemySpeed;
    enemyX = tmpEnemyX;
    enemyY = tmpEnemyY;
  }

  void move() {
    time = millis();
    if (time < oldTime + enemySpeed) return; //enemy speed is based on amount of time passed since oldTime was set i.e. since last time he moved

    if (enemyX != myPlayer.playerX) {
      if (enemyX > myPlayer.playerX) {
        enemyX -= 1;
      } else {
        enemyX += 1;
      }
    }

    if (enemyY != myPlayer.playerY) {
      if (enemyY > myPlayer.playerY) {
        enemyY -= 1;
      } else {
        enemyY += 1;
      }
    }

    oldTime = time;
  }



  boolean collision() {
    if (enemyX == myPlayer.playerX && enemyY == myPlayer.playerY && time > healthTime + 100) { //The last argument is needed to balance health loss
      myPlayer.health -= 5;
      if (myPlayer.health < 1)myPlayer.health = 0;
      healthTime = time;
      return true;
    } else return false;
  }
}
