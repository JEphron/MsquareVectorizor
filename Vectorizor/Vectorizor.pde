// ProcoVect!
// An image vectorizor frontend in processing 

// Important thingys:
PImage img;
Path p;
MarchingSquares m;
Slider s,s2, sr, sg, sb;
ArrayList points; // original point list
ArrayList sPts; // simplified point list
color col;
PVector pos; // center
SaveButton saveButton;
// Less important user moddable variables:
int simplificationFactor = 12; // less = more points
int blackPoint = 200;          // Selects the brightness to use as a cutoff
String pathToSaveData = "pointData.txt"; // where to save data
String imageName  = "tree21.gif"; // where to load the pixels from...

void setup()
{
  size(900, 600);
  // choose which image to load
  img = loadImage(imageName);
  pos = new PVector(width/2, height/2);
  img.resize(0,200);
  s  = new Slider("Simplification Factor", new PVector(30, 30), 1, 200, 200);
  s2 = new Slider("Black Point", new PVector(30, 90), 1, 255, 200);
  sr = new Slider("Red", new PVector(width-305, 30), 0, 255, 200);
  sg = new Slider("Green", new PVector(width-305, 90), 0, 255, 200);
  sb = new Slider("Blue", new PVector(width-305, 150), 0, 255, 200);
  saveButton = new SaveButton(new PVector(width - 305, 180), new PVector(55,30));
  
  doMarchingSquares(img, blackPoint, simplificationFactor, pathToSaveData);
}


void draw()
{
  background(200);
  // draw resulting simplified path
  image(img, 0, 0+height/2);
  fill(col);
  drawPointArray(sPts, pos);

  if (s.valChanged())
  {
    simplificationFactor = (int)s.getVal();
    doMarchingSquares(img, blackPoint, simplificationFactor, pathToSaveData);
  }
  if (s2.valChanged())
  {
    blackPoint = (int)s2.getVal();
    doMarchingSquares(img, blackPoint, simplificationFactor, pathToSaveData);
  }
  if (sr.valChanged())
  {
    col = color( sr.getVal(), green(col), blue(col));
  }
  if (sg.valChanged())
  {
    col = color(red(col), sg.getVal(), blue(col));
  }
  if (sb.valChanged())
  {
    col = color(red(col), green(col), sb.getVal());
  }

  s.action();
  s2.action();
  sb.action();
  sg.action();
  sr.action();
  saveButton.action();
  if (mousePressed) {
    s.handleMouse(mouseX, mouseY);
    s2.handleMouse(mouseX, mouseY);
    sr.handleMouse(mouseX, mouseY);
    sg.handleMouse(mouseX, mouseY);
    sb.handleMouse(mouseX, mouseY);
  }
  fill(0);
  text("PointCount: "+sPts.size(), 50, 60);
  fill(200);
}

