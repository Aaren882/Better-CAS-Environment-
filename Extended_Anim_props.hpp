//- Can't be inherited
class Extended_Anim_transform
{
    class Spring_Example
    {
        type = "spring";
        mass = 1; //- doesn't do anything

        //- points_Count = frameRate * duration;
        duration = 1;
        frameRate = 80; //- how many points within "duration" sec

        damping = 0.99; //- -0.99 ~ 0.99

        response = 0.6;
        //- frequencyResponse = points_Count * response;

        initialPosition = -1;
        initialVelocity = -0.02;
    };
};