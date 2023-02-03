Creating systems of particles with shaders is challenging due to the fact that the state of neighboring particles can't easily be accessed (due to the stateless/memoryless 
nature of threads on the GPU). A workaround attempted here is to control each aspect of the sketch with a dedicated periodic function (either a sine, cosine or a triangle 
wave).
