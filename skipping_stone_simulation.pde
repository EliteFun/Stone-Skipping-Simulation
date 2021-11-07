import controlP5.*;

// UI Elements
ControlP5 cp5;
Button playButton;
Button pauseButton;
Button resetButton;
Slider simulationSpeedSlider;
 
Settings   settings   = new Settings();
Simulation simulation = new Simulation(settings);

int previousFrameTime = 0;

// These should be constant, but whatever...
int WINDOW_WIDTH  = 1200;
int WINDOW_HEIGHT = 800;

int TOP_BUTTON_SIZE   = 32;

void setup() {
    // ---- SETUP WINDOW ----
    size(1200, 800);

    // ---- SETUP UI, FONT & SETTINGS ----
    cp5 = new ControlP5(this);
    settings.Setup(cp5);

    // use same font as cp5
	PFont bitTextFont = new BitFont(CP.decodeBase64(BitFont.standard58base64));
    textFont(bitTextFont);

    setupButtons();

    // ---- RESET CLOCK ----
    previousFrameTime = millis();
}

void setupButtons() {
    // play button
    PImage[] playButtonImages = {
        loadImage("assets/play_button_default.png"),
        loadImage("assets/play_button_over.png"),
        loadImage("assets/play_button_active.png") };
    
    playButton = cp5.addButton("play")
    .setPosition((WINDOW_WIDTH / 2) - (1.5 * TOP_BUTTON_SIZE), 0)
    .setImages(playButtonImages)
    .updateSize()
    .setLabelVisible(false);

    // pause button
    PImage[] pauseButtonImages = {
        loadImage("assets/pause_button_default.png"),
        loadImage("assets/pause_button_over.png"),
        loadImage("assets/pause_button_active.png") };
    
    pauseButton = cp5.addButton("pause")
    .setPosition((WINDOW_WIDTH / 2) - (0.5 * TOP_BUTTON_SIZE), 0)
    .setImages(pauseButtonImages)
    .updateSize()
    .setLabelVisible(false);

    // reset button
    PImage[] resetButtonImages = {
        loadImage("assets/reset_button_default.png"),
        loadImage("assets/reset_button_over.png"),
        loadImage("assets/reset_button_active.png") };
    
    resetButton = cp5.addButton("reset")
    .setPosition((WINDOW_WIDTH / 2) + (0.5 * TOP_BUTTON_SIZE), 0)
    .setImages(resetButtonImages)
    .updateSize()
    .setLabelVisible(false);

    // simulation speed slider
    simulationSpeedSlider = cp5.addSlider("simulation speed")
     .setPosition((WINDOW_WIDTH / 2) - 2 * 32, TOP_BUTTON_SIZE + 16)
     .setSize(4*32, 20)
     .setRange(0.10, 1.5) // values can range from big to small as well
     .setValue(1)
     .setNumberOfTickMarks(15)
     .setColorCaptionLabel(0)
     .setColorTickMark(0);
    simulationSpeedSlider.getCaptionLabel().setSize(16).align(ControlP5.CENTER, ControlP5.TOP_OUTSIDE);
}

void play() {
    simulation.isPaused = false;
}

void pause(){
    simulation.isPaused = true;
}

void reset(int value) {
    simulation.reset();
}

void draw() {
    // ---- HANDLE UI ----
    settings.OnUI();

    if (settings.hasUpdated) {
        simulation.OnSettingsUpdate();
        settings.hasUpdated = false;
    }

    // ---- UPDATE ----
    int newTime       = millis();
    float deltaTime   = (newTime - previousFrameTime) / 1000.0f;

    previousFrameTime = newTime;

    simulation.Update(simulationSpeedSlider.getValue() * deltaTime);

    // ---- RENDER ----
    // clear/set the background to a sky color
    background(117, 250, 255);

    // draw a sun
    fill(255, 255, 0);
    noStroke();
    circle(100, 150, 75);

    
    simulation.Render(deltaTime);
}
