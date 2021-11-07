class Settings {
    public float stoneThickness = 0.01;
    public Slider stoneThicknessSlider; 
    public float stoneRadius = 0.04;
    public Slider stoneRadiusSlider; 
    public float stoneDensity = 2.5;
    public Slider stoneDensitySlider; 
    public float liquidDensity = 1.0;
    public Slider liquidDensitySlider; 
    public float stoneAngle = 17; // degrees
    public Slider stoneAngleSlider;
    public float launchHeight = 0.5;
    public Slider launchHeightSlider;
    public float initVelocityX = 10.0;
    public Slider initVelocityXSlider; 
    public float initVelocityY = 0.0;
    public Slider initVelocityYSlider; 
    public float minimumSkipHeight = 0.5;
    public Slider minimumSkipHeightSlider;

    public boolean hasUpdated = true;

    private ControlP5 cp5;

    public void Setup(ControlP5 _cp5) {   
        cp5 = _cp5;
        SetupSliders();
    }

    public void SetupSliders(){
        stoneThicknessSlider = cp5.addSlider("stone thickness [m]: ")
        .setPosition(WINDOW_WIDTH - 175, 25)
        .setSize(150, 20)
        .setRange(0.005, 0.06)
        .setColorCaptionLabel(0)
        .setValue(0.01);
        stoneThicknessSlider.getCaptionLabel().setSize(16).align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER);

        stoneRadiusSlider = cp5.addSlider("stone radius [m]: ")
        .setPosition(WINDOW_WIDTH - 175, 50)
        .setSize(150, 20)
        .setRange(0.01, 0.1)
        .setColorCaptionLabel(0)
        .setValue(0.04);
        stoneRadiusSlider.getCaptionLabel().setSize(16).align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER);

        stoneDensitySlider = cp5.addSlider("stone density [g/cm3]: ")
        .setPosition(WINDOW_WIDTH - 175, 75)
        .setSize(150, 20)
        .setRange(0.5, 4)
        .setColorCaptionLabel(0)
        .setValue(2.5);
        stoneDensitySlider.getCaptionLabel().setSize(16).align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER);
        
        liquidDensitySlider = cp5.addSlider("liquid density [g/cm3]: ")
        .setPosition(WINDOW_WIDTH - 175, 100)
        .setSize(150, 20)
        .setRange(0.6, 3)
        .setColorCaptionLabel(0)
        .setValue(1);
        liquidDensitySlider.getCaptionLabel().setSize(16).align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER);

        stoneAngleSlider = cp5.addSlider("stone angle [deg]: ")
        .setPosition(WINDOW_WIDTH - 175, 125)
        .setSize(150, 20)
        .setRange(0, 45)
        .setColorCaptionLabel(0)
        .setValue(17);
        stoneAngleSlider.getCaptionLabel().setSize(16).align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER);

        launchHeightSlider = cp5.addSlider("launch height [m]: ")
        .setPosition(WINDOW_WIDTH - 175, 150)
        .setSize(150, 20)
        .setRange(0.1, 2.2)
        .setColorCaptionLabel(0)
        .setValue(0.5);
        launchHeightSlider.getCaptionLabel().setSize(16).align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER);

        initVelocityXSlider = cp5.addSlider("initial velocity x [m/s]: ")
        .setPosition(WINDOW_WIDTH - 175, 175)
        .setSize(150, 20)
        .setRange(0.0, 20.0)
        .setColorCaptionLabel(0)
        .setValue(10.0);
        initVelocityXSlider.getCaptionLabel().setSize(16).align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER);

        initVelocityYSlider = cp5.addSlider("initial velocity y [m/s]: ")
        .setPosition(WINDOW_WIDTH - 175, 200)
        .setSize(150, 20)
        .setRange(0.0, 10.0)
        .setColorCaptionLabel(0)
        .setValue(0.0);
        initVelocityYSlider.getCaptionLabel().setSize(16).align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER);

        minimumSkipHeightSlider = cp5.addSlider("minimum skip height [cm]: ")
        .setPosition(WINDOW_WIDTH - 175, 225)
        .setSize(150, 20)
        .setRange(0.0, 2.0)
        .setColorCaptionLabel(0)
        .setValue(0.5);
        minimumSkipHeightSlider.getCaptionLabel().setSize(16).align(ControlP5.LEFT_OUTSIDE, ControlP5.CENTER);
    }


    public void OnUI() {
        if (stoneThickness != stoneThicknessSlider.getValue()) {
            stoneThickness = stoneThicknessSlider.getValue();
            hasUpdated = true;
        }
        if (stoneRadius != stoneRadiusSlider.getValue()) {
            stoneRadius = stoneRadiusSlider.getValue();
            hasUpdated = true;
        }
        if (stoneDensity != stoneDensitySlider.getValue()) {
            stoneDensity = stoneDensitySlider.getValue();
            hasUpdated = true;
        }
        if (liquidDensity != liquidDensitySlider.getValue()) {
            liquidDensity = liquidDensitySlider.getValue();
            hasUpdated = true;
        }
        if (stoneAngle != stoneAngleSlider.getValue()) {
            stoneAngle = stoneAngleSlider.getValue();
            hasUpdated = true;
        }
        if (launchHeight != launchHeightSlider.getValue()) {
            launchHeight = launchHeightSlider.getValue();
            hasUpdated = true;
        }
        if (initVelocityX != initVelocityXSlider.getValue()) {
            initVelocityX = initVelocityXSlider.getValue();
            hasUpdated = true;
        }
        if (initVelocityY != initVelocityYSlider.getValue()) {
            initVelocityY = initVelocityYSlider.getValue();
            hasUpdated = true;
        }
        if (minimumSkipHeight != minimumSkipHeightSlider.getValue()) {
            minimumSkipHeight = minimumSkipHeightSlider.getValue();
            hasUpdated = true;
        }
    }
}
