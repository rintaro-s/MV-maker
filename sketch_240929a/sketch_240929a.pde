import ddf.minim.*;
PImage bg;
Minim minim;
AudioPlayer player;

void setup() {
  size(1200, 600);
  minim = new Minim(this);

  // 背景画像をロード
  bg = loadImage("loli.png");

  // 音声ファイルをロード
  player = minim.loadFile("hateyou.mp3", 1024);
  player.play();
}

void draw() {
  // 背景画像を描画
  image(bg, 0, 0, width, height);

  // 波形を描画
  stroke(255);
  for (int i = 0; i < player.bufferSize() - 1; i++) {
    float x1 = map(i, 0, player.bufferSize(), 0, width);
    float x2 = map(i+1, 0, player.bufferSize(), 0, width);
    line(x1, height/2 + player.left.get(i) * 50, x2, height/2 + player.left.get(i+1) * 60);
  }

  // リズムに合わせて動く円
  float amplitude = 0;
  for (int i = 0; i < player.bufferSize(); i++) {
    amplitude += abs(player.left.get(i));
  }
  amplitude /= player.bufferSize();
  float size = map(amplitude, 0, 0.5, 50, 200);
  
  fill(255, 100);
  noStroke();
  ellipse(width/2, height/2, size, size);
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
