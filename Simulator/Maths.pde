// Funções matemáticas e geométricas

int find(int [] vector, int value) {
  // Encontra o índice de um valor no vetor
  
  int index = -1;
  
  for(int i = 0; i < vector.length; i++) {
    if(vector[i] == value) {
      index = i;
      break;
    }
  }
  
  return index;
}

float[][] multMatrix(float[][] m1, float[][] m2) {
  // Retorna a multiplicação entre m1 e m2
  
  // supoe que as matrizes são multiplicáveis e não vazias
  if(m1.length == 0 || m1[0].length != m2.length) {
    float[][] err = {{-1}, {-1}};
    return err;
  }
    
  float [][] res = new float[m1.length][m2[0].length];
  for(int i = 0; i < m1.length; i++) {
    for(int j = 0; j < m2[0].length; j++) {
      for(int k = 0; k < m2.length; k++) {
        res[i][j] += m1[i][k] * m2[k][j];
      }
    }
  }
  return res;
}

float[][] copyMatrix(float[][] m, int initRows, int initCols, int rows, int cols) {
  // Copia uma matriz m para uma nova matriz com dimensões [rows][cols]
  
  float[][] tempMatrix = new float[rows][cols];
  
  if(m.length > 0) {
    for(int i = initRows; i < rows; i++) {
      for(int j = initCols; j < cols; j++) {
        if(i < m.length && j < m[0].length) {
          tempMatrix[i][j] = m[i][j];
        }
        // else tempMatrix[i][j] = 0
      }
    }
  }
  
  return tempMatrix;
}

int[][] copyMatrix(int[][] m, int initRows, int initCols, int rows, int cols) {
  // Copia uma matriz m para uma nova matriz com dimensões [rows][cols]
  
  int[][] tempMatrix = new int[rows][cols];
  
  if(m.length > 0) {
    for(int i = initRows; i < rows; i++) {
      for(int j = initCols; j < cols; j++) {
        if(i < m.length && j < m[0].length) {
          tempMatrix[i][j] = m[i][j];
        }
      }
    }
  }
  
  return tempMatrix;
}

float[][] rotateMatrix(float[][] vertices, PVector rotation) {
  // Recebe um float[][4] e um PVector de rotação em (x, y, z) e retorna a lista de pontos rotacionada
  float xn, yn, zn, t;

  float[][] normalMatrix = {
    {1, 0, 0, 0},
    {0, 1, 0, 0},
    {0, 0, 1, 0},
    {0, 0, 0, 1}
  };

  float[][] rotationXN = {
    {1, 0, 0, 0},
    {0, cos(rotation.x), sin(rotation.x), 0},
    {0, -sin(rotation.x), cos(rotation.x), 0},
    {0, 0, 0, 1}
  };
  float[][] rotationYN = {
    {cos(rotation.y), 0, -sin(rotation.y), 0},
    {0, 1, 0, 0},
    {sin(rotation.y), 0, cos(rotation.y), 0},
    {0, 0, 0, 1}
  };
  float[][] rotationZN = {
    {cos(rotation.z), sin(rotation.z), 0, 0},
    {-sin(rotation.z), cos(rotation.z), 0, 0},
    {0, 0, 1, 0},
    {0, 0, 0, 1}
  };

  vertices = multMatrix(vertices, rotationXN);
  vertices = multMatrix(vertices, rotationYN);
  vertices = multMatrix(vertices, rotationZN);

  return vertices;
}

float[][] scaleMatrix(float[][] vertices, PVector scale) {
  // Recebe um float[][4] e um PVector de escala em (x, y, z) e retorna a lista de pontos reescalada
  
  for(int i = 0; i < vertices.length; i++) {
    for(int j = 0; j < 3; j++) {
      vertices[i][j] *= scale.array()[j];
    }
  }
  
  return vertices;
}

float[][] translateMatrix(float[][] vertices, PVector translation) {
  // Recebe um float[][4] e um PVector de translação em (x, y, z) e retorna a lista de pontos transladada
  
  for(int i = 0; i < vertices.length; i++) {
    for(int j = 0; j < 3; j++) {
      vertices[i][j] += translation.array()[j];
    }
  }
  
  return vertices;
}

float[][] homogeneousToCartesian2D(float[][] vertices) {
  // Recebe um float[][4] e retorna um float[][2]
  
  float[][] tempVertices = new float[vertices.length][2];
  
  for(int i = 0; i < tempVertices.length; i++) {
    for(int j = 0; j < 2; j++) {
      if(vertices[i][3] == 0) {
        continue;
      }
      tempVertices[i][j] = vertices[i][j]/(float)vertices[i][3];
    }
  }
  
  return tempVertices;
}
