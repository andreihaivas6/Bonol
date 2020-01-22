int l = 0;
import processing.sound.*;
SoundFile fileMusic, filePiece, fileButton, fileWin;

PImage[][] tutorialImages = new PImage[4][3];
PFont myFont;

int rezolutie = 1;
int language = 0;
int window = 0;
float[][] labelCoord = new float[20][2];
float[][] buttonCoord = new float[20][4];
// 0 -> x;   2 -> width 
// 1 -> y;   3 -> height
float[][] arrowCoord = new float[20][3];
// 0, 1 -> x, y
// 2 -> 0 - stanga; 1 - dreapta;
int[][] arrowValue = new int [10][2];
// 0 -> valoare indice
// 1 -> nr total indici posibili
// indice minim mereu 0;

float dim, dimLitera;
boolean cursorHand = false;
boolean mouseIsPressed = false, mouseIsReleased = false;
int nrPagina = 0, nrTotalPagini = 4;
int scor1 = 0, scor2 = 0;
float time, startTime = 0;
int min, sec, miliSec;
int[][] auxBoard = 
{
  {-1, 2, 2, 0},
  {0, 1, 2, 0},
  {0, 1, 2, 0},
  {0, 1, 1, -1}
};
int dificultate;
boolean youSure = false;
int contor = 2;
boolean ok = false;
int[][] vectSafe = new int[20][2];
int[][] vectKiller = new int[20][2];
int lungS, lungK;
boolean aplied = false;
int volumSound = 3, volumMusic = 2;
int colorBg = 0, colorP1 = 0, colorP2 = 0, colorP3 = 0;
int[] ColorBg = {#EFF0DA, #FF9393, #CFFF00};
int[] ColorP1 = {#FF0000, #0AA294, #FF9900};
int[] ColorP2 = {#0700FF, #0AE807, #BC1CA7};
int[] ColorP3 = {#050505, #741010, #715201};
int[] colNotHover = {210, 210, 210}, colHover = {170, 170, 170};
String[] Language = {"RO", "EN", "FR"};
String[][] playerName = 
{
  {"Jucator1", "Player1", "Joueur1"},
  {"Jucator2", "Player2", "Joueur2"}
};
String[] name = new String[2];
float[][] nameCoord = new float[2][2];
int index = -1;
int[][] movesPC = new int[32][6];
// 0 -> 0 - pt verticala; 1 - pt orizontala;
// 1 -> x_mat;  2 -> y_mat
// 3 -> x_colt; 4 -> y_colt
// 5 -> valoare matrice
int nrMoves = 0, indice;
boolean find, gasit;
int[][] mutare = new int[4][2];
int[][] mat = new int[3][3];
int[][][] auxMat = 
{
  {
    {0, 3, 0},
    {0, 3, 0},
    {0, 3, 0}
  },
  {
    {0, 0, 0},
    {3, 3, 3},
    {0, 0, 0}
  }
};
int[][] colt = {{0, 0}, {0, 2}, {2, 0}, {2, 2}};
int var1, var2, sol;
int[][] poz0 = new int[12][2];
int[][] poz1 = new int[12][2];
int lung0 = 0, lung1 = 0;
String txt = "", txt1 = "";
int i, j;

int[][] resolution = 
{
  {640 , 480},
  {800 , 600},
  {1024, 700},
  {1366, 768}
};

int[][] buttonOnWindow = 
{
  //buttons[i][0] -> nr de butoane
  {5, 1, 2, 3, 4, 5},
  {4, 6, 7, 0, 13},
  {4, 8, 9, 0, 13},
  {5, 10, 11, 12, 0, 13},
  {1, 0}, // 13 14
  {2, 15, 0},
  {2, 15, 0},
  {1, 0}, // 16, 17
  {1, 0}, // 16, 17
  {1, 0}  // 16, 17
};

int[][] labelOnWindow = 
{
  {2, 0, 1},
  {0},
  {0},
  {0},
  {0},
  {4, 5, 6, 7, 8},
  {4, 9, 10, 11, 12}, // 15 cronometru
  {2, 2, 3}, // 4
  {2, 2, 3}, // 4
  {2, 2, 3}  // 4
};

String[][] buttonName = 
{
  {"meniu", "menu", "menu"},
  {"joaca", "play", "jouer"},
  {"tutorial", "tutorial", "tutoriel"},
  {"setari", "settings", "parametres "},
  {"configurare", "configure", "configurer"},
  {"afara ", "exit", "dehors"},
  {"Jucator vs Jucator", "Player vs Player", "Joueur vs Joueur"},
  {"Jucator vs Calculator", "Player vs Computer", "Joueur vs Ordinateur"},
  {"normal ", "normal ", "normal "},
  {"special", "special", "special"},
  {"usor", "easy", "facile"},
  {"greu", "hard", "complique"},
  {"personalizat", "custom", "coutume"},
  {"inapoi", "back", "dos"},
  {"inainte", "next", "avant "},
  {"aplica", "apply", "appliquer"},
  {"omite", "skip", "saute"},
  {"joaca", "play", "jouer"},
  {"nu", "no", "non"},
  {"da", "yes", "oui"}
};

String[][] labelName = 
{
  {"bun venit", "welcome", "bienvenue"},
  {"in bonol", "to bonol", "a bonol"},
  {"scor", "score", "score"},
  {"Tura lui", "Turn of", "Tour de"},
  {"a castigat!", "won!", "a gagne!"},
  {"sunet:", "sound:", "son:"},
  {"muzica:", "music:", "musique:"},
  {"limba:", "language:", "langue:"},
  {"rezolutie:", "rezolution:", "rezolution:"},
  {"fundal:", "background:", "fond:"},
  {"piesa1:", "piece1:", "piece1:"},
  {"piesa2:", "piece2:", "piece2:"},
  {"piesa3:", "piece3:", "piece3:"},
  {"Jucator vs Jucator", "Player vs Player", "Joueur vs Joueur"},
  {"Jucator vs Calculator", "Player vs Computer", "Joueur vs Ordinateur"},
  {"Esti sigur?", "Are you sure?", "Tu es sur?"}
};
