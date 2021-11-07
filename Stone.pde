float PIXELS_METER_RATIO = 0.7 * WINDOW_HEIGHT;

class Stone {

    public Transform transform = new Transform();
    public RigidBody rigidBody = new RigidBody(transform);

    private float m_radius;
    private float m_halfHeight;

    private boolean changedVelocity = false;

    public void Update(float dt, Settings settings) {
        PVector[] basisVectors = transform.GetBasisVectors();

        PVector highestPoint = PVector.add(
            PVector.add(
                PVector.mult(basisVectors[0], 1 * m_radius),
                PVector.mult(basisVectors[1], 1 * m_halfHeight)),
            transform.position);
        
        if (highestPoint.y <= 0 )
        {
            // stone is submerged...
            rigidBody.AddDragCylinder(settings.liquidDensity, m_radius);
            rigidBody.Update(dt);
            return;
        }
    
        rigidBody.AddDragCylinder(0.00122, m_radius);

        PVector lowestPoint = PVector.add(
            PVector.add(
                PVector.mult(basisVectors[0], -1 * m_radius),
                PVector.mult(basisVectors[1], -1 * m_halfHeight)),
            transform.position);

        if (lowestPoint.y <= 0) {
            if (!changedVelocity) {
                OnWaterCollision(lowestPoint);
                skipCount++;
            }
        } else {
            changedVelocity = false;
        }

        rigidBody.Update(dt);
    }

    public void OnSettingsUpdate(Settings settings) {
        transform.rotation = radians(settings.stoneAngle);
        m_radius           = settings.stoneRadius;
        m_halfHeight       = settings.stoneThickness / 2.0;
        rigidBody.mass     = (settings.stoneDensity / 1000 * 1000000) * PI * settings.stoneRadius * settings.stoneRadius * settings.stoneThickness;
    }

    public void Draw() {
        stroke(255, 0, 0);
        fill(220);
        
        PVector screenPosition = getScreenPosition();
        
        pushMatrix();
        translate(screenPosition.x, screenPosition.y);
        rotate(-transform.rotation);
        rectMode(RADIUS);
        rect(0, 0, m_radius * PIXELS_METER_RATIO, m_halfHeight * PIXELS_METER_RATIO);
        popMatrix();
    }

    public PVector getScreenPosition() {
        return new PVector(transform.position.x * PIXELS_METER_RATIO,
                 WINDOW_HEIGHT - (transform.position.y * PIXELS_METER_RATIO + WINDOW_HEIGHT * 0.3));
    }

    public void OnWaterCollision(PVector lowestPoint) 
    {
        float beta = atan(abs(rigidBody.velocity.y / rigidBody.velocity.x));
        float vxout = rigidBody.velocity.mag() * cos(beta + transform.rotation) * cos(transform.rotation);
        float vyout = rigidBody.velocity.mag() * cos(beta + transform.rotation) * sin(transform.rotation); 
        
        if (((sq(vyout) - 2 * 9.81 * (m_radius * sin(transform.rotation) + (settings.minimumSkipHeight/100))) < 0) ||
            vxout < 0) {
            changedVelocity = true;
            return;
        }

        vyout = sqrt(sq(vyout) - 2 * 9.81 * m_radius * sin(transform.rotation));
        rigidBody.velocity = new PVector(vxout, vyout);
        
        changedVelocity = true;
    }
}
