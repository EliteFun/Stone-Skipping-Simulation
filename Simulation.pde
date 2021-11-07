int skipCount;

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

    public void Render() {
        stroke(255);
        fill(73, 7, 229);
        rectMode(CORNER);
        rect(-1, (WINDOW_HEIGHT * 0.7), WINDOW_WIDTH + 1, WINDOW_HEIGHT * 0.3);

        stone.Draw();

        fill(0);
        text("Skips: " + skipCount, 25, 25);
        text("Simulation time: " + simulationTime, 25, 50);
    }

    private float simulationTime = 0.0f;
}
