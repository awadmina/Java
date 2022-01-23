character player;
int x, speedx, arrowx, arrowy, arrowsx, arrowsy;
float xx, speedxx, yy, speedyy, timer;
int screen, health, score, hardcore;
title page;
adventure levels;
startgame level1;
thedark level10;
thelight level11;
beast level12;
flowd level13;
banks level14;
aeolia level15;
PImage imaged;
PImage imagel;
PImage imageend;
enemy ghost;
enemy1 mini;
enemy2 beast;

Laser[] lasers = new Laser[3];

ArrayList<Firework> fire;
ArrayList<Particle> sparks;

float explosionSize;

String[] highScore = new String[5];
String[] name = new String[5];
String[] topScore = new String[5];

void setup() {
  size(1000, 500); 

  player = new character();//player

  xx = 40;
  yy = 400;
  speedx = 0;
  speedyy = 0;
  timer = 0;
  screen = 0;
  health = 100;

  fire = new ArrayList<Firework>();
  sparks = new ArrayList<Particle>();

  for (int i=0; i < lasers.length; i++) {
    lasers[i] = new Laser(random(width), random(height), random(width), random(height));
  }


  //levels
  levels = new adventure("Start", 150, 240);

  levels.left = new adventure("The Dark", 300, 150);
  levels.right = new adventure("The Light", 300, 350);

  //Options for "Fight!": network.right
  levels.right.left = new adventure("Aeolia", 600, 325);
  levels.right.right = new adventure("Banks", 600, 380);

  //Options for "Avoid dragon": network.left
  //levels.left.left = new adventure("Arrow", 600, 100);
  levels.left.right = new adventure("Flow", 600, 180);

  levels.left.right.left = new adventure("The Beast", 800, 180);


  //title page
  page = new title(); 

  //classes for levels
  ghost = new enemy();
  mini = new enemy1();
  beast = new enemy2();
  level1 = new startgame();
  level10 = new thedark();
  level11 = new thelight();
  level12 = new beast();
  level13 = new flowd();
  level14 = new banks();
  level15 = new aeolia();

  imaged = loadImage("cave.jpg");  // Load the image into the program
  imagel = loadImage("mountain.jpg");
  imageend = loadImage("outside.jpg");


  //highscores
  highScore[0] = "00:30";
  highScore[1] = "00:55";
  highScore[2] = "01:50";
  highScore[3] = "02:10";
  highScore[4] = "03:50";

  //user names
  name[0] = "CoOkiE_MoNsTeR";
  name[1] = "ScoOBy-DoO";
  name[2] = "PopEYE";
  name[3] = "Larry_the_Cucumber";
  name[4] = "Bob_the_builder";

  //score
  topScore[0] = "1st";
  topScore[1] = "2nd";
  topScore[2] = "3rd";
  topScore[3] = "4th";
  topScore[4] = "5th";
}

void draw() {
  background(100, 150, 200);

  if (screen == 0) { //title
    background(225, 190, 150);
    page.play();
  } else if (screen == 1) { //level map
    background(225, 190, 160);
    fill(0);
    levels.drawAdventure(levels);
    levels.render();
    fill(0);
    rect(50, 50, 150, 50); //menu
    fill(255);
    textSize(40);
    text("Menu", 120 - textWidth("Menu")/2, 90);
    if (mousePressed) {
      if (mouseX > 50 && mouseX < 150 && mouseY > 50 && mouseY < 150) {//menu
        screen = 0;
      }
    }
    fill(0);
    textSize(15);
    stroke(150);
  } else if (screen == 2) { // start level
    background (100, 100, 100);
    level1.render();
    ghost.hurt();
    mini.hurt();
    player.display();
    fill(0);
    rect(50, 50, 150, 50); //menu
    fill(255);
    textSize(40);
    text("Menu", 120 - textWidth("Menu")/2, 90);
    if (mousePressed) {
      if (mouseX > 50 && mouseX < 150 && mouseY > 50 && mouseY < 150) {//menu
        screen = 0;
      }
    }
  } else if (screen == 3) {//the dark
    background(0);
    image(imaged, 0, 0, imaged.width/1.5, imaged.height/2);
    level10.render();
    player.display();
    ghost.hurt();
  } else if (screen == 4) {//the light
    background(255);
    image(imagel, 0, 0, imagel.width, imagel.height/1.25);
    level11.render();
    player.display();
    ghost.hurt();
  } else if (screen == 5) {//aeolia
    background(255);
    image(imagel, 0, 0, imagel.width, imagel.height/1.25);
    level15.render();
    player.display();
    ghost.hurt();
  } else if (screen == 6) {//banks
    background(255);
    image(imagel, 0, 0, imagel.width, imagel.height/1.25);
    level14.render();
    player.display();
    ghost.hurt();
  } else if (screen == 7) {//doomd
    background(0);
    image(imaged, 0, 0, imaged.width/1.5, imaged.height/2);
    level13.render();
    player.display();
    ghost.hurt();
    mini.hurt();
  } else if (screen == 8) {//beast
    background(0);
    image(imageend, 0, 0, imageend.width/2, imageend.height/2);
    level12.render();
    player.display();
    beast.hurt();
  } else if (screen == 9) { //celebration screen
    health = 100;

    for (int i=0; i < fire.size(); i++) fire.get(i).render();

    for (int i=0; i < fire.size(); i++) {
      if (fire.get(i).done == true) {
        //remove and spawn of explosion

        explosionSize = floor(random(20)) + 4;
        for (int j= 0; j < explosionSize; j++) {
          sparks.add(new Particle(fire.get(i).x, fire.get(i).y));
        }

        fire.remove(i);
        i--;
      }
    }

    for (int i=0; i < sparks.size(); i++) sparks.get(i).render();

    for (int i=0; i < sparks.size(); i++) {
      if (sparks.get(i).lifeSpan <= 0) {
        sparks.remove(i);
        i--;
      }
    }
    timer = timer + 0.01;

    if (timer >= 1) {
      timer = 0; //Reset
    } else if (timer > 0.75) { //Hit max
      fill(100, 100, 255);
    } else if (timer > 0.5) {
      fill(255, 100, 100);
    } else if (timer > 0.25) {
      fill(100, 200, 100);
    }
    textSize(30);
    text("CONGRATULATION!!!", width/2 - textWidth("CONGRATULATION!!!")/2, 200);

    fill(0);
    if (timer > 1) { //Hit max
      timer = 0; //Reset
    }
    textSize(15);
    if (timer < 0.5) {
      text("Press on Mouse", width/2 - textWidth("Press on Mouse")/2, 350);
    } else {
      text("For Fireworks", width/2 - textWidth("For Fireworks")/2, 350);
    }

    fill(0);
    rect(100, 50, 100, 40);
    textSize(20);
    fill(0);
    rect(50, 50, 150, 50); //menu
    textSize(40);
    fill(255);
    text("Menu", 120 - textWidth("Menu")/2, 90);
    if (mousePressed) {
      if (mouseX > 50 && mouseX < 150 && mouseY > 50 && mouseY < 150) {//menu
        screen = 0;
      }
    }
  } else if (screen == 10) {//Top Scores
    background(225, 190, 150);
    noStroke();
    fill(80, 164, 255);
    for (int i = 0; i < width; i=i+30) {
      ellipse(i, 500, 30, 30);
      ellipse(i, 0, 30, 30);
      rect(990, i, 10, 25);
      rect(0, i, 10, 25);
    }
    
    fill(95, 19, 26);
    textSize(25);
    text("Top Scores in the World", 400, 100);
    
    
    //array for top scores 
    //top scores
    fill(0);
    for (int i = 0; i < 5; i++) {
      text(highScore[i], 750, i * 50 + 200);
    }
    rect(700, 170, 2, 250);
    rect(400, 170, 2, 250);
      
    //placement of top scores
    text(topScore[0], 300, 200);
    text(topScore[1], 300, 250);
    text(topScore[2], 300, 300);
    text(topScore[3], 300, 350);
    text(topScore[4], 300, 400);
    
    //top username 
    for (int i = 0; i < 5; i++) {
      text(name[i], 420, i * 50 + 200);
    }
    
    
    fill(0);
    rect(50, 50, 150, 50); //menu
    fill(255);
    textSize(40);
    text("Menu", 120 - textWidth("Menu")/2, 90);
    if (mousePressed) {
      if (mouseX > 50 && mouseX < 150 && mouseY > 50 && mouseY < 150) {//menu
        screen = 0;
      }
    }
  } else if (screen == 11) {// hard or easy options
    background(225, 190, 150);
    noStroke();
    fill(80, 164, 255);
    for (int i = 0; i < width; i=i+30) {
      ellipse(i, 500, 30, 30);
      ellipse(i, 0, 30, 30);
      rect(990, i, 10, 25);
      rect(0, i, 10, 25);
    }

    fill(200);
    rect(250, 250, 200, 100, 30);
    textSize(40);
    fill(0);
    text("Easy", 350 - textWidth("Easy")/2, 310);
    if (mouseX > 250 && mouseX < 450 && mouseY > 250 && mouseY < 350) {//easycore
      fill(255);
      rect(250, 250, 200, 100, 30);
      fill(0);
      text("Easy", 350 - textWidth("Easy")/2, 310);
    }
    fill(200);
    rect(500, 250, 200, 100, 30);
    fill(0);
    text("Difficult", 600 - textWidth("Difficult")/2, 310);
    if (mouseX > 500 && mouseX < 700 && mouseY > 250 && mouseY < 350) {//hard core
      fill(255);
      rect(500, 250, 200, 100, 30);
      fill(0);
      text("Difficult", 600 - textWidth("Difficult")/2, 310);
    }
    fill(0);
    rect(50, 50, 150, 50); //menu
    fill(255);
    text("Menu", 120 - textWidth("Menu")/2, 90);
    //rect(300, 100, 100, 50); //hard core
    if (mousePressed) {
      if (mouseX > 50 && mouseX < 150 && mouseY > 50 && mouseY < 150) {//menu
        screen = 0;
      }
      if (mouseX > 500 && mouseX < 700 && mouseY > 250 && mouseY < 350) {//harcore
        hardcore = 1;
      }
      if (mouseX > 250 && mouseX < 450 && mouseY > 250 && mouseY < 350) {//easy
        hardcore = 0;
      }
    }
  }
}


class character {

  void display() {
    xx += speedx;
    yy += speedyy;
    speedyy += 0.1;


    if (yy >= 400) {
      speedyy = 0;
    }

    if (yy >= 400) {
      timer = timer + 0.25;
      if (timer >= 10) {
        timer = 0;
      }
      if (timer <= 5) {
        ellipse(xx, yy, 20 + 1, 20 - 1);
      }
      if (timer >= 5) {
        ellipse(xx, yy, 20 - 1, 20 + 1);
      }
    }
    if (yy < 400) {
      ellipse(xx, yy, 20, 20);
    }
    if (xx <= 0) {
      xx = 10;
    }
    if (xx >= 1000) {
      xx = 990;
    }

    for (int i=0; i < lasers.length; i++) lasers[i].render();

    if (health >= 100) {
      health = 100;
    } else if (health < 100 && health >= 1) {
      noFill();
      stroke(1);
      rect(xx - 12, yy - 22, 28, 8);
      noStroke();
      fill(255);
      rect(xx - 10, yy - 20, 1 * health / 4, 5);
      stroke(1);
    } else if (health <= 0) {
      screen = 2;
      health = 100;
      println("So CLOSE!! You almost defeated and escaped the Beast.");
    }
    textSize(20);
    fill(255);
    text("Health: " + health, 875, 20);
  }
}


void keyPressed() {
  if (key == 'a' || key == 'A') speedx = -5;
  else if (key == 'd'|| key== 'D') speedx = 5;
  else if (key == 'w' || key =='W') {
    speedyy = -4;
    if (yy >= (400)) {
      speedyy = -4;
    } else {
      speedyy = 0;
    }
  } else if (key == 's' || key == 'S') {
    speedyy += 5;
    if (yy >= (400)) {
      speedyy = 0;
    }
  } else if (key == ' ') {
    for (int i=0; i < lasers.length; i++) {
      if (lasers[i].active == false) {
        lasers[i].fireLaser(xx, yy, mouseX, mouseY);
        break;
      }
    }
  }
}


void keyReleased() {
  if (key == 'a' || key == 'A') {
    speedx = 0;
    //landed = true;
  } else if (key == 'd'|| key== 'D') {
    speedx = 0;
  }
}


class Mover {
  float x, y, sx, sy;

  Mover(float a, float b) {
    this.x = a;
    this.y = b;
    this.sx = 0;
    this.sy = 0;
  }

  void move() {
    this.x = this.x + this.sx;
    this.y = this.y + this.sy;

    this.sy = this.sy + 0.08;//gravity
  }
}

class Laser extends Mover { // player bullets
  boolean active;

  Laser(float startx, float starty, float destx, float desty) {
    super(startx, starty); //This is Mover's constructor
    //That line set the x and y values

    this.sx = destx - startx;//These get it moving in the right direction
    this.sy = desty - starty;//But they will reach destination in 1 screen draw

    //To slow it down, we scale down the speeds
    this.sx = this.sx / dist(startx, starty, destx, desty);
    this.sy = this.sy / dist(startx, starty, destx, desty);

    //So now sx and sy togther have a speed of 1 pixel per screen draw
    //So lets say I want: 5 pixels per screen draw, so just multiply by 5

    this.sx = this.sx * 5;
    this.sy = this.sy * 5;

    this.active = false;
  }

  void render() {
    if (this.active == true) {
      //Draw
      stroke(1);
      fill(0);
      line(this.x, this.y, this.x + this.sx, this.y + this.sy);

      //Move
      this.move();

      if (this.x < 0 || this.y < 0 || this.x > width || this.y > height) this.active = false;
    }
  }

  void fireLaser(float startx, float starty, float destx, float desty) {

    this.x = xx;
    this.y = yy;

    //Condesned version
    this.sx = 7 * (destx - startx) / dist(startx, starty, destx, desty);
    this.sy = 7 * (desty - starty) / dist(startx, starty, destx, desty);

    this.active = true;
  }
}

class enemy { //ghost  
  float o, p, speedX, speedY;
  float targetO = xx;
  float targetP = yy;
  int ghosthealth = 50;
  //enemy() {
  //super(0, 0);
  //}
  void hurt() {
    float targetO = xx;
    o += speedX;
    float targetP = yy;
    p += speedY;

    fill(255);
    stroke(1);
    ellipse(o + speedY, p + speedX, 25, 25);
    fill(155);
    ellipse(o + 5, p, 5, 5);
    ellipse(o - 5, p, 5, 5);

    if (hardcore == 1) {
      if (o < targetO) {
        speedX = 2;
      } else if (o == targetO) {
        speedX =0;
      } else {
        speedX = -2;
      }
      if (p < targetP) {
        speedY = 2;
      } else if (p == targetP) {
        speedY = 0;
      } else {
        speedY = -2;
      }
    } else {
      if (o < targetO) {
        speedX = 1;
      } else if (o == targetO) {
        speedX =0;
      } else {
        speedX = -1;
      }
      if (p < targetP) {
        speedY = 1;
      } else if (p == targetP) {
        speedY = 0;
      } else {
        speedY = -1;
      }
    }

    //if bullets hits ghost
    for (int j=0; j < lasers.length; j++) {
      if (dist(this.o, this.p, lasers[j].x, lasers[j].y) <= 25) {
        lasers[j].active = false;
        ghosthealth = ghosthealth - 50;
        this.o = xx - 100;
        this.p = yy - 100;
      }
    }
    
    if (ghosthealth == 0) {
      health = health + 5;
    }

    if (dist(xx, yy, this.o, this.p) < 20) {
      health = health - 5;

      for (int i=0; i < health; i++) {
        if (o < targetO || p < targetP) {
          this.o = xx - 100;
          this.p = yy - 100;
          if (o >= targetO || p >= targetP) {
            this.o = xx + 100;
            this.p = yy - 100;
          }
        }
      }
    }
  }
}

class enemy1 { //minion

  //float timer, speedX, speedY;
  float o = 1020, p, speedX, speedY;
  int minionhealth = 50;
  void hurt() {
    float targetO = xx;
    this.p = 400;
    this.o += speedX;

    fill(100, 200, 100);
    ellipse(o, p + speedX, 25, 25);
    fill(255);
    stroke(1);
    ellipse(o + 5, p, 5, 5);
    ellipse(o - 5, p, 5, 5);

    if (hardcore == 1) {
      if (o < targetO) {
        speedX = 3;
      } else if (o == targetO) {
        speedX = 0;
      } else {
        speedX = -3;
      }
    } else {
      if (o < targetO) {
        speedX = 2;
      } else if (o == targetO) {
        speedX = 0;
      } else {
        speedX = -2;
      }
    }
    
    //if bullets hits minion
    for (int j=0; j < lasers.length; j++) {
      if (dist(this.o, this.p, lasers[j].x, lasers[j].y) <= 25) {
        lasers[j].active = false;
        minionhealth = minionhealth - 50;
        this.o = xx - 200;
      }
    }
    
    if (minionhealth == 0) {
      health = health + 5;
    }
    
    if (dist(xx, yy, this.o, this.p) < 20) {
      health = health - 5;
      for (int i=0; i < health; i++) {
        if (o < targetO) this.o = xx - 100;
        if (o >= targetO) this.o = xx + 100;
      }
    }
  }
}

// Beast
class enemy2 { 
  float o = 500, p = 100, speedX, speedY, timer;
  float targetO = xx;
  float targetP = yy;
  int beasthealth = 1000;
  //enemy() {
  //super(0, 0);
  //}
  void hurt() {
    float targetO = xx;
    o += speedX;
    float targetP = yy;
    p += speedY;

    fill(0);
    ellipse(o + speedY, p + speedX, 100, 100);
    stroke(1);
    fill(255);
    ellipse(o + 25, p, 25, 25);
    ellipse(o - 25, p, 25, 25);
    timer = timer + 0.05;
    if (hardcore == 1) {
      if (timer >= 10) {
        speedY = 0;
        speedX = 0;
        timer = 0;
      } else {
        if (o < targetO) {
          speedX = 2;
        } else if (o == targetO) {
          speedX = 0;
        } else {
          speedX = -2;
        }
        if (p < targetP) {
          speedY = 2;
        } else if (p == targetP) {
          speedY = 0;
        } else {
          speedY = -2;
        }
      }
    } else {
      if (timer >= 10) {
        speedY = 0;
        speedX = 0;
        timer = 0;
      } else {
        if (o < targetO) {
          speedX = 1;
        } else if (o == targetO) {
          speedX = 0;
        } else {
          speedX = -1;
        }
        if (p < targetP) {
          speedY = 1;
        } else if (p == targetP) {
          speedY = 0;
        } else {
          speedY = -1;
        }
      }
    }

    //if bullets hits beast
    for (int j=0; j < lasers.length; j++) {
      if (dist(this.o, this.p, lasers[j].x, lasers[j].y) <= 50) {
        lasers[j].active = false;
        beasthealth = beasthealth - 50;
        this.o = xx + random(100, 200);
        this.p = yy +  random(random (-100, -200), random(100, 200));
      }
    }
    
    if (dist(xx, yy, this.o, this.p) < 50) {
      health = health - 25;

      for (int i=0; i < health; i++) {
        if (o < targetO || p < targetP) {
          this.o = xx + random(100, 200);
          this.p = yy + random(random (-100, -200), random(100, 200));
          if (o >= targetO || p >= targetP) {
            this.o = xx + 100;
            this.p = yy - 100;
          }
        }
      }
    }
    
    if (beasthealth <= 0) {//celebration screen
      screen = 9;
    }
  }
}
//dark path
class beast { // final
  void render() {
    fill(0);
    rect(100, 350, 40, 10);// platform on the left
    if (xx >= 100 && xx <= 140 && yy >= 350 && yy <= 360) {
      speedyy = -4;
    }
    rect(100, 300, 40, 10);// platform on the left
    if (xx >= 100 && xx <= 140 && yy >= 300 && yy <= 310) {
      speedyy = -4;
    }
    rect(100, 250, 40, 10);// platform on the left
    if (xx >= 100 && xx <= 140 && yy >= 250 && yy <= 260) {
      speedyy = -4;
    }
    rect(100, 250, 40, 10);// platform on the left
    if (xx >= 100 && xx <= 140 && yy >= 250 && yy <= 260) {
      speedyy = -4;
    }
    rect(100, 200, 40, 10);// platform on the left
    if (xx >= 100 && xx <= 140 && yy >= 200 && yy <= 210) {
      speedyy = -4;
    }
    rect(400, 170, 40, 10);// platform on the left
    if (xx >= 400 && xx <= 440 && yy >= 170 && yy <= 180) {
      speedyy = -4;
    }
    rect(900, 350, 40, 10);//platform on the right
    if (xx >= 900 && xx <= 940 && yy >= 350 && yy <= 360) {
      speedyy = -8;
    }
    rect(500, 100, 30, 10);//platform that has the health boost
    if (xx >= 500 && xx <= 530 && yy >= 100 && yy <= 110) {
      speedyy = -4;
    }
    
    noStroke();
    fill(255, 0, 0);
    ellipse(510, 40, 15, 15);
    ellipse(525, 40, 15, 15);
    fill(184, 108, 108);
    rect(502, 40, 30, 15);//restore health
    fill(0);
    rect(502, 40, 30, 15); 
    if (xx >= 500 && xx <= 530 && yy >= 50 && yy <= 60) {
      health = 100;
    }
  }
}

class title {
  void play() {

    fill(0);//black
    rect(410, 210, 200, 100, 30);
    textSize(70);
    strokeWeight(2);
    fill(0);
    text("Escape", 380, 105);
    fill(80, 164, 255);//blue for title
    text("Escape", 375, 100);
    if (mouseX > 410 && mouseX < 610 && mouseY > 200 && mouseY < 300) {//turns into grey when mouse is on it
      fill(102, 178, 255);//light blue when mouse is on button
      rect(410, 210, 200, 100, 30);
      fill(0);
      text("Play", 410 + 100 - textWidth("Play")/2, 210 + 70);
    } else {
      fill(255);//white
      rect(400, 200, 200, 100, 30);
      fill(0);
      text("Play", 500 +  - textWidth("Play")/2, 270);
    }
    
    noStroke();
    fill(80, 164, 255);
    for (int i = 0; i < width; i=i+30) {
      ellipse(i, 500, 30, 30);
      ellipse(i, 0, 30, 30);
      rect(990, i, 10, 25);
      rect(0, i, 10, 25);
    }

    fill(0);
    rect(300, 350, 200, 100, 30);
    textSize(30);
    if (mouseX > 300 && mouseX < 500 && mouseY > 350 && mouseY < 450) {
      fill(38, 195, 211);
      rect(300, 350, 200, 100, 30);
      fill(0);
      text("Top Scores", 405 - textWidth("Top Scores")/2, 410);
    } else {
      fill(255);
      rect(295, 345, 200, 100, 30);
      fill(0);
      text("Top Scores", 395 - textWidth("Top Scores")/2, 405);
    }
    fill(0);
    rect(550, 350, 200, 100, 30);
    textSize(40);
    if (mouseX > 550 && mouseX < 750 && mouseY > 350 && mouseY < 450) {
      fill(38, 195, 211);
      rect(550, 350, 200, 100, 30);
      fill(0);
      text("Difficulty", 650 - textWidth("Difficulty")/2, 410);
    } else {
      fill(255);
      rect(545, 345, 200, 100, 30);
      fill(0);
      text("Difficulty", 645 - textWidth("Difficulty")/2, 405);
    }
    
    if (mousePressed) {
      if (mouseX > 400 && mouseX < 600 && mouseY > 200 && mouseY < 300) {
        screen = 1;
      } else if (mouseX > 300 && mouseX < 500 && mouseY > 350 && mouseY < 450) {
        screen = 10;
      } else if (mouseX > 550 && mouseX < 750 && mouseY > 350 && mouseY < 450) {
        screen = 11;
      }
    }
  }
}


class adventure {
  String levelname;
  adventure left, right;
  int x, y;

  adventure(String a, int x, int y) {
    this.levelname = a;
    this.x = x;
    this.y = y;
    this.left = null; //null mean "no value"
    this.right = null;
  }
  
  void drawAdventure(adventure A) {
    ellipse(A.x, A.y, 10, 10);
    text(A.levelname, A.x + 10, A.y);

    if (A.left != null) {
      line(A.x, A.y, A.left.x, A.left.y);
      drawAdventure(A.left);
    }
    if (A.right != null) {
      line(A.x, A.y, A.right.x, A.right.y);
      drawAdventure(A.right);
    }
  }
  
  void render() {
    fill(0);
    ellipse(this.x, this.y, 10, 10);//start - 1
    ellipse(this.x + 150, this.y - 90, 10, 10);//the dark - 2
    ellipse(this.x + 150, this.y + 110, 10, 10);//light path - 3
    ellipse(this.x + 450, this.y + 85, 10, 10);//aeolia level - 4
    ellipse(this.x + 450, this.y + 140, 10, 10);//banks level - 5
    ellipse(this.x + 450, this.y - 60, 10, 10);//doom level - 6
    ellipse(this.x + 650, this.y - 60, 10, 10);//final level - 7

    //This mousePRessed here just checks if the mouse is currently pressed, so by running this code via void draw will work
    if (mousePressed && screen == 1) {
      if (dist(mouseX, mouseY, this.x, this.y) < 10) {//start - 1
        screen = 2;
      }
      if (dist(mouseX, mouseY, this.x + 150, this.y - 90) < 10) {// 2
        //background(100, 100, 100);
        screen = 3;
      }
      if (dist(mouseX, mouseY, this.x + 150, this.y + 110) < 10) {// 3
        background(230, 230, 230);
        screen = 4;
      }
      if (dist(mouseX, mouseY, this.x + 450, this.y + 85) < 10) {// 4
        background(100, 100, 100);
        screen = 5;
      }
      if (dist(mouseX, mouseY, this.x + 450, this.y + 140) < 10) {// 5
        background(230, 230, 230);
        screen = 6;
      }
      if (dist(mouseX, mouseY, this.x + 450, this.y - 60) < 10) {// 6
        background(100, 100, 100);
        screen = 7;
      }
      if (dist(mouseX, mouseY, this.x + 650, this.y - 60) < 10) {// 7
        background(230, 230, 230);
        screen = 8;
      }
    }
    
    noStroke();
    fill(80, 164, 255);
    for (int i = 0; i < width; i=i+30) {
      ellipse(i, 500, 30, 30);
      ellipse(i, 0, 30, 30);
      rect(990, i, 10, 25);
      rect(0, i, 10, 25);
    }
  }
}

class startgame { //extends objects {

  void render() {
    //map(0, 0, 100, -20, -10);
    rect(-1, 410, 1001, 10); //ground
    //this.render();
    rect(100, 350, 40, 10);// platform
    if (xx >= 100 && xx <= 140 && yy >= 350 && yy <= 360) {
      speedx = 0;
      speedyy = -3;
    }
    rect(200, 300, 40, 10);// platform
    if (xx >= 200 && xx <= 240 && yy >= 300 && yy <= 310) {
      speedx = 0;
      speedyy = -3;
    }
    rect(300, 250, 40, 10);// platform
    if (xx >= 300 && xx <= 340 && yy >= 250 && yy <= 260) {
      speedx = 0;
      speedyy = -3;
    }
    rect(400, 250, 40, 10);// platform
    if (xx >= 400 && xx <= 440 && yy >= 250 && yy <= 260) {
      speedx = 0;
      speedyy = -3;
    }
    rect(500, 250, 40, 10);// platform
    if (xx >= 500 && xx <= 540 && yy >= 250 && yy <= 260) {
      speedx = 0;
      speedyy = -3;
    }
    rect(600, 250, 40, 10);// platform
    if (xx >= 600 && xx <= 640 && yy >= 250 && yy <= 260) {
      speedx = 0;
      speedyy = -3;
    }
    rect(700, 250, 40, 10);// platform
    if (xx >= 700 && xx <= 740 && yy >= 250 && yy <= 260) {
      speedx = 0;
      speedyy = -3;
    }
    rect(800, 250, 40, 10);// platform
    if (xx >= 800 && xx <= 840 && yy >= 250 && yy <= 260) {
      speedx = 0;
      speedyy = -3;
    }
    rect(900, 200, 100, 10);// platform
    if (xx >= 900 && xx <= 940 && yy >= 200 && yy <= 210) {
      speedx = 0;
      speedyy = -3;
    }
    rect(700, 100, 100, 10);// platform
    if (xx >= 700 && xx <= 800 && yy >= 100 && yy <= 110) {
      speedx = 0;
      speedyy = -3;
    }
    rect(850, 150, 40, 10); // platform
    if (xx >= 850 && xx <= 890 && yy >= 150 && yy <= 160) {
      speedx = 0;
      speedyy = -3;
    }
    rect(740, 50, 20, 30);
    if (xx >= 740 && xx <= 760 && yy >= 50 && yy <= 80) {//to the dark side
      screen = 3;
      xx= 40;
      yy= 400;
    }
    rect(900, 370, 20, 30);
    if (xx >= 900 && xx <= 920 && yy >= 370 && yy <= 400) {//to the light side
      screen = 4;
      xx= 40;
      yy= 400;
    }
    noStroke();
    fill(255, 0, 0);
    ellipse(510, 400, 15, 15);
    ellipse(525, 400, 15, 15);
    fill(184, 108, 108);
    rect(502, 400, 30, 15);//restore health
    if (xx >= 502 && xx <= 532 && yy >= 400 && yy <= 415) {
      health = 100;
    }
  }
}

//level the dark
class thedark {

  void render() {
    //this.boundary();
    noStroke();
    fill(75, 175, 240);//light blue
    rect(100, 100, 60, 250);//water
    if (xx >= 100 && xx <= 160 && yy >= 100 && yy <= 350) {
      speedx = 0;
      speedyy = -2;
    }
    fill(0);
    rect(-1, 410, 1001, 10); // ground
    rect(170, 90, 10, 330);// ground
    if (xx >= 170 && xx <= 180 && yy >= 90 && yy <= 420) {
      speedx = -5;
      speedyy = 0;
    }
    rect(180, 90, 10, 330);// ground
    if (xx >= 180 && xx <= 190 && yy >= 90 && yy <= 420) {
      speedx = 4;
      speedyy = 0;
    }
    rect(180, 100, 780, 20);// border
    if (xx >= 180 && xx <= 960 && yy >= 100 && yy <= 120) {
      speedx = 0;
      speedyy = -2;
    }
    rect(220, 200, 780, 20);// border
    if (xx >= 220 && xx <= 780 && yy >= 200 && yy <= 220) {
      speedx = 0;
      speedyy = -2;
    }
    rect(220, 200, 780, 20);// border
    if (xx >= 220 && xx <= 1000 && yy >= 200 && yy <= 220) {
      speedx = 0;
      speedyy = -3.5;
    }
    rect(220, 300, 780, 20); // border
    if (xx >= 220 && xx <= 1000 && yy >= 300 && yy <= 320) {
      speedx = 0;
      speedyy = -3;
    }
    fill(80, 65, 38); // brown
    rect(240, 140, 670, 5); // zip line
    if (xx >= 240 && xx <= 910 && yy >= 140 && yy <= 145) {
      speedx = -2;
      speedyy = -0.1;
    }
    fill(252, 207, 92);//orange
    rect(350, 100, 60, 10); // lava
    if (xx >= 350 && xx <= 410 && yy >= 100 && yy <= 110) {
      speedx = 0;
      speedyy = 0;
      health= health - 5;
    }
    rect(550, 100, 60, 10); // lava
    if (xx >= 550 && xx <= 610 && yy >= 100 && yy <= 110) {
      speedx = 0;
      speedyy = 0;
      health= health - 5;
    }
    rect(850, 100, 60, 10); // lava
    if (xx >= 850 && xx <= 910 && yy >= 100 && yy <= 110) {
      speedx = 0;
      speedyy = 0;
      health= health - 5;
    }
    rect(250, 200, 650, 10); // lava
    if (xx >= 250 && xx <= 900 && yy >= 200 && yy <= 210) {
      speedx = 0;
      speedyy = 0;
      health= health - 5;
    }
    rect(180, 400, 820, 10); // lava
    if (xx >= 180 && xx <= 1000 && yy >= 400 && yy <= 410) {
      speedx = 0;
      speedyy = 0;
      health= health - 5;
    }
    fill(255);
    rect(900, 250, 20, 30);
    if (xx >= 900 && xx <= 920 && yy >= 250 && yy <= 280) {//to the dark side
      screen = 7;
      xx= 40;
      yy= 400;
    }
  }
}

//dark path
class flowd { 
  void render() {
    noStroke();
    fill(0);
    rect(-1, 410, 1001, 10); 
    rect(50, 350, 10, 40);//bounce right
    if (xx >= 50 && xx <= 60 && yy >= 350 && yy <= 390) {
      speedx = 4;
      speedyy = -4;
    }
    rect(150, 300, 10, 40);//bounce left
    if (xx >= 150 && xx <= 160 && yy >= 300 && yy <= 340) {
      speedx = -4;
      speedyy = -3;
    }
    rect(50, 250, 10, 40);//bounce right
    if (xx >= 50 && xx <= 60 && yy >= 250 && yy <= 290) {
      speedx = 4;
      speedyy = -3;
    }
    rect(150, 200, 10, 40);//bounce left
    if (xx >= 150 && xx <= 160 && yy >= 200 && yy <= 240) {
      speedx = -4;
      speedyy = -3;
    }
    rect(50, 150, 10, 40);//bounce right
    if (xx >= 50 && xx <= 60 && yy >= 150 && yy <= 190) {
      speedx = 4;
      speedyy = -4;
    }
    rect(200, 120, 10, 300); //border moves you to the left
    if (xx >= 200 && xx <= 210 && yy >= 120 && yy <= 440) {
      speedx = -4;
      speedyy = 9.8;
    }
    rect(210, 120, 10, 300); //border moves you to the left
    if (xx >= 210 && xx <= 220 && yy >= 120 && yy <= 440) {
      speedx = 4;
    }
    rect(210, 120, 690, 20); //ground
    if (xx >= 210 && xx <= 900 && yy >= 120 && yy <= 140) {
      speedyy = -3;
    }
    noFill();
    rect(210, 0, 690, 120); //wind blowing in the direction you should go
    if (xx >= 210 && xx <= 900 && yy >= 0 && yy <= 120) {
      speedx = 1;
    }
    fill(0);
    rect(300, 220, 700, 20); //ground
    if (xx >= 300 && xx <= 1000 && yy >= 220 && yy <= 240) {
      speedyy = -3;
    }
    rect(310, 220, 20, 130); //border
    if (xx >= 310 && xx <= 330 && yy >= 220 && yy <= 350) {
      speedx = -3;
      speedyy = 0;
    }
    rect(520, 360, 20, 50); //border
    if (xx >= 520 && xx <= 540 && yy >= 360 && yy <= 410) {
      speedx = -3;
      speedyy = 0;
    }
    rect(540, 360, 10, 50); //border
    if (xx >= 540 && xx <= 550 && yy >= 360 && yy <= 410) {
      speedx = 3;
      speedyy = 0;
    }
    rect(340, 280, 40, 10); //platform
    if (xx >= 340 && xx <= 380 && yy >= 280 && yy <= 290) {
      speedyy = -1;
    }
    noStroke();
    fill(255, 0, 0);
    ellipse(358, 265, 15, 15);
    ellipse(373, 265, 15, 15);
    fill(184, 108, 108);
    rect(350, 265, 30, 15);//restore health
    if (xx >= 350 && xx <= 380 && yy >= 265 && yy <= 280) {
      health = 100;
    }
    fill(75, 175, 240);//light blue
    rect(300, 150, 540, 60); //water
    if (xx >= 300 && xx <= 840 && yy >= 150 && yy <= 210) {
      speedx = -2;
      speedyy = -0.01;
    }

    rect(310, 360, 200, 50); //water
    if (xx >= 310 && xx <= 510 && yy >= 360 && yy <= 410) {
      speedx = 3;
      speedyy = -4;
    }
    fill(255);
    rect(900, 370, 20, 30);
    if (xx >= 900 && xx <= 920 && yy >= 370 && yy <= 400) {// door to the beast
      screen = 8;
      xx= 40;
      yy= 400;
    }
  }
}

//level the light
class thelight { 
  void render() {
    noStroke();
    fill(75, 175, 240);//light blue
    rect(160, 370, 30, 40);//button telepotation
    if (xx >= 160 && xx <= 190 && yy >= 370 && yy <= 410) {
      xx = 200;
      yy = 80;
    }
    fill(0);
    rect(-1, 410, 1001, 10); //ground
    rect(170, 90, 10, 330);//border
    if (xx >= 170 && xx <= 180 && yy >= 90 && yy <= 420) {
      speedx = -5;
    }
    rect(180, 90, 10, 330);//border
    if (xx >= 180 && xx <= 190 && yy >= 90 && yy <= 420) {
      speedx = 4;
    }
    rect(180, 100, 780, 20);//ground
    if (xx >= 180 && xx <= 960 && yy >= 100 && yy <= 120) {
      speedyy = -2;
    }
    rect(220, 200, 780, 20);//ground
    if (xx >= 220 && xx <= 780 && yy >= 200 && yy <= 220) {
      speedyy = -2;
    }
    rect(220, 200, 780, 20);//ground
    if (xx >= 220 && xx <= 1000 && yy >= 200 && yy <= 220) {
      speedyy = -3.5;
    }
    rect(330, 70, 30, 10); // platform
    if (xx >= 330 && xx <= 360 && yy >= 70 && yy <= 80) {
      speedyy = -3;
    }
    rect(550, 70, 30, 10); // platform
    if (xx >= 550 && xx <= 580 && yy >= 70 && yy <= 80) {
      speedyy = -3;
    }
    rect(250, 300, 50, 20);//platform
    if (xx >= 250 && xx <= 300 && yy >= 300 && yy <= 320) {
      speedyy = -3;
    }
    rect(570, 300, 50, 20);//platform
    if (xx >= 570 && xx <= 620 && yy >= 300 && yy <= 320) {
      speedyy = -3;
    }
    rect(880, 300, 50, 20);//platform
    if (xx >= 880 && xx <= 930 && yy >= 300 && yy <= 320) {
      speedyy = -3;
    }
    fill(80, 65, 38); // brown
    rect(240, 140, 670, 5); // zip line
    if (xx >= 240 && xx <= 910 && yy >= 140 && yy <= 145) {
      speedx = -2;
      speedyy = -0.1;
    }
    fill(252, 207, 92);//orange
    rect(240, 100, 660, 10); // lava
    if (xx >= 240 && xx <= 900 && yy >= 100 && yy <= 110) {
      health= health - 5;
    }
    rect(250, 200, 650, 10); // lava
    if (xx >= 250 && xx <= 900 && yy >= 200 && yy <= 210) {
      health= health - 5;
    }
    rect(180, 400, 820, 10); // lava
    if (xx >= 180 && xx <= 1000 && yy >= 400 && yy <= 410) {
      health= health - 5;
    }
    fill(255);
    rect(900, 250, 20, 30);
    if (xx >= 900 && xx <= 920 && yy >= 250 && yy <= 280) {//to the dark side
      screen = 5; // aeolia
      xx= 40;
      yy= 400;
    }
    rect(900, 340, 20, 30);
    if (xx >= 900 && xx <= 920 && yy >= 340 && yy <= 370) {//to the dark side
      screen = 6; // banks
      xx= 40;
      yy= 400;
    }
    noStroke();
    fill(255, 0, 0);
    ellipse(588, 290, 15, 15);
    ellipse(603, 290, 15, 15);
    fill(184, 108, 108);
    rect(580, 290, 30, 15);//restore health
    if (xx >= 580 && xx <= 610 && yy >= 290 && yy <= 305) {
      health = 100;
    }
  }
}

//light path
class aeolia {
  void render() {
    noStroke();
    fill(75, 175, 240);//light blue
    rect(160, 300, 20, 40); // button telepotation
    if (xx >= 160 && xx <= 180 && yy >= 300 && yy <= 340) {
      xx = 40;
      yy = 400;
    }
    fill(0);
    rect(-1, 410, 1001, 10); //ground
    rect(20, 90, 30, 10);//platform
    if (xx >= 20 && xx <= 50 && yy >= 90 && yy <= 100) {
      speedyy = -3;
    }

    rect(20, 90, 30, 10);//platform
    if (xx >= 20 && xx <= 50 && yy >= 90 && yy <= 100) {
      speedyy = -3;
    }
    rect(180, 90, 10, 330);//border
    if (xx >= 180 && xx <= 190 && yy >= 90 && yy <= 420) {
      speedx = -4;
    }
    rect(190, 90, 10, 330);//border
    if (xx >= 190 && xx <= 200 && yy >= 90 && yy <= 420) {
      speedx = 4;
    }
    rect(180, 100, 780, 20);//ground
    if (xx >= 180 && xx <= 960 && yy >= 100 && yy <= 120) {
      speedyy = -3.5;
    }
    rect(220, 200, 780, 20);//ground
    if (xx >= 220 && xx <= 1000 && yy >= 200 && yy <= 220) {
      speedyy = -3.5;
    }
    noFill();
    rect(20, 120, 50, 240);//wind
    if (xx >= 20 && xx <= 50 && yy >= 120 && yy <= 360) {
      speedyy = -5;
    }
    rect(230, 70, 660, 50); // wind
    if (xx >= 230 && xx <= 890 && yy >= 70 && yy <= 110) {
      speedyy = 0.5;
      speedx = -4;
    }
    rect(230, 160, 660, 50); // wind
    if (xx >= 230 && xx <= 890 && yy >= 160 && yy <= 210) {
      speedyy = 0.5;  
      speedx = 4;
    }
    fill(80, 65, 38); // brown
    rect(240, 40, 670, 5); // zip line
    if (xx >= 240 && xx <= 910 && yy >= 40 && yy <= 45) {
      speedx = 2;
      speedyy = -0.1;
    }
    rect(240, 140, 670, 5); // zip line
    if (xx >= 240 && xx <= 910 && yy >= 140 && yy <= 145) {
      speedx = -2;
      speedyy = -0.1;
    }
    fill(255);
    rect(900, 340, 20, 30);
    if (xx >= 900 && xx <= 920 && yy >= 340 && yy <= 370) {//to the beginning
      screen = 2; // start
      xx= 40;
      yy= 400;
      println("uh oh, seems like you went the wrong way and made a full circle. Maybe take another path");
    }
  }
}

//light path
class banks {
  void render() {
    fill(0);
    rect(-1, 410, 1001, 10); //ground
    rect(110, 90, 10, 330);//border
    if (xx >= 110 && xx <= 120 && yy >= 90 && yy <= 420) {
      speedx = -4;
    }
    rect(210, 0, 10, 330);//border
    if (xx >= 210 && xx <= 220 && yy >= 0 && yy <= 330) {
      speedx = -4;
    }
    rect(310, 90, 10, 330);//border
    if (xx >= 310 && xx <= 320 && yy >= 90 && yy <= 420) {
      speedx = -4;
    }
    rect(410, 0, 10, 330);//border
    if (xx >= 410 && xx <= 420 && yy >= 0 && yy <= 330) {
      speedx = -4;
    }
    rect(510, 90, 10, 330);//border
    if (xx >= 510 && xx <= 520 && yy >= 90 && yy <= 420) {
      speedx = -4;
    }
    rect(610, 0, 10, 330);//border
    if (xx >= 610 && xx <= 620 && yy >= 0 && yy <= 330) {
      speedx = -4;
    }
    rect(710, 90, 10, 330);//border
    if (xx >= 710 && xx <= 720 && yy >= 90 && yy <= 420) {
      speedx = -4;
    }
    //noFill();
    //rect(50, 120, 50, 240);//wind
    if (xx >= 50 && xx <= 100 && yy >= 120 && yy <= 360) {
      speedyy = -5;
    }
    //rect(150, 120, 50, 240);//wind
    if (xx >= 150 && xx <= 200 && yy >= 120 && yy <= 360) {
      speedyy = 5;
    }
    //rect(250, 120, 50, 240);//wind
    if (xx >= 250 && xx <= 300 && yy >= 120 && yy <= 360) {
      speedyy = -5;
    }
    //rect(350, 120, 50, 240);//wind
    if (xx >= 350 && xx <= 400 && yy >= 120 && yy <= 360) {
      speedyy = 5;
    }
    //rect(450, 120, 50, 240);//wind
    if (xx >= 450 && xx <= 500 && yy >= 120 && yy <= 360) {
      speedyy = -5;
    }
    //rect(550, 120, 50, 240);//wind
    if (xx >= 550 && xx <= 600 && yy >= 120 && yy <= 360) {
      speedyy = 5;
    }
    //rect(650, 120, 50, 240);//wind
    if (xx >= 650 && xx <= 700 && yy >= 120 && yy <= 360) {
      speedyy = -5;
    }
    fill(0);
    rect(740, 90, 20, 10);//platform
    if (xx >= 740 && xx <= 760 && yy >= 90 && yy <= 100) {
      speedyy = -3;
    }
    rect(940, 190, 20, 10);//platform
    if (xx >= 940 && xx <= 960 && yy >= 190 && yy <= 200) {
      speedyy = -3;
    }
    rect(740, 290, 20, 10);//platform
    if (xx >= 740 && xx <= 760 && yy >= 290 && yy <= 300) {
      speedyy = -3;
    }
    fill(252, 207, 92);
    rect(740, 100, 200, 20);//lava
    if (xx >= 740 && xx <= 940 && yy >= 100 && yy <= 120) {
      speedyy = -2;
      health = health - 5;
    }
    rect(800, 210, 200, 20);//lava
    if (xx >= 800 && xx <= 1000 && yy >=210 && yy <= 230) {
      speedyy = -2;
      health = health - 5;
    }
    rect(740, 310, 200, 20);//lava
    if (xx >= 740 && xx <= 940 && yy >=310 && yy <= 330) {
      speedyy = -2;
      health = health - 5;
    }
    fill(255);
    rect(900, 340, 20, 30);
    if (xx >= 900 && xx <= 920 && yy >= 340 && yy <= 370) {//to the beginning
      screen = 2; // start
      xx= 40;
      yy= 400;
      println("uh oh, seems like you went the wrong way and made a full circle. Maybe take another path");
    }
  }
}


void mousePressed() {

  fire.add(new Firework(500, 500, random(40, 600), random(0, 400)));
}

class Particle {
  float x, y, sx, sy; //Position and speed business
  int lifeSpan; //Number of screen draws the particle lasts before fading out

  //Add colour variables here

  Particle(float a, float b) {
    this.x = a;
    this.y = b;

    this.sx = -8 + random(16);
    this.sy = -8 + random(16);

    this.lifeSpan = 40 + floor(random(10));

    //assign random values for the red, green, blue variables here
  }

  void render() {
    //These are just super fancy, you can just use easier versions like: fill(255); ellipse(this.x,this.y,10,10);
    //fill(255 * this.lifeSpan/20); //As the lifeSpan counts down the particle will dim
    //ellipse(this.x, this.y, 10* this.lifeSpan/20, 10* this.lifeSpan/20); //The math makes it shrink at the lifespan counts down

    fill(255*this.lifeSpan/50); //Modify this line to use the red,green, bllue values

    ellipse(this.x, this.y, 10*this.lifeSpan/50, 10*this.lifeSpan/50);
    this.x += this.sx;
    this.y += this.sy;

    this.lifeSpan--;

    if (this.lifeSpan < 0) this.lifeSpan = 0;

    /////// EXTRA FEATURES
    //These make the speed lose 10% per screen draw, should look cool
    this.sx *= 0.9;
    this.sy *= 0.9;

    this.sy += this.lifeSpan/40;
  }
}

class Firework {
  float x, y, sx, sy;
  float destx, desty;
  boolean done;

  //Add arraylists for old X values, and old Y values

  Firework(float a, float b, float c, float d) {
    this.x = a;
    this.y = b;

    this.destx = c;
    this.desty = d;

    this.sx = 0;
    this.sy = 0;

    this.done = false;
  }

  void render() {
    fill(random(255), random(255), random(255)); 

    ellipse(this.x, this.y, 10, 10);

    //Store this.x and this.y in the arraylists

    this.x += this.sx;
    this.y += this.sy;

    if (this.x < this.destx) this.sx += 0.1;
    else this.sx -= 0.1;

    if (this.y < this.desty) this.sy += 0.1;
    else this.sy -= 0.1;

    //Speed limits
    if (this.sx > 3) this.sx = 3;
    else if (this.sx < -3) this.sx = -3;

    if (this.sy > 3) this.sy = 3;
    else if (this.sy < -3) this.sy = -3;

    //Desintation reached check

    if (dist(this.x, this.y, this.destx, this.desty) < 50) {
      this.done = true;
    }
  }
}
