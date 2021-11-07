class RigidBody {
    public PVector acceleration = new PVector(0, 0);
    public PVector velocity     = new PVector(0, 0);
    public float   mass         = 1.0f; // kg

    public Transform transform;

    public RigidBody(Transform _transform) {
        transform = _transform;
    }

    public void Update(float dt) {
        acceleration.y -= 9.81f;
        velocity.add(PVector.mult(acceleration, dt));
        transform.position.add(PVector.mult(velocity, dt));

        acceleration = new PVector(0, 0); // reset acceleration    
    }

    public void AddDragCylinder(float fluidDensity, float radius) {
        float dragForce = 0.5 * 1.15 * (fluidDensity / 1000 * 1000000) * PI * sq(radius) * sq(velocity.mag());
        PVector dragForceDirection = PVector.mult(PVector.div(velocity, velocity.mag()), -1);
        AddForce(PVector.mult(dragForceDirection, dragForce));
    }

    public void AddForce(PVector force) {
        acceleration.add(PVector.div(force, mass));
    }
}
