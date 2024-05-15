Every variation on the Game of Life is replete with mesmerizing patterns and structures that seemingly arise from chaos, and this variation ("Geology", S24678/B3578) is no exception. In this sketch, I wished to experiment with a few things:

1. *Convolution* - the idea of transforming a pixel's behavior based on the state of its neighbors is a powerful concept that lies at the heart of the Game of Life and other schemes for generating "automata-esque" behavior. In biology, cellular mechanisms for sensing environmental changes (such as bacterial quorum sensing, chemotaxis, paracrine signaling, etc), integrating responses and making decisions (as in neuronal action potentials) can be thought of as convolution operations that form the basis of higher-order behaviors that we attribute to life-forms. This sketch implements a very basic form of convolution (searching around a Moore neighborhood using a sampler2D uniform and texture2D) - I aim to explore this concept further in future sketches. 
2. *Ping-Pong Rendering* - this is something I've used in the last few sketches, and is a neat way of storing and accessing pixel states using shaders (which is otherwise a very challenging, if not impossible, thing to do since shader programs are memoryless by definition). Something I haven't tried yet is to use shaders and off-screen buffers to calculate parameters used by the main simulation and display shaders (i.e. a dedicated fragment shader to compute pheromone trails, which are stored in a texture and accessed by the simulation shader), and this is something to be explored in a future sketch.
3. *Interactivity* - this is the first sketch in which the simulation phase can be manipulated using the mouse , and this opens a whole new world of possibilities. Mouse events are detected using the CPU in the JS program, which then passes on coordinate and click information to the simulation shaders via uniforms. Touch interactivity is not yet supported, though this is something I'd like to fix soon.
