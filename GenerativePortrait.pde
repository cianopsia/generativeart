//Alva Vidal Capon, 2021
//Comments are in spanish 

//Diseño generativo a partir de un retrato

int startDiam = 10; //Declaramos las variables que utilizaremos en la construcción de nuestros arcos
int diam = startDiam;
int arcStep = 1;
int speedGrow = 2;
int maxAngle = 300; //Por ejemplo, el ángulo máximo de apertura (que después controlaremos con random())
color [] arcClr = new color[maxAngle];  //O un array para el color que utilizaremos en el arco
PImage img; //Utilizamos un objeto predefinido "image"

void setup() {
  img = loadImage("BASEE.jpg"); //cargamos la imagen
  size(800, 800);
  image(img, 0, 0);
  frameRate(5); //definimos la velocidad de refresco, que en este caso queremos lenta
  text("Press S to save capture. Press R to randomize.",400,700); //Agregamos una breve instrucción para la interacción
}

void draw() {
  
  //Creamos una estructura condicional para definir qué sucede a partir del punto 0 del programa
  if (millis()> 0 ) { //con millis() controlamos el paso del tiempo, y damos inicio a las acciones después del momento 0 
    int mouseZ = (int)random(800); //Creamos variables auxiliares donde almacenamos valores con random() - que en este caso convertiremos con (int) por cuestiones de compatibilidad
    int mouseZZ = (int)random(800);
    arcCircle((int)mouseZZ, (int)mouseZ, diam+=speedGrow, arcStep); //Definimos algunos puntos del arco con dichas variables para hacer que el programa genere diferentes constituciones de arco aleatoriamente
    // Algunos de los parámetros están definidos por funciones construidas separadamente que llamaremos para la formación del arco
}
  else {
    diam = startDiam; //Agregamos una alternativa aunque no será utilizada después de 0
  }
}

void keyPressed() { //Agregamos interacciones de teclado  
  if (key == 's') { //Una para capturar la imagen generada y guardarla en un jpg
    saveFrame("img-###" + (int)random(100, 700) +".jpg"); 
  } else if (key == 'r') { //Y otra para randomizar los arcos de forma brusca
    for (int i = (int)random(5, 55); i >= 0; --i) {        //para ello utilizamos un bucle for que itera sobre todos los elementos con parámetros aleatorios
      int x = (int)random(0, img.width-1); //creamos, como en el caso anterior, variables random que usaremos como parámetros para construir el arco
      int y = (int)random(0, img.height-1);
      int size = (int)random(img.width/10, img.width/5);

      for (int j = 0; j < 1; j++) { //Construimos el arco con estos parámetros
        arcCircle(x, y, size, 1);
      }
    }
  }
}

void arcCircle(int cirlX, int cirlY, int diamRaduis, int arcStep) { //Generamos una función propia para construir los arcos, que llamaremos en cada contexto en el que queramos introducirlos
  int angle = (int)random(360); //Creamos variables auxiliares para definir elementos como el ángulo o diámetro de los arcos
  int speed = arcStep;
  int arcRadius = diamRaduis/2;
  int x, y;

  noStroke();
  fill(255);

  while (angle< maxAngle) { //Mientras se cumpla la condición de que el arco generado se mantiene en los límites que hemos marcado, generamos
    x = int(cirlX + cos(radians(angle)) * arcRadius); //Aplicamos trigonometría para almacenar en variables los puntos clave de nuestro arco (que es una circunferencia en potencia)
    y = int(cirlY + sin(radians(angle)) * arcRadius);
    color clr = img.get(x, y); //almacenamos en un tipo de dato "color" los colores recogidos en estas variables
    arcClr[angle] = clr; //Asignamos el color recogido al elemento [angle] de nuestro array
    

    fill(arcClr[angle]); //REllenamos el espacio con este valor
    float radSrt = radians(angle); //Finalmente
    float radEnd = radians(angle+arcStep);
    arc(cirlX, cirlY, diamRaduis, diamRaduis, radSrt, radEnd); //Finalmente, dibujamos los arcos valiéndonos de las variables construidas anteriormente
    arc(cirlX, cirlY, diamRaduis, diamRaduis, radSrt, radEnd);
    angle += speed; //Y definimos el incremento de velocidad de creación de los arcos
  }
}


//Nota: Las referencias para estre trabajo son el material de la asignatura, la guía oficial de Processing por Daniel Schiffman (incluido el canal de Youtube), 
//los materiales de la asignatura anterior de Diseño de Interacción, y los repositorios de OpenProcessing como los de Julian Hoffman o Lee Daniel WHitelock
