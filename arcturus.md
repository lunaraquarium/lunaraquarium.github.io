---
title: Arcturus
---

If my current journey is crossing the Sahara, Arcturus was my journey to Tangier. Between 2020 and 2022, I experimented with [p5.js](https://p5js.org) as a means of visualizing certain physical and mathematical phenomena that I found interesting. This was also a particularly itinerant time in the larger story of my life, and my intial resolve to continue experimenting was quickly challenged by the multiple moves and adjustments to new environments during this era.  Six of these experiments can be seen [here.](https://duck-triad.github.io/arcturus/)


### p5.js: Why I liked it + Why I stopped using it (for now)


In terms of beginner accessibility, the ease of setting up sketches and the latitude to create a deep range of 2-D visualizations, p5.js is easily one of the best toolkits out there. However, the CPU-based + single-threaded nature of p5.js makes per-pixel operations *extremely slow*. As I ventured deeper into the forest of graphical programming, I eventually [reached the limit](https://duck-triad.github.io/arcturus/ent_4/ikeda.html) of p5's CPU-based rendering capabilities. This is what ultimately drew me to shaders, as the multi-threaded + GPU-based nature of their execution allow for *much, much* faster per-pixel manipulations. Unfortunately, p5's support for shaders (while existent) is quite messy and not readily accessible to novices, which is why I have switched over to [three.js](https://threejs.org/), a framework that offers a much greater level of control over graphics/rendering. This will be my "base framework" for now, though it would be neat to apply vertex and fragment shaders to some of the old Arcturus sketches if/once support for shaders in p5.js is radically improved.

