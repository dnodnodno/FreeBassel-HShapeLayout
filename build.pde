import processing.pdf.*;

HDrawablePool pool;
HColorPool colors;

boolean record = false;


	int s = second(); 
	int m = minute();
	int h = hour();

void setup(){
	size(600,600);
	H.init(this).background(#202020);
	smooth();
	//color pool to fill SVGs with 
	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	pool = new HDrawablePool(300);
	pool.autoAddToStage()
		//add SVG to be replicated over shapeMape
		.add(new HShape("bassel.svg"))
		//add as many SVGs as desired
	        //.add(new HShape("svg1.svg"))

		.layout(
			new HShapeLayout()
			.target(
				//make sure the shape map is the same size as the sketch
				new HImage("syria-shapemap-600.png")
			)
		)

		.onCreate(
			new HCallback() {
				public void run(Object obj) {
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.noStroke()
						.anchorAt(H.CENTER)
						.size( (int)random(10,30) )
						.rotate( (int)random(360) )
					;
					d.randomColors(colors.fillOnly());
				}
			}
		)
		.requestAll()
	;

saveVector();
	noLoop();

}
 
 void draw() {
	H.drawStage();
}
//export PDF 
void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, h + "-" + m + "-" + s + "-" +  "render.pdf");
	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	}

	endRecord();
}
