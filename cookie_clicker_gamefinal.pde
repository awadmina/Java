int screen;
int score;
int x, y, boxSizeX, boxSizeY;
int a, b, c, d;
int q, w, e, r;
int upgrade;
int z, s, v, f;
int xpX, xpY, boostX, boostY;
int XPBOOST;
float timer;
float blink = 0;
int linenumber = 0;
String line = "";
String line1 = "5 free cookies";
String line2 = "Loading ...";
int upgrades1 = 0;
String[] highScore = new String[5];
String[] name = new String[5];
String[] topScore = new String[5];
int mmX, mmY, mmsizeX, mmsizeY;
int mandm = 0;
int sprX, sprY, sprsizeX, sprsizeY;
int sprinkle = 0;
int choX, choY, chosizeX, chosizeY;
int chips = 0;

void setup() {
  size(640, 480);

  screen = 1; //0 menu, 1 game
  score = 0; //score pressed cookie
  upgrade = 0; //upgrade times your score points
  XPBOOST = 0; // XPBOOST makes score go up by a certain count depending 
  timer = 0; //timer

  //button 1 on screen 1 that goes to game, screen 0
  boxSizeX = 200;
  boxSizeY = 80;
  x = 230;
  y = 240;

  //button 0 on screen 2
  a = 30;
  b = 30;
  c = 80;
  d = 50;

  //button 2 on screen 1 that goes to leaderboard screen 2
  q = width/4;
  w = 335;
  e = 350;
  r = 80;

  //upgrade cookie maker button
  z = 450;
  s = 230;
  v = 150;
  f = 50;

  //xpBoost makes the score counter increase it's counter
  xpX = 450;
  xpY = 150;
  boostX = 50;
  boostY = 50;
  
  //oreo cookie button 
  mmX = 90;
  mmY = 350;
  mmsizeX = 50;
  mmsizeY = 50;
  
  //coconut flakes
  sprX = 90;
  sprY = 250;
  sprsizeX = 50;
  sprsizeY = 50;

  //chocolate chips
  choX = 90;
  choY = 150;
  chosizeX = 50;
  chosizeY = 50;

  //highscores
  highScore[0] = "120 324 890 020";
  highScore[1] = "100 030 249";
  highScore[2] = "500 000 123";
  highScore[3] = "230 482";
  highScore[4] = "100 579";
  
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

  if (screen == 1) {
    background(65, 117, 193);
    fill(101, 174, 232);
    stroke(0);
    rect(x, y, boxSizeX, boxSizeY); //screen 0 button, start button

    //logo
    fill(0);
    textSize(50);
    text("C       kie Clicker", width/4 -10, 100);
    fill(103, 64, 12);
    stroke(67, 49, 26);
    ellipse(213, 80, 50, 50);
    ellipse(268, 80, 50, 50);//cookie in logo

    //start button
    textSize(55);
    fill(0);
    text("START", 245, 300);
    fill(7, 147, 232);
    rect(q, w, e, r);//screen 2 button, top scores button

    //top scores button
    textSize(50);
    fill(0);
    text("Top Scores", 210, 390);
  } else if (screen == 0) {
    background(100, 205, 236);

    //cookie
    fill(77, 39, 33);
    stroke(59, 47, 21);
    ellipse(320, 240, 200, 200);
    
    //Button to go back to main menu
    fill(0);
    rect(a, b, c, d);
    fill(255);
    noStroke();
    textSize(20);
    text("Menu", 45, 65);

    //label score
    textSize(40);
    fill(0);
    text("Score: "+ score, width/2 - textWidth("Score:  ")/2, 440);//variable cookies (number of times the cookie is clicked)

    //label on buttons
    textSize(20);
    text("Dollars: $"+ upgrade, z, s - 5); //upgrade points
    text("Boost: "+ XPBOOST, xpX, xpY - 5); // button to make 

    // button upgrades and XPboost
    fill(138, 232, 167);
    rect(z, s, v, f); //upgrade button
    fill(133, 83, 191);
    rect(xpX, xpY, boostX, boostY);  //XPBOOST button

    //text on upgrade buttons
    fill(0);
    text("10 cookies", z + 10, s + 30);
    text("$30", xpX + 5, xpY + 30);

    //M and M button
    textSize(12);
    fill(0);
    text("M & M $1000", mmX - 30, mmY + 40);
    fill(255, 0, 0);
    ellipse (mmX, mmY, mmsizeX, mmsizeY);
    
    //sprinkles
    fill(0);
    text("Coconut Flakes $100", 50, 300);
    fill(255);
    ellipse (sprX, sprY, sprsizeX, sprsizeY);
    
    //chocolate chips
    fill(0);
    text("Chocolate Chips $10", 50, 200);
    ellipse(choX, choY, chosizeX, chosizeY);

    //XP blinking
    if (XPBOOST > 1) {
      blink = blink + 0.001;
      if (blink > 1) {
        blink = 0;
      }
      if (blink < 0.5) {
        fill(55, 49, 200);
        textSize(25);
        text("XP", 418, 147);
      }
    }
    
    //timer bar
    timer = timer + 0.01;
    if (timer >= 1) { // when timer finshes a whole (1) score goes up
      timer = 0;
      score = score + 5;// everytime the timer finishes score goes up by 5
    }

    //timer, gives 5 cookies for free
    fill(0);
    rect(120, 52, 400, 6);
    fill(255);
    rect(120, 52, 400 * timer, 6);

    //comment above the bar
    blink = blink + 0.008;
    if (blink > 1) {
      blink = 0;
    }
    
    //loading animation
    textSize(15);
    fill(0);

    if (blink < 0.5) {
      text("Loading ", 140, 40);
      ellipse(210, 5 * cos(blink * PI*0.5) + 30, 4, 4);
      ellipse(220, 5 * sin(blink * PI*1) + 30, 4, 4);
      ellipse(230, 5 * cos(blink * PI*0.5) + 30, 4, 4);
    } else {
      text("5 free cookies", 140, 40);
    }
    
  } else if (screen == 2) {
    background(49, 161, 229);

    //manu button
    fill(0);
    rect(a, b, c, d);//Button to go back to main menu
    fill(255);
    noStroke();
    textSize(20);
    text("Menu", 45, 65);

    fill(95, 19, 26);
    textSize(25);
    text("Top Scores in the World:", 160, 100);
    
    
    //array for top scores 
    //top scores
    fill(0);
    for (int i = 0; i < 5; i++) {
      text(highScore[i], 400, i * 30 + 150);
    }
    rect(375, 120, 2, 160);
    rect(80, 120, 2, 160);
      
    //placement of top scores
    text(topScore[0], 25, 150);
    text(topScore[1], 25, 180);
    text(topScore[2], 25, 210);
    text(topScore[3], 25, 240);
    text(topScore[4], 25, 270);
    
    //top username 
    for (int i = 0; i < 5; i++) {
      text(name[i], 100, i * 30 + 150);
    }
  }

  //border
  noStroke();
  fill(57, 22, 22);
  for (int i = 0; i < width; i=i+30) {
    ellipse(i, 480, 40, 40);
    ellipse(i, 0, 40, 40);
    ellipse(640, i, 40, 40);
    ellipse(0, i, 40, 40);
  }

  //number of times the upgrade button has been used
  if (screen == 0) {
    for (int g = 0; g < upgrades1; g++) {
      rect(25 + g * 30, 100, 20, 20);
    }
  } else {
    upgrades1 = 0;
  }
  //m and m
  for (int t = 0; t < mandm; t++){
    fill(214, 39, 39); //red
    ellipse(320, 230, 25, 25);
    fill(34, 181, 224);//blue
    ellipse(245, 210, 20, 20);
    fill(39, 214, 66);//green
    ellipse(360, 285, 15, 15);
    fill(233, 240, 46);//yellow
    ellipse(270, 310, 20, 20);
  }
  //coconut flakes
  for(int u = 0; u < sprinkle; u++){
  fill(255);
  rect(300, 250, 20, 10);
  rect(250, 180, 10, 25);
  rect(380, 260, 20, 20);
  rect(340, 180, 25, 10);
  }
  //chocolate chips
  for(int j = 0; j < chips; j++){
    fill(0);
    ellipse(240, 200, 20, 20);
    ellipse(380, 230, 40, 40);
    ellipse(310, 250, 15, 15);
    ellipse(300, 170, 20, 20);
    ellipse(280, 300, 25, 25);
    ellipse(349, 310, 25, 25);
  }
}

void mousePressed() {
  //manu buttons and buttons to go to different screens
  if (mouseX > a && mouseX < a + c && mouseY > b && mouseY < b + d && (screen == 0 || screen == 2)) {
    screen = 1;
    score = 0;
    upgrade = 0;
    timer = 0;
    XPBOOST = 0;
    mandm = 0;
    sprinkle = 0;
    chips = 0;
  } else if (mouseX > x && mouseX < x + boxSizeX && mouseY > y && mouseY < y + boxSizeY && screen == 1) {
    screen = 0;
    score = 0;
    upgrade = 0;
    timer = 0;
    XPBOOST = 0;
    mandm = 0;
    sprinkle = 0;
    chips = 0;
  } else if (mouseX > q && mouseX < q + e && mouseY > w && mouseY < w + r && screen == 1) {
    screen = 2;
    score = 0;
    upgrade = 0;
    timer = 0;
    XPBOOST = 0;
    mandm = 0;
    sprinkle = 0;
    chips = 0;
  }

  //upgrade buttons for screen 0 (game screen)
  if ( score >= 10 && mouseX > z && mouseX < z + v && mouseY > s && mouseY < s + f && screen == 0) {
    upgrade = upgrade + 5; //upgrade will make score go up by 5
    score = score - 10;// upgrade costs 5 cookie clicks
  }
  //XP button for screen 0 (gmae screen)
  if ( upgrade >= 30 && mouseX > xpX && mouseX < xpX + boostX && mouseY > xpY && mouseY < xpY + boostY && screen == 0) {
    upgrade = upgrade - 30;
    XPBOOST = XPBOOST + 5;
    upgrades1++;
  }

  //counter of score and toppings on cookie
  //counter of score
  if (screen == 0) {
    if (dist(mouseX, mouseY, 320, 240) < 100) {
      score = score + 1;
      score = score + XPBOOST;
    } else if (dist(mouseX, mouseY, 320, 240) > 100) {
      score = score + 0; // score does not go up at all when cookie is not clicked
    }
    //m and m
     if (dist(mouseX, mouseY, mmX, mmY) < 25 && upgrade >= 1000) {
      upgrade = upgrade - 1000;
      mandm++;
    } else if (dist(mouseX, mouseY, mmX, mmY) > 25) {
      upgrade = upgrade + 0;
    }
    //coconut flakes
    if (dist(mouseX, mouseY, sprX, sprY) < 25 && upgrade >= 100) {
      upgrade = upgrade - 100;
      sprinkle++;
    } else if (dist(mouseX, mouseY, sprX, sprY) > 25) {
      upgrade = upgrade + 0; 
    }
    //chocolate chips
     if (dist(mouseX, mouseY, choX, choY) < 25 && upgrade >= 10) {
      upgrade = upgrade - 10;
      chips++;
    } else if (dist(mouseX, mouseY, choX, choY) > 25) {
      upgrade = upgrade + 0;
    }
  }
}
