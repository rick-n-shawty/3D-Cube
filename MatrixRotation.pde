float angle = 0; 
float scale = 1; 
float [][] projection = {
  {1,0,0},
  {0,1,0},
  {0,0,1}
};
PVector [] vectors = new PVector[8]; 
void setup(){
  size(900, 600); 
  background(0);
  vectors[0] = new PVector(-50, -50,0);
  vectors[1] = new PVector(50, -50,0);
  vectors[2] = new PVector(50, 50, 0);
  vectors[3] = new PVector(-50, 50, 0);
  
  vectors[4] = new PVector(-50, -50, 100);
  vectors[5] = new PVector(50, -50, 100);
  vectors[6] = new PVector(50, 50, 100);
  vectors[7] = new PVector(-50, 50, 100);

}

void draw(){
  background(0); 
  translate(width / 2, height / 2);
  strokeWeight(12);
  stroke(0,150,0);
  float [][] rotationX = {
    {1, 0, 0},
    {0, cos(angle), -sin(angle)},
    {0,sin(angle), cos(angle)}
  }; 
  float[][] rotationY = {
    {cos(angle),0,sin(angle)},
    {0,1,0},
    {-sin(angle), 0, cos(angle)}
  };
  float[][] rotationZ = {
    {cos(angle), -sin(angle), 0},
    {sin(angle), cos(angle), 0},
    {0,0,1}
  }; 
  scale += 0.005;
  float[][] scaling = {
    {2.5*cos(scale), 0, 0},
    {0,2.5*cos(scale),0},
    {0,0,2.5*cos(scale)}
  };
  PVector [] newVectors = new PVector[8];
  int i = 0;
  for(PVector v : vectors){
    float[][] rotated = matmul(rotationY, v);
    rotated = matmul(rotationX, rotated);
    rotated = matmul(rotationZ, rotated);
    rotated = matmul(scaling, rotated);
    float[][] projected = matmul(projection, rotated);
    PVector newV = matToV(projected);
    point(newV.x, newV.y);
    newVectors[i] = newV;
    i++;
  }  
  strokeWeight(2);
  line(newVectors[0].x,newVectors[0].y,newVectors[1].x,newVectors[1].y);
  line(newVectors[0].x,newVectors[0].y,newVectors[3].x,newVectors[3].y);
  line(newVectors[0].x,newVectors[0].y,newVectors[4].x,newVectors[4].y);
  line(newVectors[1].x,newVectors[1].y,newVectors[2].x,newVectors[2].y); 
  line(newVectors[2].x,newVectors[2].y,newVectors[3].x,newVectors[3].y);
  line(newVectors[3].x,newVectors[3].y,newVectors[7].x,newVectors[7].y);
  line(newVectors[4].x,newVectors[4].y,newVectors[5].x,newVectors[5].y);
  line(newVectors[4].x,newVectors[4].y,newVectors[7].x,newVectors[7].y);
  line(newVectors[5].x,newVectors[5].y,newVectors[6].x,newVectors[6].y);
  line(newVectors[5].x,newVectors[5].y,newVectors[1].x,newVectors[1].y);
  line(newVectors[7].x,newVectors[7].y,newVectors[6].x,newVectors[6].y);
  line(newVectors[6].x,newVectors[6].y,newVectors[2].x,newVectors[2].y);
  
  angle += 0.02;
}

float[][] matmul(float[][] a, PVector B){
  float[][] b = vToMat(B);
  return matmul(a, b);
}

float[][] matmul(float[][] a, float[][] b){ 
  int rowsA = a.length; 
  int colsA = a[0].length; 
  int rowsB = b.length; 
  int colsB = b[0].length;
  
  float[][] result = new float[rowsA][colsB];

  if(colsA != rowsB){
    System.out.println("Columns of A do not match the rows of B");
    return null;
  }
  float sum = 0; 
  for(int i = 0; i < rowsA; i++){
    for(int j = 0; j < colsB; j++){
      sum = 0; 
      for(int k = 0; k < colsA; k++){
        sum += a[i][k] * b[k][j]; 
      }
      result[i][j] = sum;
    }
  } 
  return result;
}

PVector matToV(float[][] a){
  float x = a[0][0];
  float y = a[1][0]; 
  float z = 0;
  if(a.length > 2){
      z = a[2][0]; 
  }
  return new PVector(x,y,z);
}
float[][] vToMat(PVector v){
  float[][] arr = new float[3][1];
  arr[0][0] = v.x;  
  arr[1][0] = v.y;
  arr[2][0] = v.z;
  return arr;
}
