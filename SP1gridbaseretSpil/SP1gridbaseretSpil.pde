/*

 Controls: press the arrow buttons in the direction you want to move. You dont need to hold down the button.
 
 I decided to make food movement random, since all the food ends up in the corners, when programmed to run away from the player,
 and i found out that when the movement is random, it can actually be rather difficult to catch it.
 
 */


int sizeOfSketch = 801; //This is required, since i need the size of the sketch before the size is specified in setup

int amountOfFields = 40, fieldWidth = sizeOfSketch/amountOfFields;
int[][] fields = new int[amountOfFields][amountOfFields];

Enemy[] enemies = new Enemy[10];
Food[] food = new Food[5];
Player myPlayer = new Player(amountOfFields/2, amountOfFields/2, 100);
Food myFood = new Food(1, 1, 1); //Cant use randomSpawnX and randomSpawnY if i dont do this.


void setup() {
  size(801, 801);
  initEnemy();
  initFood();
}


void draw() {
  drawBoard();
  myPlayer.gameOver();
  displayText();
  if (myPlayer.health < 1)return;
  moveEnemies();
  moveFood();
  myPlayer.playerMove();
  collisionCheck();
}



void drawBoard() {
  fill(150);
  for (int i = 0; i < fields.length; i++) {
    for (int j = 0; j < fields[0].length; j++) {

      if (j == myPlayer.playerX && i == myPlayer.playerY) fill(fieldRole(1));

      for (int k = 0; k < enemies.length; k++) {
        if (j == enemies[k].enemyX && i == enemies[k].enemyY) fill(fieldRole(0));
      }

      for (int l = 0; l < food.length; l++) {
        if (j == food[l].foodX && i == food[l].foodY) fill(fieldRole(2));
      }

      rectMode(CORNER);
      square(j*fieldWidth, i*fieldWidth, fieldWidth);

      fill(150);
    }
  }
}



void collisionCheck() {
  for (int i = 0; i < enemies.length; i++) {
    enemies[i].collision();
  }
  for (int i = 0; i < food.length; i++) {
    food[i].collision();
  }
}



void moveEnemies() {
  for (int i = 0; i < enemies.length; i++) {
    int prevX = enemies[i].enemyX;
    int prevY = enemies[i].enemyY;

    enemies[i].move();

    for (int j = 0; j < enemies.length; j++) {
      if (j == i && j < enemies.length-1) j++;

      if (enemies[i].enemyX == enemies[j].enemyX && enemies[i].enemyY == enemies[j].enemyY && j != i) { //Makes sure that enemies collide
        enemies[i].enemyX = prevX;
        enemies[i].enemyY = prevY;
      }
    }
  }
}



void initEnemy() {
  for (int i = 0; i < enemies.length; i++) {
    int speed = (int)random(170, 400), spawnX, spawnY;

    spawnX = (int)random(amountOfFields);
    spawnY = (int)random(amountOfFields);

    while (spawnX > amountOfFields/3 && spawnX < amountOfFields - amountOfFields/3) {
      spawnX = (int)random(amountOfFields);
    }
    while (spawnY > amountOfFields/3 && spawnY < amountOfFields - amountOfFields/3) {
      spawnY = (int)random(amountOfFields);
    }

    enemies[i] = new Enemy(speed, spawnX, spawnY);
  }
}



void moveFood() {
  for (int i = 0; i < food.length; i++) {
    food[i].move();
  }
}



void initFood() {
  for (int i = 0; i < food.length; i++) {
    food[i] = new Food(myFood.randomSpeed(), myFood.randomSpawnX(), myFood.randomSpawnY());
  }
}



color fieldRole(int c) {
  if (c == 0)return color(255, 0, 0);
  else if (c == 1)return color(0, 255, 0);
  else if (c == 2)return color(0, 0, 255);
  else return 255;
}



void displayText() {
  textSize(30);
  textAlign(LEFT);
  fill(255);
  text("SCORE: " + myPlayer.score, 50, 50);
  text("HEALTH: " + myPlayer.health, 50, 90);
}
