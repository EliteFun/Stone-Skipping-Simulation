int skipCount = 0;

float scale  = 1.0;
float logScale = 0.0;
float minLogScale = -5.0;
float maxLogScale =  5.0;
float scaleVelocity = 0.01f;
boolean canPan = true;
PVector pan = new PVector(0, 0);


void mouseDragged() {
    pan.add(PVector.sub(new PVector(mouseX, mouseY), new PVector(pmouseX, pmouseY)));
    // make sure we can't pan when changing the slider values

 // if ((mouseX >= (WINDOW_WIDTH / 2) - 2 * 32 && mouseX <= (WINDOW_WIDTH / 2) + 2 * 32)
 //     && (mouseY >= 32 + 16 && mouseY <= 32 + 20 + 36)) {
 //     return;
 // }
    
}

void mouseWheel(MouseEvent event) {
    logScale = constrain(logScale + event.getCount() * -1 * scaleVelocity, minLogScale, maxLogScale);
    float prevScale = scale;
    scale = (float) Math.pow(2, logScale);

    PVector mousePos = new PVector(mouseX, mouseY);
    pan = PVector.add(mousePos, PVector.mult(PVector.sub(pan, mousePos), scale / prevScale));
}

class Simulation {

    public Stone stone = new Stone();
    public boolean isPaused = true;
    public Settings settings;

    public Simulation(Settings _settings) {
        settings = _settings;

        reset();
    }

    public void reset() {
        stone.transform.position = new PVector(0, settings.launchHeight);
        stone.transform.rotation = radians(settings.stoneAngle);
        stone.rigidBody.velocity = new PVector(settings.initVelocityX, settings.initVelocityY);

        simulationTime = 0.0f;
        isPaused       = true;
        skipCount      = 0;

        pan = new PVector(0, 0);
    }

    public void OnSettingsUpdate() {
        stone.OnSettingsUpdate(settings);

        if (stone.transform.position.x <= 0)
            stone.transform.position = new PVector(0, settings.launchHeight);
    }

    public void Update(float dt) {
        int samplesPerSecond = ceil(125 / simulationSpeedSlider.getValue());

        if (!isPaused) {
            simulationTime += dt;
            float samplesThisFrame = ceil(dt * samplesPerSecond);
            for (int i = 0; i < samplesThisFrame; i++) {
                stone.Update(1.0 / samplesPerSecond, settings);
            }
        }
    }
    
    public void Render(float dt) {
        // TODO: adapt these with scale
        if (stone.getScreenPosition().x + pan.x >= WINDOW_WIDTH * 0.8) {
            pan.x -= ((stone.getScreenPosition().x + pan.x) - WINDOW_WIDTH * 0.8);
        }

        if (-pan.x >= WINDOW_WIDTH * 14) {
            pan.x = -WINDOW_WIDTH * 14;
        } else if (-pan.x <= -WINDOW_WIDTH * 5) {
            pan.x = WINDOW_WIDTH * 5;
        }
        if (-pan.y >= WINDOW_HEIGHT * 1.5) {
            pan.y = -WINDOW_HEIGHT * 1.5;
        } else if (-pan.y <= -WINDOW_HEIGHT * 2) {
            pan.y = WINDOW_HEIGHT * 2;
        }

        pushMatrix();

        translate(pan.x, pan.y);
        scale(scale);

        stroke(255);
        fill(73, 7, 229);
        rectMode(CORNER);
        rect(-5*WINDOW_WIDTH, (WINDOW_HEIGHT * 0.7), WINDOW_WIDTH * 20, WINDOW_HEIGHT * 3);

        stone.Draw();
        popMatrix();

        fill(0);
        textSize(20);
        text("SKIP COUNT: " + skipCount, 25, 25);
        text("SIMULATION TIME: " + String.format("%.2f", simulationTime), 25, 50);
    }

    private float simulationTime = 0.0f;
}
