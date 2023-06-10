The classic Lorenz system, simulated here with 40000 particles. This sketch uses a system of shaders that compute the next state of the attractor ("simulation shaders") and shaders that
retrieve these positions to render particles ("rendering shaders"). The key step is to swap the buffer of computed position values out with another buffer at each frame ("ping-pong"),
thus allowing the previous state to be accessed by the shaders (which neatly contradicts the "memoryless/stateless" perception of GPU programs!). 
