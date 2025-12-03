class Extended_Anim_transformation
{
    class Spring_Example
    {
        type = "spring";
        mass = 1; //- doesn't do anything

        //- points_Count = frameRate * duration;
        duration = 1;
        frameRate = 80; //- how many frames within a second

        damping = 0.99; //- -0.99 ~ 0.99

        response = 0.6;
        //- frequencyResponse = points_Count * response;

        initialPosition = -1;
        initialVelocity = -0.02;
    };
    class ATAK_Toggle_Spring: Spring_Example
    {
        duration = 0.65;
        frameRate = 120;
        response = 0.5;
    };
    class ATAK_Toggle_Fast_Spring: ATAK_Toggle_Spring
    {
        duration = 0.45;
    };
};
