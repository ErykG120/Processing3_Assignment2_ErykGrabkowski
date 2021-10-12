// Flappy Bird: Processing Edition - Eryk Grabkowski

// Libraries
import javax.swing.*; // Import swing library
import processing.sound.*; // Import sound library

// Global variables
int xBackground; // X axis background
int yBackground; // Y axis background
int[] xPipe = new int[4]; // xPipe Array of 4
int[] yPipe = new int[xPipe.length]; // yPipe Aray of 4
int Game; // Game State
int Points; // Game Points/Score
float xFlappy = 100; // X axis for flappy
float yFlappy = 50; // Y axis for flappy
float gravity = 0.5; // Gravity set to a float value of 0.5
float yVelocity; // Float Velocity
PFont FlappyBirdy; // Load custom font
PImage GameBackground; // Load custom background image
PImage FlappyBird; // Load flappy bird image
PImage TopPipe; // Load top pipe image
PImage BottomPipe; // Load down pipe image 
color background_color = color(92, 179, 207); // Blue Colour

// Load sounds
SoundFile music; // Load background music
SoundFile hit; // Load hit sound
SoundFile point; // Load point sound
SoundFile fall; // Load fall sound
SoundFile death; // Load death music

void setup() // Draw Once & Main Method
{
  // Initital Setup
  size(600, 600); // 600x600 pixels animations window
  frameRate(60); // Refreshes 60 frames per second
  smooth(); // Smooths all edges in animation
  background(background_color); // Changes colour to blue
  textAlign(CENTER); // Centers all text to draw from the middle

  // Background Music
  music = new SoundFile(this, "/audio/music.mp3"); // Background audio set to music.mp3 
  music.play(); // Play music.mp3
  music.loop(); // Loop music.mp3
  music.amp(0.25); // Set volume to 25%

  // Populating pipe array with values
  for (int i=0; i < xPipe.length; i++) // Int i = 0, 0 Less than xPipe length(4)
  {
    xPipe[i] = width + 200*i; // xPipe = Width + 200*i / Start at 0
    yPipe[i] = (int)random(-350, 0); // Converting Float to Int and random height between -350 and 0.
  }

  // Return Method
  String Easter1; // String Easter
  Easter1= EasterEgg1(); // Easter = EasterEgg Method
  String Easter2; // String Easter
  Easter2 = EasterEgg2(); // Easter = EasterEgg Method
  println(Easter1); // Print Easter1 to console
  println(Easter2); // Print Easter2 to console

  // Start
  WelcomeConsole(); // Calls "WelcomeConsole" Method
  Game = -1; // Calls GameState to be -1
}

void draw() // Draw constintly & Main Method
{
  if (Game == -1) // GameState = starting
  {
    StartGame(); // Calls StartGame Method
  } else if (Game == 00)   // Game state = playing
  {
    SetGameBackground(); // Background
    FlappyBird(-5); // Flappy Bird + Jump to -5/5
    Pipes(2); // Pipes + Set Speed to 2
    GameScore(); // Game Score
  } else // GameState = crashed into pipe
  {
    music.stop(); // Stop background music
    death = new SoundFile(this, "/audio/death.mp3"); // Background audio set to music.mp3 
    death.play(); // Play death.mp3
    death.loop(); // Loop death.mp3
    death.amp(0.25); // Set volume to 25%
    JOptionPane.showMessageDialog(null, "You died! " + "Score:  " + Points, "Flappy Bird", JOptionPane.WARNING_MESSAGE); // Displays JOptionPane death
    GameSurvey(); // Calls "GameSurvey" method
  }
}

void StartGame() // Starting Screen
{
  JOptionPane.showMessageDialog(null, "Welcome to Flappy Bird [Processing Edition] by Eryk Grabkowski!", "Flappy Bird", JOptionPane.PLAIN_MESSAGE); // Welcome Message
  int start = JOptionPane.showConfirmDialog(null, "Would you like to start?", "Flappy Bird", JOptionPane.YES_NO_OPTION); // Int Start = Yes/No

  if (start == 1) // If No (=1)
  {
    JOptionPane.showMessageDialog(null, "Have a good day! See you again!", "Flappy Bird", JOptionPane.PLAIN_MESSAGE); // Display closing message
    exit(); // Close program
  } else // If Yes (=0)
  {
    Game = 0; // Start the game
  }
}

void WelcomeConsole() // Welcome Message in console for do while statment x4
{
  int i = 0; // i = 0
  do // Execute
  {
    println("Welcome!"); // Print Welcome to console
    i++; // Add increment
  }
  while (i < 2); // While 0 less than 2
}

String EasterEgg1() // EasterEgg 1 + Return 1
{
  String Text1= "Hi There";
  String Text2= "How Are You?";
  String Text3= "*whistles*";
  String Easter1;
  
  Easter1 = Text1 + Text2 +Text3;

  return Easter1; // Return
}

String EasterEgg2() // EasterEgg 2 + Return 2
{
  String Easter2= "*Flap* *Flap* *Flap*";
  return Easter2; // Return
}

void SetGameBackground() // Background
{
  // Load background image
  GameBackground = loadImage("/img/GameBackground.png"); // Loads background image
  image(GameBackground, xBackground, yBackground); // Draws background image at 0,0
  image(GameBackground, xBackground + GameBackground.width, yBackground); // // Draws background again but 0 + the width of the image, 0
  xBackground = xBackground - 1; // Background(x0) = Background(x0) - 1; // Makes background move by taking away 1 from itself

  // Reset once image is done.
  if (xBackground < -GameBackground.width) // If Background(x0) is less than -ImageWidth
  {
    xBackground = 0; // Sets it to 0 pixels
  }
}

void FlappyBird(int Jump) // Flappy Bird
{
  // Load flappy bird image
  FlappyBird = loadImage("/img/FlappyBird.png"); // Loads flappy bird image
  image(FlappyBird, xFlappy, yFlappy); // Draws flappy bird image at 100 & 50 coordinates

  // Velocity & Gravity
  yFlappy = yFlappy + yVelocity; // Flappy Y Axis = Flappy Y Axis + Flappy Y Velocity
  yVelocity = yVelocity + gravity; // Flappy Y Velocity = Flappy Y Velocity + Gravity(0.5)

  // Click to stay in air
  if (mousePressed == true) // Check if mouse pressed 
  {
    yVelocity = Jump; // Go up 5 pixels
  } else if (keyPressed == true && key == ' ') // Space bar
  {
    yVelocity = Jump; // Go up 5 pixels
  } else if (keyPressed == true && key == 'w') // W key
  {
    yVelocity = Jump; // Go up 5 pixels
  } else if (keyPressed == true && key == 'W') // Capital W
  {
    yVelocity = Jump; // Go up 5 pixels
  } else if (keyPressed == true && keyCode == UP) // Up Arrow
  {
    yVelocity = Jump; // Go up 5 pixels
  }

  // Collision when you fall out of bounds
  if (yFlappy > height || yFlappy < -10) // If yFlappy is greater than the height OR yFlappy is less than -10
  {
    fall = new SoundFile(this, "/audio/fall.mp3"); // Background audio set to fall.mp3 
    fall.play(); // Plays fall.mp3
    fall.amp(0.25); // Set volume to 25%
    Game = 1; // Sets the game state to 1
  }
}

void Pipes(int speed) // Loads Pipes, set to speed of 3 up above
{
  // Load top and bottom pipes
  TopPipe = loadImage("/img/TopPipe.png"); // Load top pipe
  BottomPipe = loadImage("/img/BottomPipe.png"); // Load bottom pipe

  // While Loop
  int i=0; // i = 0
  while (i < xPipe.length) // i less than 4
  {
    image(TopPipe, xPipe[i], yPipe[i]); // Draw image of top pipe at xPipe and yPipe
    image(BottomPipe, xPipe[i], yPipe[i] + 600); // Draw image of bottom pipe at xPipe and yPipe + window size (positioning)

    xPipe[i]-= speed; // Set the speed using the variable up-top

    // "Infinite" Pipes
    if (xPipe[i] < -200) // If xPipe Less Than -200
    {
      xPipe[i] = width; // xPipe = width of screen/image
    }

    // Collision Detection
    if (xFlappy > (xPipe[i] - 15) && xFlappy < xPipe[i] + 100) // If xFlappy is greater than xPipe[i] - 15 and xFlappy is less than xPipe[i] + 100 wide
    {
      if (! /* ! means not */ (yFlappy > (yPipe[i] + 450) && yFlappy < yPipe[i] + (450 + 150-15))) // yFlappy greater than yPipe + 450 && yFlappy less than yPipe + 450 + (To make total game window)150-15
      {
        Game = 1; // GameState = Dead.
        hit = new SoundFile(this, "/audio/hit.mp3"); // Background audio set to hit.mp3 
        hit.play(); // Play hit.mp3
        hit.amp(0.25); // Set volume to 25%
      } else if (xFlappy == xPipe[i] || xFlappy == xPipe[i] + 1) // xFlappy == xPipe OR xFlappy =xPipe + 1, used to gain points every time you fit through a pipe
      {
        Points++; // Add points
        point = new SoundFile(this, "/audio/point.mp3"); // Background audio set to point.mp3 
        point.play(); // Play point.mp3
        point.amp(0.25); // Set volume to 25%
      }
    }
    i++; // Add increment
  }
}

void GameScore() // Game Score
{
  FlappyBirdy = createFont("FlappyBirdy.ttf", 32); // Load FlappyBirdy custom font ttf
  textFont(FlappyBirdy); // Calls custom font
  textSize(32); // Sets font size to 32
  fill(0);  // Changes colour to black
  text("Points: " + Points, 300, 25); // Draws "Points"
  text("Controls: 'W' OR 'UP' OR 'Space' OR 'Click'", 300, 595); // Draws "Controls"
}

void GameSurvey() // Game Survey
{
  int reply = JOptionPane.showConfirmDialog(null, "Thank you for playing the game, would you mind filling out this quick feedback survey :)", "Flappy Bird", JOptionPane.YES_NO_OPTION); // Int Reply = Yes Or No

  if (reply == 1) // If No (=1)
  {
    JOptionPane.showMessageDialog(null, "Have a good day! See you again!", "Flappy Bird", JOptionPane.PLAIN_MESSAGE); // Display ending message
    exit(); // Close the program
  } else // If Yes (=0)
  {
    int [] feedback = new int[5]; // New array of 5
    feedback[0] = Integer.parseInt(JOptionPane.showInputDialog(null, "On a scale of 1-5. how much did you enjoy the game?", "Flappy Bird", JOptionPane.QUESTION_MESSAGE)); // Question 1
    feedback[1] = Integer.parseInt(JOptionPane.showInputDialog(null, "On a scale of 1-5, how difficult was the game?", "Flappy Bird", JOptionPane.QUESTION_MESSAGE)); // Question 2
    feedback[2] = Integer.parseInt(JOptionPane.showInputDialog(null, "On a scale of 1-5, how much did you enjoy the audio?", "Flappy Bird", JOptionPane.QUESTION_MESSAGE)); // Question 3
    feedback[3] = feedback[0] + feedback[1] + feedback[2]; // Add all the results together
    feedback[4] = feedback[3] / 3; // Get average of all results
    JOptionPane.showMessageDialog(null, "Your average feedback rating for Flappy Bird [Processing Edition] is:  " +feedback[4], "Flappy Bird", JOptionPane.PLAIN_MESSAGE); // Display average feedback
    JOptionPane.showMessageDialog(null, "Have a good day! See you again!", "Flappy Bird", JOptionPane.PLAIN_MESSAGE); // Display thank you message
    exit(); // Close the program
  }
}
