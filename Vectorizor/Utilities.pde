//-------//-------//-------//-------//-------//-------//-------//
// Functions that help get things done.                        //
//-------//-------//-------//-------//-------//-------//-------//

//---------------------------------------------------------------
// return a list of every Nth point
ArrayList simplifyPath(ArrayList path, int n)
{  
  ArrayList temp = new ArrayList();
  for (int i = 0; i < path.size(); i++)
  {
    if (i%n == 0)
      temp.add(path.get(i));
  }
  return temp;
}

//---------------------------------------------------------------
// simple drawing method
void drawPointArray(ArrayList p, PVector pos)
{
  beginShape();
  for (int i = 0; i < p.size(); i++)
  {
    vertex((PVector)p.get(i), pos);
  }
  endShape(CLOSE);
}

//---------------------------------------------------------------
// output the array to a file in the form of a processing function
void savePointData(ArrayList p, String datPath, String functionName)
{
  PrintWriter output;
  output = createWriter(datPath); 
  output.println("void draw"+functionName+"(PVector pos){");
  output.println("beginShape();");
  for(int i = 0; i < p.size(); i++)
  {
    output.print("vertex("+(int)((PVector)p.get(i)).x + "+pos.x," + (int)((PVector)p.get(i)).y+"+pos.y);");
    if(i%5==0)
    output.println("");
  }
  output.println("\nendShape(CLOSE);");
  output.println("}");
  output.flush();
  output.close();
  println("Data written to " +datPath + "...");
}

//---------------------------------------------------------------
// override with pvectors and offset
void vertex(PVector p, PVector o)
{
  curveVertex(p.x+o.x, p.y+o.y);
}

//---------------------------------------------------------------
// convert an image to a binary array.
byte[] toBinary(PImage b, float tolerance)
{
  byte[] temp = new byte[b.pixels.length];
  for (int i = 0; i < b.pixels.length; i++)
  {
    if (brightness((color)b.pixels[i]) < tolerance) {
      temp[i] = 1;
    }
    else {
      temp[i] = 0;
    }
  }
  return temp;
}

//---------------------------------------------------------------
// Check if a point is in a rectangle.
boolean pointInRect(PVector pt, PVector pos, PVector s)
{
  if (pt.x >= pos.x && pt.x < s.x+pos.x && pt.y >= pos.y && pt.y <= s.y+pos.y)
  {
    return true;
  }
  return false;
}

