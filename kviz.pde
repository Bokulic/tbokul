Question q;

void setup() {
  size(600, 400);
  make_images();
  set_positions();
  new_question();
}

void draw() {
  background(0);
  q.draw();
  text("Score: " + score + " / " + total, width/2, 70);
}

void mousePressed() {
  q.click();
}

// --- DO NOT SCROLL BEYOND THIS POINT ---

class AnswerChoice {
  float x, y, w, h;
  int i;
  boolean c;
  AnswerChoice(int position, int image, boolean correct_answer) {
    x = xs[position];
    y = ys[position];
    i = image;
    w = images[image].width;
    h = images[image].height;
    c = correct_answer;
  }
  void draw() {
    imageMode(CENTER);
    image(images[i], x, y);
  }
  boolean over() {
    return( x-w/2 < mouseX && mouseX < x+w/2 && y-h/2 < mouseY && mouseY < y+h/2 );
  }
  void click() {
    if ( over() ) {
      if ( c ) {
        score++;
        //state = won_state;
      } else {
        //state = lost_state;
      }
      new_question();
    }
  }
}

class Question {
  String s;
  AnswerChoice[] acs;
  Question(String questionText, int correctChoice ) {
    s = questionText;
    acs = new AnswerChoice[6];
    int correct_position = int(random(acs.length));
    for ( int ps = 0; ps < acs.length; ps++) {
      if ( ps == correct_position ) {
        acs[ps] = new AnswerChoice( ps, correctChoice, true );
      } else {
        int randoChoice = correctChoice;
        while ( randoChoice == correctChoice ) {
          randoChoice = int(random(images.length));
        }
        acs[ps] = new AnswerChoice( ps, randoChoice, false );
      }
    }
  }
  void draw() {
    fill(255);
    textAlign(CENTER);
    text(s, width/2, 40);
    // Draw all possible answers.
    for ( int ac = 0; ac < acs.length; ac++) {
      acs[ac].draw();
    }
  }
  void click() {
    for ( int ac = 0; ac < acs.length; ac++) {
      acs[ac].click();
    }
  }
}

color[] colors = { color(255), color(128), color(0), color(200, 0, 0), color(200, 200, 0), color(0, 200, 0), color(0, 0, 200), color(200, 0, 200) };
String[] color_names = { "white", "grey", "black", "red", "yellow", "green", "blue", "pink"};
PImage[] images = new PImage[32];
String[] names = new String[32];
void make_images() {
  int sx = 0;
  for ( int cx = 0; cx < colors.length; cx++) {
    color c = colors[cx];
    fill(64);
    stroke(196);
    rect(0, 0, 120, 80);
    fill(c);//0, 200, 0);
    noStroke();
    ellipse(60, 40, 70, 70);
    images[sx] = get(0, 0, 121, 81);
    names[sx] = color_names[cx] + " circle";
    sx++;

    fill(64);
    stroke(196);
    rect(0, 0, 120, 80);
    fill(c);//
    noStroke();
    rect(20, 15, 80, 50);
    images[sx] = get(0, 0, 121, 81);
    names[sx] = color_names[cx] + " rectangle";
    sx++;

    fill(64);
    stroke(196);
    rect(0, 0, 120, 80);
    fill(c);
    noStroke();
    pushMatrix();
    translate(60, 40);
    triangle(-20, 20, 0, -25, 20, 20);
    popMatrix();
    images[sx] = get(0, 0, 121, 81);
    names[sx] = color_names[cx] + " triangle";
    sx++;

    fill(64);
    stroke(196);
    rect(0, 0, 120, 80);
    fill(c);
    noStroke();
    rect(35, 15, 50, 50);
    images[sx] = get(0, 0, 121, 81);
    names[sx] = color_names[cx] + " square";
    sx++;
  }
}

float[] xs = new float[6];
float[] ys = new float[6];
int score;
int total = -1;

void new_question() {
  int rq = int(random(4));
  q = new Question("Click on the " + names[rq] + "!", rq);
  total++;
}

void set_positions() {
  xs[0] = xs[3] = width/4;
  xs[1] = xs[4] = width/2;
  xs[2] = xs[5] = 3*width/4;  
  ys[0] = ys[1] = ys[2] = 2*height/4;
  ys[3] = ys[4] = ys[5] = 3*height/4;
}
