/* Variable declarations */
import gifAnimation.*;
GifMaker gifExport;

int nheights=6;
int cmax=255;
int[] cmap_bg= new int[nheights+1]; //For BW
color[] cmap = new color[10];

int frameNum=0;
float t=1;

/* Method definitions */
int color_bucket(int val, int max, int bins){
 int bucket= int(1.*val*bins/max);
  return bucket; 
}

void setup() {
 size(640,480);
 background(0);
 frameRate(30);

 for(int index=0;index<cmap.length;index++)
   cmap[index]= 255*index/nheights;
 //println(cmap);
  gifExport = new GifMaker(this, "cmap_red.gif");
  gifExport.setRepeat(0);  // make it an "endless" animation

cmap[0]=#ffffff;
cmap[1]=#ffffff;
cmap[2]=#f51135;
cmap[3]=#ba0824;
cmap[4]=#ba0824;
cmap[5]=#9a061d;

}

void draw() {
loadPixels();
// Start xoff at 0.

  float xoff = 0.0; //[bold]
for (int x = 0; x < width; x++) {
  // For every xoff, start yoff at 0.
  float yoff = 0.0; //[bold]
  for (int y = 0; y < height; y++) {
    // Use xoff and yoff for noise().
    //println(noise(xoff,yoff,t));
    int bright = int(map(noise(xoff,yoff,t),0,1,0,255)); //[bold]
    // Use x and y for pixel location.
    //println("act"+bright);
    bright= color_bucket(bright,cmax, nheights);
    //println("bucket"+bright);
    pixels[x+y*width] = color(cmap[bright]);
    //pixels[x+y*width] = color(bright);
    // Increment yoff.
    yoff += 0.009; //[bold]
  }
  // Increment xoff.
  xoff += 0.009;  //[bold]
}

updatePixels();
gifExport.setDelay(1);
gifExport.addFrame();
if(frameNum== 240){
  gifExport.finish();
  //exit();
 }
t+=0.01;
frameNum++;
}