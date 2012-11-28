class Slider
{
  PVector pos;
  PVector knobPos;
  PVector knobSize;
  float length;
  float minVal, maxVal;
  float val;
  float oldVal;
  boolean clicked = false;
  String name;
  Slider(String name, PVector p, float mi, float ma, float len)
  {
    this.name = name;
    pos = p;
    length  = len;
    minVal = mi;
    maxVal = ma;
    val = maxVal/2;
    knobPos = new PVector(pos.x+length/2, pos.y);
    knobSize = new PVector(10, 10);
  }

  void action()
  {

    if (knobPos.x > pos.x+length) {
      knobPos.x = pos.x+length;
    }

    if (knobPos.x < pos.x) {
      knobPos.x = pos.x+1;
    }
    oldVal = val;
    val = map(knobPos.x, pos.x, pos.x+length, minVal, maxVal);
    display();
  }

  void display()
  {
    textAlign(LEFT);
    fill(0);
    text(name, pos.x+length, pos.y);
    text(val, pos.x, pos.y);
    fill(255);
    rect(pos.x, pos.y, length, 10);
    fill(128, 128, 128);
    rect(knobPos.x-knobSize.x/2, knobPos.y, knobSize.x, knobSize.y);
  }

  float getVal() 
  {
    return val;
  }
  boolean valChanged()
  {
    if (oldVal != val)
      return true;
    else return false;
  }
  void handleMouse(int x, int y)
  {
    if (pointInRect(new PVector(x, y), pos, new PVector(pos.x+length, knobSize.y)))
    {
      knobPos.x = mouseX;
    }
  }
}

class Button
{ 
  PVector pos;
  PVector size;
  String txt;
  Button(PVector pos, PVector size)
  {
    this.pos = pos;
    this.size = size;
  }

  void action()
  {
  }

  void display()
  {
    fill(128);
    rect(pos.x, pos.y, size.x, size.y);
    fill(0);
    textAlign(CENTER);
    text(txt, pos.x+size.x/2, pos.y+size.y/2);
  }

  boolean clicked()
  {
    if (pointInRect(new PVector(mouseX, mouseY), pos, size) && mousePressed)
    {
      mousePressed = false;
      return true;
    }
    return false;
  }
}


class SaveButton extends Button
{
  SaveButton(PVector pos, PVector size)
  {
    super(pos, size);
    txt = "Save";
  }

  void action()
  {
    if (clicked()) {
      savePointData(sPts, "Data.txt", "Shape");
    }
    display();
  }
}

class LoadButton extends Button
{
  LoadButton(PVector pos, PVector size)
  {
    super(pos, size);
    txt = "Load";
  }

  void action()
  {
    if (clicked()) {
      // loadImageFile();
    }

    display();
  }
}

