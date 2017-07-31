class Road{
  
  ArrayList <PVector> roadBorders = new ArrayList(); // used to keep track of previous vertices
  ArrayList <PShape> road = new ArrayList();
  
  float road_height = - 40;
  float road_width = 3;
  color road_color = color(#554040);
  
  int strips_width;
  int strip_index = 0;
  
  
  public Road(int strips_width, int road_width){
    this.strips_width = strips_width;
    this.road_width = road_width;
  }
  
  
  void display(){
    for (int i=0; i<road.size(); i++){
      pushMatrix();
      translate(0, 0, (tile_length)*i + strip_index*(tile_length));
      shape(road.get(i));
      popMatrix();
    }
  }
  
  // adds a road strip. 
  void update(){
    road.add(createRoadStrip());
    strip_index++;
    if (road.size()>strips_num) { // remove a part of the road if it went too far behind us
      road.remove(0);
      roadBorders.remove(0);
    }
  }
  
  /*
      s.vertex(roadBorders.get(roadBorders.size()-1).y, road_height, 0);
    s.vertex(roadBorders.get(roadBorders.size()-1).x, road_height, 0);
    s.vertex(((strips_width/2 + curveValue) - road_width)*tile_length, road_height, tile_length);
    s.vertex(((strips_width/2 + curveValue) + road_width)*tile_length, road_height, tile_length);
  */
  
  // creates the actual pshape of a part of the road
  PShape createRoadStrip(){  
    
    int lineSize = 30;
    
    PShape s = createShape();
    s.beginShape(QUAD_STRIP);
    s.noStroke();
    s.fill(road_color);
    
    float tile_step = road_width/tile_length;
    int total_count = (int)(road_width/tile_step);
    
    for (float i=0; i<road_width; i+=tile_step){
      if (i==tile_step*2 || i==tile_step*5) s.fill(150);
      else s.fill(road_color);
      s.vertex(roadBorders.get(roadBorders.size()-1).y + lineSize*i*3, road_height, 0);
      s.vertex(((strips_width/2 + curveValue) + road_width)*tile_length + lineSize*i*3, road_height, tile_length);
    }
    
    /*
    s.vertex(roadBorders.get(roadBorders.size()-1).y, road_height, 0);
    s.vertex(((strips_width/2 + curveValue) + road_width)*tile_length, road_height, tile_length);
    
    s.fill(255);
    s.vertex(roadBorders.get(roadBorders.size()-1).y + lineSize, road_height, 0);
    s.vertex(((strips_width/2 + curveValue) + road_width)*tile_length + lineSize, road_height, tile_length);
    
    s.vertex(roadBorders.get(roadBorders.size()-1).y + lineSize*2, road_height, 0);
    s.vertex(((strips_width/2 + curveValue) + road_width)*tile_length + lineSize*2, road_height, tile_length);*/
    
    /*
    s.vertex(roadBorders.get(roadBorders.size()-1).x, road_height, 0);
    s.vertex(((strips_width/2 + curveValue) - road_width)*tile_length, road_height, tile_length);
    s.vertex(((strips_width/2 + curveValue) + road_width)*tile_length, road_height, tile_length);*/
    
    roadBorders.add(new PVector((strips_width/2 + curveValue - road_width)*tile_length, (strips_width/2 + curveValue + road_width)*tile_length));
    s.endShape();
    
    return s;
  }
}