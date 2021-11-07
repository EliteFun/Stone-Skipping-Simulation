class Transform {
    public PVector position;
    public float   rotation; // stored in radians

    public Transform() {
        position = new PVector(0, 0);
        rotation = 0.0f;
    }

    public Transform(float x, float y, float deg) {
        position = new PVector(x, y);
        rotation = radians(deg);
    }

    public PVector[] GetBasisVectors() {
        PVector i = new PVector(cos(rotation), sin(rotation));
        PVector j = new PVector(cos(rotation + HALF_PI), sin(rotation + HALF_PI));

        return new PVector[] { i, j };
    }
}
